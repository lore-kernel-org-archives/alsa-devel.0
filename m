Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEE5C43458
	for <alsa-devel@archiver.kernel.org>; Sun, 28 Jun 2026 22:02:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 225F3601F0;
	Mon, 29 Jun 2026 00:02:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 225F3601F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782684173;
	bh=eduILp3nUFA5DhesEmiU3oMk5+h5SvqFlRnYv3yxFRc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=d4zR2JUPYHK56pyc/uufw63bE6iOevYZjIp6XJcZC562f8oG0R5cfeFxIISmjVYOr
	 yYPOQIA4EmhVZeFRlsuaVK188E3VaDtRWkS3mFsK8chT/UPVylfprXJAHV6hCz5fkc
	 6u725JKUne03MFlvJfbGehYb4inTyDCy0HWhegDE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C8E1F805FE; Mon, 29 Jun 2026 00:02:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BF4DAF805F6;
	Mon, 29 Jun 2026 00:02:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1C916F80448; Mon, 29 Jun 2026 00:02:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782684128;
	b=emIo1XZPEZ3n/q8wfkem9VnwetkZifCBA0lPjzV6nloHVaKRcO3NapDZPdP3H8Qlgvko
	 H+4SGNIbPI2QrHWXER0GHJvg14hJO9bWyIwmlcaYtXhfDQIR1turrfA1UjozKo05g1KCQ
	 3PR/E7zZ/RKX/sQ0biRuuvigHvcYiX2Cy1CaSthvPI/e9iEzD/eS0Jc308uLrEWQwat7g
	 3eK6C8Q6Yt5kD0Oc0j17eJFdbceQsUjU01hGicNTZQYjIMPcL8i8qb6uhWuyyghY50eNG
	 6Jpq+0x7tVHCV25wHvwuoVtDPzxJKmlK/kFQjBXz7kf/hpOlE2XucayXl7FDXZoYhmw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782684128;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=eduILp3nUFA5DhesEmiU3oMk5+h5SvqFlRnYv3yxFRc=;
	b=JjDdWEOXvRWVy0ZYBBSmLTW1dlnWOQrZpWJPS0QmV8p9rLv+NYDWqizN2meQt4eNwzFW
	 XTZayWqy2oOeXw4x22MQ9+2Mn2aS/LzIRvCz419SXLG83tldkzQn28fpGDi4UwSKEhjFL
	 KckKBLwfROAqgS0JJnrqhbSQZoxiqila2/EIvthvYzhS/RnOFqkMt7rx0Ywh5sJ8FWDNR
	 l0mlpdko5MOzrivPVXqWyomooPG3rMMxu3oaLe96//PCd1fS/jWr1FZH6nse/vHM8+niG
	 jiO+idPqn1S3FBjmllcwjq6MKtGNe1Jd1OXILy9pbJobmMmhD+7p1mcCj6UvMu2JQSA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 095C6F80095
	for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2026 00:02:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 095C6F80095
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bd5dc4b2a8b400-webhooks-bot@alsa-project.org>
In-Reply-To: <18bd5dc4b29a8500-webhooks-bot@alsa-project.org>
References: <18bd5dc4b29a8500-webhooks-bot@alsa-project.org>
Subject: Steinberg UR44C (0499:1730) incorrectly matched to UR44 UCM profile
 (PlaybackChannels mismatch)
Date: Mon, 29 Jun 2026 00:02:09 +0200 (CEST)
Message-ID-Hash: BHBCOOZFESILZXBFGGVMLPX7LWAG7WFE
X-Message-ID-Hash: BHBCOOZFESILZXBFGGVMLPX7LWAG7WFE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BHBCOOZFESILZXBFGGVMLPX7LWAG7WFE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #799 was edited from abentley:

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
