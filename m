Return-Path: <SRS0=jDen=FJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E33CC4361A
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 14:58:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2152F23122
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 14:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2152F23122
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FF501903;
	Sat,  5 Dec 2020 15:57:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FF501903
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607180317;
	bh=gHmD1yvCiyKKEPPsdh0lGfPx+WJohMg/y9jG3T7udJ0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q0h6W1E8G/FAP9gx/lP1KcEgnJKlnd5/djGAIgR0EZ8VhJc2Vnt/gOdyzuCZqVgJ9
	 d4uvFS0FqlKv3rqTKus19v6mG7JDAfCTF6bqORmHL+Y420c2jW/WE7RBU9LubuyfWS
	 3+AqaZyztEPBiCGntxpRw/Mr6ouMj9uqqGjMpJhc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85E7CF8016C;
	Sat,  5 Dec 2020 15:57:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 299C9F8016D; Sat,  5 Dec 2020 15:57:45 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 3EDCDF800E8
 for <alsa-devel@alsa-project.org>; Sat,  5 Dec 2020 15:57:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EDCDF800E8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1607180258182641029-webhooks-bot@alsa-project.org>
References: <1607180258182641029-webhooks-bot@alsa-project.org>
Subject: thinkpad t14s amd: unable to control built-in mic and headphones mic
 independently
Message-Id: <20201205145745.299C9F8016D@alsa1.perex.cz>
Date: Sat,  5 Dec 2020 15:57:45 +0100 (CET)
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

alsa-project/alsa-ucm-conf issue #64 was opened from tanuk:

I did some investigation on a [pulseaudio bug report](https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/1067), and found that the UCM configuration for the internal mic and headset mic both use "Capture" as the CaptureMixerElem. This means that muting one device mutes also the other (and I guess volume control is shared too). In amixer output I don't see a separate control for the headset mic, but for the internal mic volume I guess "Digital" can be used (there's no switch, though).

So it seems that these changes are needed:
 - don't set CaptureMixerElem, CaptureSwitch or CaptureVolume for the headset mic
 - set the internal mic CaptureMixerElem and CaptureVolume to Digital
 - you may want to also set CaptureMasterElem for both both mics to Capture

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/64
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
