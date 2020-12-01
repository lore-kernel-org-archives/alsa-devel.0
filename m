Return-Path: <SRS0=HhIj=FF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C1AC64E7A
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 16:07:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 464A32222A
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 16:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VZSG+iD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464A32222A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADC8517C1;
	Tue,  1 Dec 2020 17:06:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADC8517C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606838861;
	bh=6KqkQ3DqUxVW1ifRFhu96Cg0kXR6m55SaJqYBdaENt8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VZSG+iD30qifIZY+FuodESWLHZAgljX/M56iuhuPs/RCp0ROXTpoNpva4iA0I+qu9
	 JrUbGGWSR2b64LeP00jCCdRC39IRVq133aPCASqHYegfQqRTMNq6ZHVGMV9rfPONP6
	 Rza/JNurPReE0mfGClmjs0B1Tfozas+2Yzxo3wEA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30DFEF80158;
	Tue,  1 Dec 2020 17:06:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DA23EF8016D; Tue,  1 Dec 2020 17:06:48 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 23051F80168
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2020 17:06:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23051F80168
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1606838795700922012-webhooks-bot@alsa-project.org>
References: <1606838795700922012-webhooks-bot@alsa-project.org>
Subject: module-alsa-card.c: Failed to find a working profile.
Message-Id: <20201201160648.DA23EF8016D@alsa1.perex.cz>
Date: Tue,  1 Dec 2020 17:06:48 +0100 (CET)
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

alsa-project/alsa-lib issue #104 was opened from mhwombat:

I can get audio through my headphones, but not through my speakers.

Basic checks:

- Speakers work on another machine
- Speakers are plugged in and turned on
- Headphones are unplugged when using speakers
- My user account is in the audio group.
- Nothing is muted in alsamixer

I think the cause might be this `module-alsa-card.c: Failed to find a working profile.`

```
$ journalctl --user -u pulseaudio | tail -n 20
-- Reboot --
Nov 28 22:35:15 nixos systemd[2142]: Starting Sound Service...
Nov 28 22:35:15 nixos pulseaudio[2160]: E: [pulseaudio] module-alsa-card.c: Failed to find a working profile.
Nov 28 22:35:15 nixos pulseaudio[2160]: E: [pulseaudio] module.c: Failed to load module "module-alsa-card" (argument: "device_id="0" name="pci-0000_22_00.4" card_name="alsa_card.pci-0000_22_00.4" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes avoid_resampling=no card_properties="module-udev-detect.discovered=1""): initialization failed.
Nov 28 22:35:17 nixos pulseaudio[2160]: E: [pulseaudio] module-jackdbus-detect.c: Unable to contact D-Bus session bus: org.freedesktop.DBus.Error.NotSupported: Unable to autolaunch a dbus-daemon without a $DISPLAY for X11
Nov 28 22:35:17 nixos pulseaudio[2160]: E: [pulseaudio] module.c: Failed to load module "module-jackdbus-detect" (argument: "channels=2"): initialization failed.
Nov 28 22:35:17 nixos pulseaudio[2160]: W: [pulseaudio] server-lookup.c: Unable to contact D-Bus: org.freedesktop.DBus.Error.NotSupported: Unable to autolaunch a dbus-daemon without a $DISPLAY for X11
Nov 28 22:35:17 nixos pulseaudio[2160]: W: [pulseaudio] main.c: Unable to contact D-Bus: org.freedesktop.DBus.Error.NotSupported: Unable to autolaunch a dbus-daemon without a $DISPLAY for X11
Nov 28 22:35:17 nixos systemd[2142]: Started Sound Service.
Nov 28 22:35:17 nixos pulseaudio[2160]: E: [pulseaudio] bluez5-util.c: GetManagedObjects() failed: org.freedesktop.DBus.Error.ServiceUnknown: The name org.bluez was not provided by any .service files
Nov 29 17:24:50 nixos systemd[2142]: pulseaudio.service: Current command vanished from the unit file, execution of the command list won't be resumed.
Nov 29 17:25:00 nixos pulseaudio[2160]: E: [pulseaudio] module-alsa-card.c: Failed to find a working profile.
Nov 29 17:25:00 nixos pulseaudio[2160]: E: [pulseaudio] module.c: Failed to load module "module-alsa-card" (argument: "device_id="0" name="pci-0000_22_00.4" card_name="alsa_card.pci-0000_22_00.4" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes avoid_resampling=no card_properties="module-udev-detect.discovered=1""): initialization failed.
Nov 29 17:25:00 nixos pulseaudio[2160]: E: [pulseaudio] module-alsa-card.c: Failed to find a working profile.
Nov 29 17:25:00 nixos pulseaudio[2160]: E: [pulseaudio] module.c: Failed to load module "module-alsa-card" (argument: "device_id="0" name="pci-0000_22_00.4" card_name="alsa_card.pci-0000_22_00.4" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes avoid_resampling=no card_properties="module-udev-detect.discovered=1""): initialization failed.
Nov 29 17:25:01 nixos pulseaudio[2160]: E: [pulseaudio] module-alsa-card.c: Failed to find a working profile.
Nov 29 17:25:01 nixos pulseaudio[2160]: E: [pulseaudio] module.c: Failed to load module "module-alsa-card" (argument: "device_id="0" name="pci-0000_22_00.4" card_name="alsa_card.pci-0000_22_00.4" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes avoid_resampling=no card_properties="module-udev-detect.discovered=1""): initialization failed.
Dec 01 10:53:45 nixos pulseaudio[2160]: E: [alsa-sink-USB Audio] alsa-sink.c: ALSA woke us up to write new data to the device, but there was actually nothing to write.
Dec 01 10:53:45 nixos pulseaudio[2160]: E: [alsa-sink-USB Audio] alsa-sink.c: Most likely this is a bug in the ALSA driver 'snd_usb_audio'. Please report this issue to the ALSA developers.
Dec 01 10:53:45 nixos pulseaudio[2160]: E: [alsa-sink-USB Audio] alsa-sink.c: We were woken up with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or another value < min_avail.
```

Here is the [output of alsa-info_alsa-info.sh](https://alsa-project.org/db/?f=c5a24a41c9ab6f2b320362b6b0d3afee507d6cab).

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/104
Repository URL: https://github.com/alsa-project/alsa-lib
