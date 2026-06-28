Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A90C43458
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Jun 2026 22:01:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B4D9601EF;
	Mon, 29 Jun 2026 00:01:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B4D9601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782684078;
	bh=G9xsGgrtIkp+Fg+VIan6tyx+WkvxAf2eS4LhZEp/m7o=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=q7SXxsfSAlNZWwx/n65RWpiKfCnnhwvfJych0BPKtAAbnEPBUi99Mut62PrRbMpQw
	 KanTHhFI+sRDP3qVaFpV5yLLYqMXLgDVBKDH3Mf9csjtk6VW3IiJS4h8VJ1Z1iL852
	 JtNvCOj0JRi0jo4P20J/GgP6Ez1sJWbBpSNHWfhA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 56AA3F80600; Mon, 29 Jun 2026 00:00:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A3E47F805FF;
	Mon, 29 Jun 2026 00:00:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CB8ADF805D6; Mon, 29 Jun 2026 00:00:31 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782684030;
	b=FTtUR+twC7Gm7OOgoAdfcO1fA3kMPM9QJ1fDzPjVWQmMGl2Zmhbbo7cci0O4yHaN4Bhm
	 wkklSMd4Qk2o0/Uw4uqLEWYtLGUkn80YjVGgxN60TrhuB7SnmCCIF0bjUDuWMJKeijmLJ
	 a8P63baFFb34TSmEg44q/CAEN5v/PdJPlwx2c1KXpiWuiQahJxGfLEROKihHpfCkWWbjj
	 mS6FL1fyghGRFhQXH8Yl/2Acyr1gIafynokGRWEKoBV6R959+9Q86nxb/2LrSrvA5lRFH
	 nVA+BUcHPwWgxa4aO9oTrGCi0XKeSr1uuKgplSLF5KhdYE7DR/UOWrGKFmyTS6Iz7VA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782684030;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=G9xsGgrtIkp+Fg+VIan6tyx+WkvxAf2eS4LhZEp/m7o=;
	b=K8tKyfcVvZj6DdXv/MA/PJZ3BWkq2H6K8dtLcpmSBZnO7tPIYxXfG87bsB198salKSa8
	 8vNrSMydIYpe5YNJ8FEh/y1sAWDQGncy+0MA5muYTN7yhTPLKBnzrKFnNpNgmXSSumrb/
	 ejUgDKnhShPJDIZJaGEaPk5YbFJpTab+pvZbdlI+PnSqBIA69fMuPVQW5oK4QCx3TAPPD
	 sMj7E/ECVIen/I03+I6TraAxU04Zczp/yLOOSItfH/ym0W6xLNzaCo/XPu5Olfk6VCoWd
	 F6AGw0ntZvJYYbS4+Rm9cC0LE90xVoXJFJuDP2rYRJbuqKeVIJqbj5Jus5EgEOWg3vg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 967B9F80212
	for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2026 00:00:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 967B9F80212
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bd5dadf0facb00-webhooks-bot@alsa-project.org>
In-Reply-To: <18bd5dadf0d1b400-webhooks-bot@alsa-project.org>
References: <18bd5dadf0d1b400-webhooks-bot@alsa-project.org>
Subject: Steinberg UR44C (0499:1730) incorrectly matched to UR44 UCM profile
 (PlaybackChannels mismatch)
Date: Mon, 29 Jun 2026 00:00:31 +0200 (CEST)
Message-ID-Hash: S3MCPU37Z2ELQXJANHCUYIXSSD7RKNWJ
X-Message-ID-Hash: S3MCPU37Z2ELQXJANHCUYIXSSD7RKNWJ
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S3MCPU37Z2ELQXJANHCUYIXSSD7RKNWJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #799 was opened from abentley:

Note: Google AGY wrote this, but I have manually verified all claims.

The Steinberg UR44C (USB ID  0499:1730 ) is currently matched to the  Steinberg/UR44  UCM profile in  ucm2/USB-Audio/USB-Audio.conf  via the following rule:
                                                                                                                                                                     
   If.steinberg-ur44 {
       Condition {
           Type RegexMatch
           String "${CardComponents}"                                                                                                                                
           Regex "USB0499:17((00)|(30)|(04))"
       }
       True.Define.ProfileName "Steinberg/UR44"
   }

However, the UR44 UCM profile defines  PlaybackChannels=4  (since the original UR44 only has 4 output channels).
The UR44C hardware actually exposes 6 playback channels (as confirmed by  /proc/asound/cardX/stream0 ):
   Playback:
     Interface 1
       Altset 1
       Format: S32_LE
       Channels: 6

This mismatch causes WirePlumber/PipeWire to fail to load the UCM profile with the following validation error:

   spa.alsa: Error in ALSA UCM profile for _ucm0003.hw:UR44C,0 (HiFi: Line2: sink): PlaybackChannels=4 < avail 6
   spa.alsa: Errors in ALSA UCM profile for card Steinberg UR44C

Suggested Fix:
Exclude the UR44C product ID ( 1730 ) from the  steinberg-ur44  regex condition so it falls back to standard ALSA Card Profiles (ACP) instead of attempting to load  the incompatible UR44 UCM profile.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/799
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
