Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C96CD8C89
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:46:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05F6C601D3;
	Sun,  7 Jun 2026 19:46:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05F6C601D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780854373;
	bh=bst9HWLp6O6bMr2Twfe0rR9nZhH+Bm7oR8pFBNqkOyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eltF5ybBW3uebOYd2hssdfrOWvs9adJwxCUuv6DHX0W+GHNYxTY0rfb5LuygpuwI8
	 53Y+S7qpT+Nx6KtMMKfioknx5yf/ruIqfUcYL17OkN6cYul5tUqv3U1rp8tSwKoRQj
	 WGVpLDfZ7NT7bcND9MlSvlsPzJq8DtrvbLm52rf0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57D53F805EF; Sun,  7 Jun 2026 19:45:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 082E5F8055B;
	Sun,  7 Jun 2026 19:45:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7A047F804CC; Thu,  4 Jun 2026 23:19:26 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=213.133.104.36
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780607964;
	b=T7gscUrE2960ee66svhqHMLLR/XvMK1BIH0tRnK6xpvrQ8w3eJV/bm9Q6ypnVdRrqALh
	 7NXjSiumldb2LrZiLA6Lzcs9tojRE9XspemsoqxsbJKLaQgaZANX+M2W8WHrynziBwcUF
	 pVOT02qMvFfgvnQAAI37hdKyodYInNSvIOMCLPGxNDDCOqwfQihdPx/IbIy4ShBRkjBrU
	 qW+2YvGwucV4ekpJi02yqkzLA/sOjKKYkSnPsocLPXsS2UhkEvAz2NH1uFLWb7aSCi/zm
	 c5igtCf06b43hI/b20X0pzCsXCxdLVm4oTF/8sUjKAZfJTZB5ZOHpU5DLj5yMRmw0Hw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780607964;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bst9HWLp6O6bMr2Twfe0rR9nZhH+Bm7oR8pFBNqkOyI=;
	b=obRcC6pFja3nWDvoxy0w14VBVTRCN5cTSvNmIh1zGsQtbU7Yb1u7Hu88b/6hF54fvfaa
	 P+/eI7L5LV7L4jQmebaEftjFKtyvtVKSg3DWaT3wUZZdVJ5rzLjgYbp6z8vWHkFSPQLgc
	 NGDU8Zi0ObOlghu4TY+7Z1ZFDsUbGf4f3+kNjbT2WC5By7Z2eqwCGiDRq3Fj4Bq6AcJD/
	 QZfi3dd6DIx0S+OECi5jWsDbP0Me2z36EoItLOPyA56vuR4TtQqOd+0BJJNTgsAQz889e
	 dLhC9Qcoq0UuNnykpsLrvrznXiAqKrki8jq7dC0gmj737+N9aTCUvmSUYabsRdsOJcQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=hohmatik.de header.i=@hohmatik.de header.a=rsa-sha256
 header.s=default2501 header.b=GFD7Py95;
	arc=none smtp.remote-ip=213.133.104.36
Received: from www36.your-server.de (www36.your-server.de [213.133.104.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A5424F800B0
	for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2026 23:19:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5424F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=hohmatik.de header.i=@hohmatik.de header.a=rsa-sha256
 header.s=default2501 header.b=GFD7Py95
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hohmatik.de
	; s=default2501; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0yeWmXF921K/tHR4x5x8hqJCB+lCy1vsXxr+XO0kv7Q=; b=GFD7Py95S6DyKY4Lk+tJBVG/Yq
	S+15jqoZAbkMN7QChz2ENLD35bg0U8Q1KTTuW9hhGAMHyorTSnF0HJuXfSD9TT0YZOSbEfN7zigK2
	hjv9Waqp647v1M3GPoTlNgkKcBj40bb+idszqOvBmeTeI8pi30QGVhceEspxCgeTolWjsGj/toFqL
	Bk1biW6+5EiY/SlgF1Hgpz0/dC9q9VzhHt7nlyHetlbG/fRDbVSz23Se+jJzlrKvtsMDOvaXA/7OC
	YpMB1YZ7T5pb1iwdxsWkRKl+zXxO5nFU9r6d3BPtP9MNptztSvTaHC25ybXeEAMg1pL2omNoOXfGQ
	noubvM5Q==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www36.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <linux@hohmatik.de>)
	id 1wVFTG-0001nT-1y;
	Thu, 04 Jun 2026 23:19:22 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls
 TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@hohmatik.de>)
	id 1wVFTF-000Jch-1s;
	Thu, 04 Jun 2026 23:19:22 +0200
From: Karsten Hohmeier <linux@hohmatik.de>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	brady725@gmail.com,
	linux@hohmatik.de
