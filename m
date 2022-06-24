Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7762FC43334
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jun 2022 04:11:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B945D18B3;
	Fri, 24 Jun 2022 06:10:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B945D18B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656043890;
	bh=y8pGtG3PuxLBFVfEwrqIWIDSfEHSUOMrbwQEwPV/guE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JgmP719JuUE2ZXY2jS/mBvl1fEvm+j7wp0wVe97EdQe3dNHojr/Fj7290AZKy2Jko
	 N50LmNBrsqBKzrvgaeU8vmy5sXQHV3uRL+o9hPUyysAIt38Y+I3fE8MQ1couoHpgQo
	 h6Jq6WBGvPwA88Cz3slKcYQfeGo8QH6jAK0Vj/GY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50A32F80137;
	Fri, 24 Jun 2022 06:10:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D481F80139; Fri, 24 Jun 2022 06:10:39 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id D201BF80107
 for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2022 06:10:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D201BF80107
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1656043832025093079-webhooks-bot@alsa-project.org>
References: <1656043832025093079-webhooks-bot@alsa-project.org>
Subject: UCM for Behringer UMC204HD broken
Message-Id: <20220624041039.3D481F80139@alsa1.perex.cz>
Date: Fri, 24 Jun 2022 06:10:39 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #177 was opened from gregory112:

This is related: [https://github.com/alsa-project/alsa-ucm-conf/pull/128](https://github.com/alsa-project/alsa-ucm-conf/pull/128).
I came from this issue I filed in Pipewire: [https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2471](https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2471).

So previously a while back, Behringer UMC204HD was detected as a single stereo input channel. This sound card has two inputs. However, just recently, the channel was separated into two mono channels, which was perfect. However, with the most recent update (I don't know if it's pipewire, pipewire-alsa, alsa-card-profiles, or alsa-ucm), it reverted back into the stereo single input (left/right) mode. What can I do to bring back the previous correct settings (apart from the bugs I filed in Pipewire)? I did not modify any ALSA UCM files.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/177
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
