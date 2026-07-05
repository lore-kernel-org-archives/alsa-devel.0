Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8287C44501
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jul 2026 10:16:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 192256021C;
	Sun,  5 Jul 2026 12:16:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 192256021C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783246579;
	bh=bp1Hm1BeRuztOxUAZgY2thFsv6juaCxQ3yzkyA8zJDw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=WhPK6tTMF95OZcycQBxZtFffGgezyfVW9cJLs2AgvP01o2FyBc9uKZI8dDhK+AjLu
	 nkPLLBzQjENpfYvPkZ+j1LW/NN3vqY2Ku/E+ibXn0DEnS12eqItBxl6iESJm9LcEEz
	 jEh4XDhiqYS1tCQ56XBkrXQ9ITQv95AOoDuOYVQs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 618D7F80602; Sun,  5 Jul 2026 12:15:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F0630F80601;
	Sun,  5 Jul 2026 12:15:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9B8CF80526; Sun,  5 Jul 2026 12:15:39 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783246539;
	b=ddfL06Ge0tU3Ydo3FGSTF6xsBtfB6h2SND0rMRtOGzlU19KtHISvKm9xVDZsKPTImHQ4
	 wQtk18FUy0xeuEweLFXZ51/aMsr3O/py9/QUM0/2VknrOTKziE5gtA3U4kP/+0GHsnZVq
	 +r+yzOkxEvxY/FKcUbucILW6Ff1hvwh+0t8Q+3KqCE8mtUY8dTCLAWPBEpS1g7CYI8SgD
	 adNkZJNggv+QkDt009qRn9kNqs3hgOGY4osy1KmpLWdRiUhe9GFouOCA8Owua/eZJNNZ1
	 ojNbkzRYbe2m+U7jZMUkhZRqzgEZAL1nuW2oh9l1Z8kzfB5GhQ8Pc5GcbBu3vc8eTDw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783246539;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=bp1Hm1BeRuztOxUAZgY2thFsv6juaCxQ3yzkyA8zJDw=;
	b=InldeVioOGHlJMiL1KXqJU7tNBZ+1I72+EN0T3o3+2v1sLv+NGCXU5LsCNF88SM9qbWa
	 eCryp5JrdjWsbNrquvhmJN/URJPLAccmxA1gXUoyTopbrjJDP8w5wdXxLKLqFze1qhC1y
	 ltJLnrV6c1DuqiFX113Wf4B5D3cHyslLrS9KKuhcDTCAXTZ2CP01fDVme4scNEAYbheCb
	 dW9Khy4UXYc+C1yCOvrdrj7gh4DNuCm/TM17+yCQvTm2Iyr+G7HGkKLOPGGSq5EKSvFLX
	 iT/v6XRwEiRqGQFc1QsFVNZlH6hx+KB4x9DNBo/Hm+I9tIOIJbZMY89OnZ5/zOZgAUg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B3F3F80524
	for <alsa-devel@alsa-project.org>; Sun,  5 Jul 2026 12:15:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B3F3F80524
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bf5d4731cec500-webhooks-bot@alsa-project.org>
In-Reply-To: <18bf5d4731a8a700-webhooks-bot@alsa-project.org>
References: <18bf5d4731a8a700-webhooks-bot@alsa-project.org>
Subject: sof-soundwire: cs42l43 headphone output is muted due to missing
 Headphone Switch in UCM
Date: Sun,  5 Jul 2026 12:15:39 +0200 (CEST)
Message-ID-Hash: MRK6DB7BFEGIJE3IYD47DV3OKF5HVEZP
X-Message-ID-Hash: MRK6DB7BFEGIJE3IYD47DV3OKF5HVEZP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MRK6DB7BFEGIJE3IYD47DV3OKF5HVEZP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #804 was opened from Natializd:

Hi,
    
    I'm using a Dell Pro Max 16 Plus (Intel 800 Series ACE / cs42l43 codec via SoundWire) running Ubuntu 26.04 with kernel 7.0.0-27-generic.
    
    When booting up or logging in with headphones plugged in, I get no sound output. The desktop environment shows that headphones are selected and unmuted, but there is complete silence.
    
    Checking the mixer status using amixer shows that the "Headphone Switch" control on card 1 remains off:
    $ amixer -c 1 cget name='Headphone Switch'
    numid=90,iface=MIXER,name='Headphone Switch'
      ; type=BOOLEAN,access=rw------,values=1
      : values=off
    
    If I manually toggle it on, sound starts working immediately:
    $ amixer -c 1 cset name='Headphone Switch' on
    
    The root cause is that `/usr/share/alsa/ucm2/sof-soundwire/cs42l43.conf` is missing mappings for the Headphone Switch in both the sequences and values. 
    
    I manually edited `/usr/share/alsa/ucm2/sof-soundwire/cs42l43.conf` under SectionDevice."Headphones" from this:
    
    
    EnableSequence [
        cset "name='cs42l43 Headphone L Input 1' 'DP5RX1'"
        cset "name='cs42l43 Headphone R Input 1' 'DP5RX2'"
    ]
    
    DisableSequence [
        cset "name='cs42l43 Headphone L Input 1' 'None'"
        cset "name='cs42l43 Headphone R Input 1' 'None'"
    ]

    Value {
        PlaybackPriority 200
        PlaybackPCM "hw:${CardId},0"
        PlaybackVolume "cs42l43 Headphone Digital Volume"
        JackControl "Headphone Jack"
    }


    To this:


    EnableSequence [
        cset "name='cs42l43 Headphone L Input 1' 'DP5RX1'"
        cset "name='cs42l43 Headphone R Input 1' 'DP5RX2'"
        cset "name='Headphone Switch' on"
    ]

    DisableSequence [
        cset "name='cs42l43 Headphone L Input 1' 'None'"
        cset "name='cs42l43 Headphone R Input 1' 'None'"
        cset "name='Headphone Switch' off"
    ]

    Value {
        PlaybackPriority 200
        PlaybackPCM "hw:${CardId},0"
        PlaybackVolume "cs42l43 Headphone Digital Volume"
        PlaybackSwitch "Headphone Switch"
        JackControl "Headphone Jack"
    }


    After restarting PipeWire/WirePlumber, the operating system now correctly manages the hardware switch automatically and the audio works on boot/login.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/804
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
