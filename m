Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CDFC282D1
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Mar 2025 05:31:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48BA06042A;
	Thu,  6 Mar 2025 06:31:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48BA06042A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1741239117;
	bh=Lhpq8OYZz70n31XfEZpIB12OjO0GnuKYmVNaeWUOEIU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fxQvhxoXT1/1mSoWApg1h3invge2xL/ZhbPgX5yOPVjAwGNneDjGtTUQuwBVR2F37
	 48A3kNNygtVeL0VCd9ChVUCdwUruX4SZJnfNHLe1m9Pp0Dt0Ofh3JsyuyUH3he+HA1
	 Zel3JQM3yEa6q6P/QdUon9du59jxfkn1nvjcUWgU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AC4DEF805C7; Thu,  6 Mar 2025 06:31:20 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 65CCEF804B0;
	Thu,  6 Mar 2025 06:31:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42F36F804B0; Thu,  6 Mar 2025 06:31:15 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1660DF80152
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2025 06:31:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1660DF80152
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1741239072687858582-webhooks-bot@alsa-project.org>
References: <1741239072687858582-webhooks-bot@alsa-project.org>
Subject: regresion: snd_hdsp
Message-Id: <20250306053115.42F36F804B0@alsa1.perex.cz>
Date: Thu,  6 Mar 2025 06:31:15 +0100 (CET)
Message-ID-Hash: 6WXE7WSSMIYDB3JQVJWAO6AMRXONPGIR
X-Message-ID-Hash: 6WXE7WSSMIYDB3JQVJWAO6AMRXONPGIR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6WXE7WSSMIYDB3JQVJWAO6AMRXONPGIR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-firmware issue #11 was edited from juanpc2018:

![Image](https://github.com/user-attachments/assets/e57192a7-ad1c-44f9-b51d-7806efed9a32)

```
$ pulseaudio
W: [pulseaudio] module.c: module-combine is deprecated: Please use module-combine-sink instead of module-combine!
W: [pulseaudio] module-combine.c: We will now load module-combine-sink. Please make sure to remove module-combine from your configuration.
E: [alsa-sink-RME Hammerfall HDSP 9632] alsa-sink.c: ALSA woke us up to write new data to the device, but there was actually nothing to write.
E: [alsa-sink-RME Hammerfall HDSP 9632] alsa-sink.c: Most likely this is a bug in the ALSA driver 'snd_hdsp'. Please report this issue to the ALSA developers.
E: [alsa-sink-RME Hammerfall HDSP 9632] alsa-sink.c: We were woken up with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or another value < min_avail.

```

when i play any video or sound file,
most of the time PulseAudio takes between 7 to 15 seconds to fill the buffer in proper order,
audio is played in wrong order, chopped, like [stutter](https://www.youtube.com/watch?v=9ZaDn5wne8Y&t=609s).[2](https://www.youtube.com/watch?v=oeSa9SyVd94&t=9s)

i have tested /etc/pulse/deamon.conf
s24le to s24be
problem persists.

forced sample rate to 48Khz,

Audacity 3.6. ALSA hw:0 also Crash.

i remember hdsp9632 worked ok on U/Kubuntu 10.04 & 10.10
Now 20.04.4 LTS has problems.

im using Liquorix 6.3 Kernel.

```
$ sudo apt show alsa-firmware*
Package: alsa-firmware-loaders
Version: 1.1.7-1ubuntu1
Priority: extra
Section: multiverse/sound
Source: alsa-tools
Origin: Ubuntu
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Original-Maintainer: Debian ALSA Maintainers <pkg-alsa-devel@lists.alioth.debian.org>
Bugs: https://bugs.launchpad.net/ubuntu/+filebug
Installed-Size: 211 kB
Depends: fxload, udev, libasound2 (>= 1.0.24.1), libc6 (>= 2.4)
Homepage: https://www.alsa-project.org/
Download-Size: 25,0 kB
APT-Manual-Installed: yes
APT-Sources: http://archive.ubuntu.com/ubuntu focal/multiverse amd64 Packages
Description: ALSA software loaders for specific hardware


$ sudo apt show alsa-tools-gui
Package: alsa-tools-gui
Version: 1.1.7-1ubuntu1
Priority: extra
Section: universe/sound
Source: alsa-tools
Origin: Ubuntu
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Original-Maintainer: Debian ALSA Maintainers <pkg-alsa-devel@lists.alioth.debian.org>
Bugs: https://bugs.launchpad.net/ubuntu/+filebug
Installed-Size: 1.002 kB
Depends: libasound2 (>= 1.0.24.1), libc6 (>= 2.29), libfltk1.1 (>= 1.1.6), libglib2.0-0 (>= 2.35.9), libgtk-3-0 (>= 3.0.0), libgtk2.0-0 (>= 2.8.0), libstdc++6 (>= 5.2)
Homepage: https://www.alsa-project.org/
Task: ubuntustudio-audio
Download-Size: 220 kB
APT-Manual-Installed: yes
APT-Sources: http://archive.ubuntu.com/ubuntu focal/universe amd64 Packages
Description: GUI based ALSA utilities for specific hardware

```

Issue URL     : https://github.com/alsa-project/alsa-firmware/issues/11
Repository URL: https://github.com/alsa-project/alsa-firmware