Subject: Re: Creative X-Fi hw20k2 (SB0880) that appeared in kernel 6.12.85
Date: Thu,  4 Jun 2026 23:18:28 +0200
Message-ID: <20260604211921.16221-1-linux@hohmatik.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87a4tdyxx4.wl-tiwai@suse.de>
References: <87a4tdyxx4.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28021/Thu Jun  4 08:24:58 2026)
X-MailFrom: linux@hohmatik.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: VBK2EMCLEWAMTY5MSUDRCOL5B6AG5JUP
X-Message-ID-Hash: VBK2EMCLEWAMTY5MSUDRCOL5B6AG5JUP
X-Mailman-Approved-At: Sun, 07 Jun 2026 17:45:33 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VBK2EMCLEWAMTY5MSUDRCOL5B6AG5JUP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello Takashi, hello Cliff,

I have four of those cards in active service on AMD64. I pulled the 6.12.85 tarball from kernel.org and set up a test install with pulseaudio (all my production systems are on pipewire by now).
I played back audio through parole (gstreamer backend) and paplay.
I followed the initial reproduction steps by Cliff of "restarting pulseaudio" by killing the service and starting it again.
This ends the playback for both Parole and paplay with a backend error and confirms that they are actually playing back through pulseaudio.
But resuming the playback also reliably resumes the audio. I could not observe any silent failure on kernel 6.12.85.

Sink is running, access mode is "mmap+timer" as mentioned by Cliff.

--- snip ------------------------------------------------------------------
karsten@forky:~$ pulseaudio --version
pulseaudio 17.0
karsten@forky:~$ pactl --version
pactl 17.0
Kompiliert mit libpulse 17.0.0
Gelinkt mit libpulse 17.0.0
karsten@forky:~$ pulseaudio -k
karsten@forky:~$ pulseaudio --start
karsten@forky:~$ pactl list sinks
Ziel #0
	Status: RUNNING
	Name: alsa_output.pci-0000_04_00.0.analog-stereo
	Beschreibung: EMU20k2 [Sound Blaster X-Fi Titanium Series] (SB0880 [SoundBlaster X-Fi Titanium PCI-e]) Analog Stereo
	Treiber: module-alsa-card.c
	Abtastwert-Angabe: s16le 2ch 44100Hz
	Kanalzuordnung: front-left,front-right
	Besitzer-Modul: 8
	Stumm: nein
	Lautstärke: front-left: 64636 /  99% / -0,36 dB,   front-right: 64636 /  99% / -0,36 dB
	        Verteilung 0,00
	Basis-Lautstärke: 65536 / 100% / 0,00 dB
	Quellen-Monitor: alsa_output.pci-0000_04_00.0.analog-stereo.monitor
	Latenz: 6888 usec, eingestellt 6944 usec
	Flags: HARDWARE HW_MUTE_CTRL HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY 
	Eigenschaften:
		alsa.resolution_bits = "16"
		device.api = "alsa"
		device.class = "sound"
		alsa.class = "generic"
		alsa.subclass = "generic-mix"
		alsa.name = "Front/WaveIn"
		alsa.id = "ctxfi"
		alsa.subdevice = "0"
		alsa.subdevice_name = "subdevice #0"
		alsa.device = "0"
		alsa.card = "0"
		alsa.card_name = "Creative X-Fi"
		alsa.long_card_name = "Creative X-Fi 20K2 SB0880"
		alsa.driver_name = "snd_ctxfi"
		device.bus_path = "pci-0000:04:00.0"
		sysfs.path = "/devices/pci0000:00/0000:00:1c.6/0000:04:00.0/sound/card0"
		device.bus = "pci"
		device.vendor.id = "1102"
		device.vendor.name = "Creative Labs"
		device.product.id = "000b"
		device.product.name = "EMU20k2 [Sound Blaster X-Fi Titanium Series] (SB0880 [SoundBlaster X-Fi Titanium PCI-e])"
		device.string = "front:0"
		device.buffering.buffer_size = "131072"
		device.buffering.fragment_size = "65536"
		device.access_mode = "mmap+timer"
		device.profile.name = "analog-stereo"
		device.profile.description = "Analog Stereo"
		device.description = "EMU20k2 [Sound Blaster X-Fi Titanium Series] (SB0880 [SoundBlaster X-Fi Titanium PCI-e]) Analog Stereo"
		module-udev-detect.discovered = "1"
		device.icon_name = "audio-card-pci"
	Ports:
		analog-output: Analoge Ausgabe (Typ: Analog, Priorität: 9900, Verfügbarkeit unbekannt)
	Aktiver Port: analog-output
	Formate:
		pcm
karsten@forky:~$ uname -a
Linux forky 6.12.85 #1 SMP PREEMPT_DYNAMIC Thu Jun  4 18:41:43 CEST 2026 x86_64 GNU/Linux
karsten@forky:~$
--- snip ------------------------------------------------------------------

It is a shame, that one has to ask these days: Cliff, are you feeding us some AI-assisted confidently wrong hallucinations?

Regards

Karsten
