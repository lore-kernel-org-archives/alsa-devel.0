Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC6BC43458
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jul 2026 10:19:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63DA560226;
	Sun,  5 Jul 2026 12:18:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63DA560226
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783246748;
	bh=fbQBwoI6uEy55w34MMC39fVQyAnOEVE8dhVsi7pyjE4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=BNgjev+APQ+Yq8NeDo1repFMtijPSiJBjYPgsXY1BB2VdRhY9s0330u9KUjH9TdLC
	 9//gzNQ7Ct361HuS2NnelewzZsAiD50ur0gIYppybAkCdsofxLs6n9SSPKujr7BC6F
	 waw+VfofWvU5EBoL7SjbQ9zRQ/yPVM3ZivV8SVZ0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A687FF80601; Sun,  5 Jul 2026 12:18:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 584F7F80601;
	Sun,  5 Jul 2026 12:18:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7DFDF80526; Sun,  5 Jul 2026 12:18:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783246704;
	b=sJ+gB/ijknAldEcTbyZrfO/2lkMYSIC+SFA05bNtMqTlNrccMT5bfJj6Ty6bxZ/sYZyh
	 mu5OExPomZiJAaRwbpUVMy8PywQ3QTsn/juMunvybgw0JoV7VZ7uXVRIHPIOBFgRjLS/U
	 9Hw0oNO07Dh5x5psKG4nRTmU2mGzmO20HOfHPNpvg1bZJvZu1Y61sdpkuQRE6d9uFDkyB
	 tUBcRwl5bNB7GmVIJafvogQZ4DVJ1sopUp/reHxZj27jJZ0TjM9TgMX9IyDJvF3j5YZkh
	 PTfHney1yv9vilO3tgmwEZ4nzZtZrkqYHSKIJWUDnrSo4Kfq0wRnNxfz99kcC1jJ35A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783246704;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=fbQBwoI6uEy55w34MMC39fVQyAnOEVE8dhVsi7pyjE4=;
	b=FnPN2QilPs5+SXNdyaJbaBKp6uy5kC2KuO3PPWqDbP91vxFnN3e1eS54Jzfildvd0cea
	 wZ0OqMXOaL4UWpCHSscMBZ7OBKeTixyVp6rCVHID6znFxXdp/HOQ7p3Svf5ewfdN+DVn2
	 IwbE/n9P/zkm9UgekxICx9oxz3OqBq3dNxDKPC36Q3JmkOeYHSZ8FKkvgAGIRvMZ19GbT
	 OooBwBFiP4HZPjxXEquPhhwcYOytOW3YxNhrgsg0WtEa01mKkS1Gfw/UXx99zC073D1YU
	 BZcyRzoIwewy0YfOHdIJUlwOTIRrseFy9n2NeEja3n5/YdW+QXIeMjqVKgBELyZE/VQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 834D1F80524
	for <alsa-devel@alsa-project.org>; Sun,  5 Jul 2026 12:18:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 834D1F80524
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bf5d6dac411300-webhooks-bot@alsa-project.org>
In-Reply-To: <18bf5d6dac381b00-webhooks-bot@alsa-project.org>
References: <18bf5d6dac381b00-webhooks-bot@alsa-project.org>
Subject: sof-soundwire: cs42l43 headphone output is muted due to missing
 Headphone Switch in UCM
Date: Sun,  5 Jul 2026 12:18:25 +0200 (CEST)
Message-ID-Hash: ZO32ZJYT66LPXNAG4MGVYSA37OKED7ZK
X-Message-ID-Hash: ZO32ZJYT66LPXNAG4MGVYSA37OKED7ZK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZO32ZJYT66LPXNAG4MGVYSA37OKED7ZK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #804 was edited from Natializd:

Hi,
    
    I'm using a Dell Pro Max 16 Plus (Intel 800 Series ACE / cs42l43
    codec via SoundWire) running Ubuntu 26.04 with kernel 7.0.0-27-generic.
    
    When booting up or logging in with headphones plugged in, I get no
    sound output. The desktop environment shows that headphones are
    selected and unmuted, but there is complete silence.
    
    Checking the mixer status using amixer shows that the "Headphone Switch"
    control on card 1 remains off:
    $ amixer -c 1 cget name='Headphone Switch'
    numid=90,iface=MIXER,name='Headphone Switch'
      ; type=BOOLEAN,access=rw------,values=1
      : values=off
    
    If I manually toggle it on, sound starts working immediately:
    $ amixer -c 1 cset name='Headphone Switch' on
    
    The root cause is that `/usr/share/alsa/ucm2/sof-soundwire/cs42l43.conf`
    is missing mappings for the Headphone Switch in both the sequences
    and values.
    
    I manually edited the configuration file under SectionDevice."Headphones"
    from this:
    
    
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


    After restarting PipeWire/WirePlumber, the operating system now
    correctly manages the hardware switch automatically and the audio
    works on boot/login.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/804
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
