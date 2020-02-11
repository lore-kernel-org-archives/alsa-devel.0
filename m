Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC32C35242
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 05:06:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549F82070A
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 05:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="u3U6fKZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549F82070A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 967A01657;
	Tue, 11 Feb 2020 06:05:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 967A01657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581397592;
	bh=N/l2PvXax0qV8/LibnM85n08AZg6tvTDPdDyWxsQnj4=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u3U6fKZxyZ6E2DOpj0JRS8KCMZ/Mm61VjqxoT3OwZ0EqbmalDcZVQmFPBkNDB4yuH
	 +zIkkhxXOPe5q3lmcT5sJGOOvitABm/DMkFqENUoe+R1EDb7E6FZAJ7eZ2MGB7juK8
	 pwmno6DA6vNlvHBNcJcKX0mJTqHgrtNp7GXc8P1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27D59F8013E;
	Tue, 11 Feb 2020 06:05:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B31CF80145; Tue, 11 Feb 2020 06:05:40 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id CFD80F8013D
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 06:05:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFD80F8013D
MIME-Version: 1.0
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1581397537170270920-webhooks-bot@alsa-project.org>
References: <1581397537170270920-webhooks-bot@alsa-project.org>
Message-Id: <20200211050540.8B31CF80145@alsa1.perex.cz>
Date: Tue, 11 Feb 2020 06:05:40 +0100 (CET)
Subject: [alsa-devel] broadwell-rt286: more conformance and other fixes
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #12 was edited from dpward:

Remove JackHWMute, because the hardware does not forcibly shut off the internal speakers or microphone when the jack is in use.

The CaptureMixerElem and CaptureMasterElem devices were swapped. Do not manually set the "ADC0 Capture Switch" when disabling a capture device; it will be set automatically instead.

Correct "Handset" to "Headset". Apply maximum gain to the headset microphone ("AMIC Volume") when in use, based on testing.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/12
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/12.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
