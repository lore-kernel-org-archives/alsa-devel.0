Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF52DC433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 13:30:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A58220829
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 13:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ou7x1T4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A58220829
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80D2D84D;
	Thu, 13 Aug 2020 15:29:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80D2D84D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597325444;
	bh=LBQZ7Bi9YKo0WHpsmdLmp1kkby9BNXQAKdIx58hU3AQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ou7x1T4s70V1/JPu6fvyVNbfdo55kgNTazVZOeLuz/MfHu2H0l3R5NTT+CV0RnWtF
	 yHuJiDbwTeJvAR9vfHjSXRVw7hDTCYTReTI6cdtNt6ZfOlrD+MNSiy6XO5Y7v0pfQx
	 fM7iHG837mvy7ILJVJxjYNqgGYskm2zuvfwIxlBw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B3FEF8014C;
	Thu, 13 Aug 2020 15:29:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61F57F8015B; Thu, 13 Aug 2020 15:29:51 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B988DF800D3
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 15:29:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B988DF800D3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1597325379999676943-webhooks-bot@alsa-project.org>
References: <1597325379999676943-webhooks-bot@alsa-project.org>
Subject: pcm: dmix: fix access to sum-buffer in non-interleaved mixing mode
Message-Id: <20200813132951.61F57F8015B@alsa1.perex.cz>
Date: Thu, 13 Aug 2020 15:29:51 +0200 (CEST)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-lib pull request #78 was opened from vijaypalaniswamy:

When dmix uses non-interleaved mixing mode the offset and step width
to sum_buffer was calculated by using the dmix channels instead of
the slave channels. This leads to audio distortions due to frame
corruption.

example:
- With below configuratio, Do aplay on both device in parallel for
audio distortion

pcm.dmix_2_channels {
        type dmix
        ipc_key 5678293
        ipc_perm 0660
        ipc_gid audio
        bindings [0 1]

        slave {
                pcm "hardware"
                channels 2
                periods  4
                period_time 40000
        }
}

pcm.dmix_1_channels {
        type dmix
        ipc_key 5678293
        ipc_perm 0660
        ipc_gid audio
        bindings [0]

        slave {
                pcm "hardware"
                channels 1
                periods  4
                period_time 40000
        }
}

pcm.hardware {
        type hw
        card 0
        channels 2
        rate 48000
        format S16_LE
}

Signed-off-by: Vijay Palaniswamy <vijay.palaniswamy@in.bosch.com>

Request URL   : https://github.com/alsa-project/alsa-lib/pull/78
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/78.patch
Repository URL: https://github.com/alsa-project/alsa-lib
