Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2A4D1714E
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2024 01:13:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 56ECFB70;
	Tue, 22 Oct 2024 03:13:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 56ECFB70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1729559623;
	bh=zznZuV5BSYyHPdP10aHlx6qycRdWxJALVq24/p1846M=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fC57UZxo29hJILm4jtu3pT3f+jQoE7Z9Nvf8BGPqFIQTEBrAsAzSuVfEuadDFvLYm
	 T1UVagkEHCXX0AjR2gswJgGwlW0CshNlSVywI3Dt2byLLbl8lSuFWD6GPhBfEGEijh
	 S65FxZAFCVdrHtjJgU0luIHMwZl5EyxYzQvEKTPQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27323F805C6; Tue, 22 Oct 2024 03:13:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C9499F805C3;
	Tue, 22 Oct 2024 03:13:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5FC48F805AB; Tue, 22 Oct 2024 03:12:56 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id B6D33F8016C
	for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2024 03:12:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6D33F8016C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1729559574734588385-webhooks-bot@alsa-project.org>
References: <1729559574734588385-webhooks-bot@alsa-project.org>
Subject: AlSA problem , audio on/off across multiple ubuntu releases
Message-Id: <20241022011256.5FC48F805AB@alsa1.perex.cz>
Date: Tue, 22 Oct 2024 03:12:56 +0200 (CEST)
Message-ID-Hash: BIVX6O2SIGZ2DP2YFE5PBBXKUTHWFQWH
X-Message-ID-Hash: BIVX6O2SIGZ2DP2YFE5PBBXKUTHWFQWH
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BIVX6O2SIGZ2DP2YFE5PBBXKUTHWFQWH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #414 was edited from Kermilli:

Hi, 

I've been having problems with audio on ubuntu on and off. I'm not a professional but everything seems to point at alsa . The pulse troubleshooting page at some point recommends to run alsa directly/bypass pulse with the command `mplayer -ao alsa:device=hw=0 yourchosentrack.mp3`  which  gives 
`[AO_ALSA] alsa-lib: pcm_hw.c:1715:(snd_pcm_hw_open) open '/dev/snd/pcmC0D0p' failed (-2): No such file or directory
[AO_ALSA] Playback open error: No such file or directory
Failed to initialize audio driver 'alsa:device=hw=0'
Could not open/initialize audio device -> no sound.
Audio: no sound
Video: no video
` 
sudo pulseaudio -vvv gives

`E: [pulseaudio] module-alsa-card.c: Failed to find a working profile.
E: [pulseaudio] module.c: Failed to load module "module-alsa-card" (argument: "device_id="1" name="pci-0000_00_1b.0" card_name="alsa_card.pci-0000_00_1b.0" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes avoid_resampling=no card_properties="module-udev-detect.discovered=1""): initialization failed.`

 
I've tried everything . The only time it worked was when I added options snd-hda-intel model=auto to  /etc/modprobe.d/alsa-base.conf. , but even then it stopped working after some time when I was listening to audio.


Any help would be greatly appreciated!

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/414
Repository URL: https://github.com/alsa-project/alsa-lib
