Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4946606A31C
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=j5sbliUO;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sqBZvwUI
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 291D660294;
	Mon,  9 Nov 2026 16:03:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 291D660294
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794236644;
	bh=ZYLRkL3BzS2C/8F3gr/dhsgAHEsPvQ/XnnNInS76MX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=j5sbliUO4+Jm2OyT4dqoJcLKBwxICbKBRxQJZ3oTd9LVtGlyNNjehC750hCt8/ZRx
	 za79mSNeMuOos14wj6lVuDn9wUuRTsbieKaOdOxN2BdLh8uvwT1dNv5YFSNpguUSB/
	 4W+rEkt5Yro8IF5Ips80Z7cT3MM0noMiGCdDoGG4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76752F80864; Mon,  9 Nov 2026 16:01:14 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A78DEF806A8;
	Mon,  9 Nov 2026 16:01:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69E90F804FF; Thu,  5 Nov 2026 16:17:20 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793891838;
	b=qEsXvZ9AiUnZNRvpoCPoMvyYz+yXk/sJlfrBJZYGW16Dhxlmbi5rh4l2ZRCvIP7LuVkN
	 ++3owPDk6GSUfdTkKCfCRMUxNAChXexWafDQudy+aboCLF7S0QIr4jEK2f3NL53a5hHGU
	 8/41MwB3tftVgSpv74QS/ET2lNS5j6JxNF8iaO22shAVdi4qfWq1ustSyZwI9n+Srw+5o
	 ywyWUITFOeZGxqeDp+AhH76cX+4jY0F1acWxHoInOO8YOJtNiln/ZujHkhGK3YGZAj/sA
	 vp+lCMlyVoWj7wIDsMEDg7sW+PpdObeKahn6FK4G48sUXinhWniNYGvWYX2dV7jPzfQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793891838;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZYLRkL3BzS2C/8F3gr/dhsgAHEsPvQ/XnnNInS76MX4=;
	b=Vsnn6YVDKaMZYXFV87owXAJzah4bKbzEzAqKvwbhCnoeH/tW6Lxan/ihZGSGUX+erPve
	 a5YD2tEo+icRugKJsX+U+O8IiCUpelkiLQNNy/1KVMasCGtyGUs3/sCvxnRuBn7Ebf2sH
	 c+mSc+1iOFGIWIvBLl8peJOPRfCR39SFZ2/D9pTLhwWWSEMPkev5PJToXHjYbM6oIV4AQ
	 oNQTJQfd930yquRULzIb3wOfSbXbx8+3vbUrutnRzz6yBOgkJq3aQ2NqPWYfJ2WaYhIJF
	 5kMDEx9LmVu52EyddXwl2g9WtFOfXzI3obJJt0uGqM+j18WV0pmPdzLeGoSLiUvTGvg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=sqBZvwUI;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A24F1F800EE
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2026 16:17:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A24F1F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=sqBZvwUI
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-353804b591eso3793528eec.0
        for <alsa-devel@alsa-project.org>;
 Thu, 05 Nov 2026 07:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793891836; x=1794496636;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hgHpO/GSAfi6i+M1tK7tkY4nBaIZNu/5SYPs94b2CqA=;
        b=sqBZvwUIhWsvdi/pdTtrRHeSj2eTqaDxblF/gszbvOIEr9lmtMLsmGK92xNFz4icEb
         zvktV55pH2BcFa6XoJrwLJj7RphJ+VbiQY8DP0bvLq+UorlAjMbsbT5t3d617x/zJODU
         unNi/zTMTR3X+sgWUyGuvf/vBLvecl0HtM4HqWIXePACMGqq3iqL8befDnRGRzfZpHEL
         +s3Q1P/8JP944TTrhoocREFpQzHCBrIP13cwL3xXGNLZIMO4iWje/ZtOEHBnXbS8zmMc
         Wm522ULW5FlxEKtHYttFjeKh6x6pF7CC3FdakBsy+eS2EWW7i2OPRkK0xfZbKC+b7FPv
         NQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891836; x=1794496636;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hgHpO/GSAfi6i+M1tK7tkY4nBaIZNu/5SYPs94b2CqA=;
        b=choRhFMYVMSNTT4AkxR4EhWyH1zGQQgwI5vdkDnrmNbM8BGwAASAj55KtVpd6Bz6X5
         HgjN2XifavRGj4YM/h0Wd/1w2lVNZlQYYOVgg+aGb0fW+AgeDkrvs9jzUsGFEd13Dm+z
         Y1DD8dopEsACxe48qomJd/9eg2goAwQa9j68dcFmH9O2PPDCy+evng2DCMeKkpI0rTGY
         i2NgwU5GvRriRcYwH5lCj7VLQlkrxkg1tZHhMm+MXlR3YrzyOxsUNyljdy+PvrXFsEb1
         MaVHsqExUbu5QdMHz8ciP4RidH066WtfEOzG8taY8HJXAAfo0yHb0Q9YCEM19t1im0PS
         0wWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwku335O2HYw58O50NgTwLnvWcRP0UX2FvwW+KSAHI+mQXVpZrgZj79leqmqAaaWxrDxi8ohWfumWbz@alsa-project.org
X-Gm-Message-State: APuU4Z/5GbEcq2z5tDEH7hyihzU9CySMyGb8zv4cSzuhuL5cPXCW2R3/
	19qDdPUmIQk0awulKY3V6rEHt47w+FlMKBev4zzdNWTp5A+1gvU1k979
X-Gm-Gg: AYBFou2kYChwvYwGQhQToqzpSTLV0Vj87BfGWp5Kv3rz4L0cNus+gCBFXHNFSqyPKlZ
	1+OpJ74DwNb8txt6taHP9VcwnF3TnmMOO7hP3pZ7GnuxJCgTRRgXaXI1VykoYW6GkRLe6xmO1qq
	ac21XIPHUKV/kXzBXFAI3T4koORrG9CF22q2BfNqJh671Qcer3nJjSgXL30jEYhTC7pMEsjjF9E
	Wm01SsXuXnC5bCHFzH5CpqgxYocPsJOGDadDRCZZydmbq+3ZR8yCkUpCux3IA//Nfatc+ftxmDu
	UjxY0uy3Qq/lkOgD3H9rmW5ai5YB2FNLauge/dpUy9piEjlbqYg0TVGntc3rv7rl5zqdPp6Xpza
	X80zkgdE+rklp9imeE4vH9jCCU0y+dTu/ZbcGjZeTfYClizXs5519elQHmRkt5ZTcKYxTeF/EUI
	n4UpSan0MsdXlpYczWG6ddkM17BNAVI1HMN0/Pc1n/jZcYnJ38/yUKQtR8SS0xIjl0PYEVI09a9
	RBpcLUbn4d3IgBRrveVDtxaDIL98ouAJBIyot97KUFcChoKjJxlmFxfV6nc6NRyxD+aiFbb7Bb8
	5UFUsbiQG4MxT5XYhCG+QiR8hwKHyp//7JyZHv8StmLyI6mhyv7Kus4QfP2m1aS1a7yJy4KGa61
	OpEeHH+eamU4OWJcsEDz3WehCVTC0+R77rYa9X1lDst8D9mFG
X-Received: by 2002:a05:7301:6193:10b0:369:a162:af96 with SMTP id
 5a478bee46e88-36a4238974bmr28721399eec.17.1793891834911;
        Thu, 05 Nov 2026 07:17:14 -0800 (PST)
Received: from cachyos (2a01cb0c82caf900a186612f304bfea5.ipv6.abo.wanadoo.fr.
 [2a01:cb0c:82ca:f900:a186:612f:304b:fea5])
        by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38a6d3dsm21567087eec.7.2026.11.05.07.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:17:14 -0800 (PST)
From: =?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-usb@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	=?UTF-8?q?Isma=C3=AFl=20Bahloul?= <i.bahloul01@gmail.com>
Subject: [PATCH v8 8/8] Documentation: sound: add the Babyface Pro
 proprietary-mode design doc
Date: Thu,  5 Nov 2026 16:15:53 +0100
Message-ID: <20261105151553.223722-9-i.bahloul01@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105151553.223722-1-i.bahloul01@gmail.com>
References: <20261105151553.223722-1-i.bahloul01@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: i.bahloul01@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: B3MJ7XZQFME6VLMEHL5MOFLPTAW4ZNM7
X-Message-ID-Hash: B3MJ7XZQFME6VLMEHL5MOFLPTAW4ZNM7
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:00:52 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B3MJ7XZQFME6VLMEHL5MOFLPTAW4ZNM7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

A big-picture companion to the patch series, for human reviewers:
why the proprietary mode needs a standalone driver instead of a
snd-usb-audio quirk, the vendor protocol's write-only/no-readback
shape and what that forces onto the driver, the stream session
model, why the mixer state has to be cached and replayed, and why
the driver has to emulate TotalMix's own role for the front panel.

Requested by Takashi Iwai's v4 review: documentation for reviewers,
not restating what the code comments already say inline.

Signed-off-by: Ismaïl Bahloul <i.bahloul01@gmail.com>
---
 Documentation/sound/cards/babyface-pro.rst | 218 +++++++++++++++++++++
 Documentation/sound/cards/index.rst        |   1 +
 2 files changed, 219 insertions(+)
 create mode 100644 Documentation/sound/cards/babyface-pro.rst

diff --git a/Documentation/sound/cards/babyface-pro.rst b/Documentation/sound/cards/babyface-pro.rst
new file mode 100644
index 000000000..2b79a52d9
--- /dev/null
+++ b/Documentation/sound/cards/babyface-pro.rst
@@ -0,0 +1,218 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================================
+RME Babyface Pro / Pro FS (snd-usb-babyface-pro)
+=================================================
+
+This document describes the design of the ``snd-usb-babyface-pro``
+driver - what problem the driver solves, why it is a standalone
+driver instead of a snd-usb-audio quirk, and the four design
+decisions (protocol shape, stream model, mixer state across re-probes
+and resume, front-panel emulation) that shape most of the code.
+
+Two USB personalities, one device
+==================================
+
+The RME Babyface Pro and Babyface Pro FS present two different USB
+configurations depending on a physical/firmware switch: a
+class-compliant one, already handled by ``snd-usb-audio``, and a
+proprietary one (USB ID ``2a39:3fc0``) that this driver covers.  The
+two hardware models share the same USB ID, ``bcdDevice`` and
+``iProduct`` string shape; nothing in the descriptors tells them
+apart, and the driver runs unmodified on both.
+
+In proprietary mode, interface 5 carries the PCM stream on two
+INTERRUPT endpoints (``0x01`` OUT, ``0x82`` IN) instead of the
+isochronous endpoints the USB Audio Class specifies.  Isochronous
+transfers are rejected there with ``-EINVAL``.  ``snd-usb-audio`` has
+no interrupt-PCM transport, so this mode cannot be a quirk on top of
+it; the driver is standalone, modelled on ``snd-usb-caiaq`` (another
+interrupt-streaming RME/NI-style device).
+
+Why interrupt endpoints and not isochronous is a hardware/firmware
+choice on RME's side, not something this driver can change - the
+class-compliant mode already exists on the same device for users who
+want a fully standard, quirk-free path with a subset of the
+functionality (no mixer, no front panel).  This driver is for users
+who want the full mixer, routing matrix, and hardware DSP EQ that
+only the proprietary mode exposes.
+
+The vendor protocol: writes only, no readback
+==============================================
+
+Every mixer and clock function is one of a handful of USB vendor
+control requests (``bmRequestType 0x40``, i.e. host-to-device,
+vendor, device-recipient), each identified by its request number and
+a 16-bit value/index pair - there is no larger command structure.
+The commonly used ones are:
+
+======  ========================================
+0x10    settings word, rate family, stream trigger
+0x12    16-bit crosspoint and output-master writes
+0x14    stream session arm
+0x16    cold-init register clear
+0x17    front-panel + preamp state (read and write)
+0x1a    8-bit gain / output-master writes
+0x1b    varispeed (DDS quad)
+0x1d    stream session start
+======  ========================================
+
+The full register map, decoded from Windows USB captures and
+cross-checked against hardware, lives in the driver's own development
+repository (not shipped in-tree) - the constants and the comments
+next to each vendor write in the source are the authoritative
+in-tree reference.
+
+The one property that shapes the rest of the driver: **almost nothing
+here can be read back**.  The 0x17 request returns the front-panel
+and preamp state, but the crosspoint matrix, the output masters, the
+routing flags and the clock all have to be tracked host-side - the
+device will accept a write blindly and never confirm what it actually
+holds.  Two consequences follow directly from this:
+
+* The ``struct snd_usb_babyface`` device state (see
+  ``babyfacepro.h``) is not a cache in the usual sense of "avoid a
+  slow read" - it is the *only* record of what the hardware should
+  currently hold.  Every mixer control's ``.get`` callback reads this
+  state directly; none of them ever talks to the device.
+
+* A full reset of the device's registers - which the cold init at
+  probe and at resume does - has to be followed by replaying the
+  *entire* cached state back, in the right order, or the card comes
+  back silent or at the wrong levels.  This is what
+  ``babyface_restore_state()`` and ``bf_state_apply_flags()`` do (see
+  "Mixer-state persistence" below).
+
+The stream model
+================
+
+Playback and capture share one physical stream: the device only
+advances it while both interrupt endpoints have a pending URB, so the
+IN and OUT URBs are always submitted as a pair, and both directions run
+at one sample rate.  The driver runs one stream *session* for both
+substreams:
+
+* ``hw_params`` counts a substream as a user of the session;
+* ``prepare`` starts the session if it is not running - the rate write,
+  the session trigger pair, the IN/OUT URBs, then the arm - which is
+  what the RME Windows driver sends at a stream start;
+* trigger START/STOP only decides whether the URB handlers move that
+  substream's audio.  The URBs keep running either way, carrying
+  silence while nothing plays, so an xrun restart does not restart the
+  session;
+* ``hw_free`` drops the user, and the last one stops the session.
+
+The device keeps its mixer registers between sessions, so a session
+start writes no mixer state.  A session triggered within about 15 ms of
+the previous one stopping comes up with the outputs silent, so a
+session start waits until 50 ms have passed since the last stop.
+
+Both directions share one clock, so while another application has the
+other direction set up, the rate belongs to it: ``open()`` offers that
+rate alone, and the sound server resamples, rather than the device
+changing rate under a running stream - as with RME's own drivers, which
+grey the sample rate out while a stream runs.  The application that
+holds both directions may change the rate or the buffer size itself, as
+a DAW does from its settings; the direction it left running then stops
+with an xrun and is set up again.
+
+The size of the URBs follows the period the application asks for, so
+the latency follows the application's buffer instead of a fixed queue:
+``hw_params`` splits the period into the fewest URBs of at most
+``frames_per_urb`` frames, each a whole number of the device's IN
+packets, and keeps two periods' worth in flight (at most ``nurbs``).
+The URB handlers copy to and from the ring the core allocates and take
+the application's position from the shared control page, so the ring can
+also be mapped by the application, which JACK requires.
+``runtime->delay`` reports the audio queued in the URBs plus the fixed
+delay of the converters and of the device, per speed, so that an
+application that uses ALSA directly can line up what it records.
+
+The playback handler copies the ring as it is and moves the pointer on
+by the whole URB, so the pointer follows the device even for an
+application that runs the stream free, as dmix does on the hardware PCM
+it opens; an underrun is the PCM core's to detect and report.
+
+Capture exposes the device's twelve input words in the device's own
+order, one channel per word: AN1-4, AS1/2, then ADAT3-8.  AS1/2 is the
+first optical pair, so it carries ADAT 1/2 when the input receives ADAT
+and S/PDIF when it receives S/PDIF.  At 96/192 kHz the frame has fewer
+words and the channels past them read zero.
+
+URB completions run in interrupt context; the work that needs to sleep
+(stopping the session after repeated URB errors) runs from
+``stream_work``.
+
+Mixer state across re-probes and resume
+=======================================
+
+A userspace client can claim the proprietary interface directly via
+``usbfs`` (``USBDEVFS_DISCONNECT_CLAIM``) - both PipeWire grabbing the
+device for a sink and the project's own TuxMix userspace daemon do
+this via libusb.  That detaches the kernel driver and the ALSA card
+disappears for the duration; when the client releases the interface,
+the driver re-probes.  The cold init the probe runs clears the mixer
+registers, and the driver does not carry its cached state across the
+re-probe: alsactl restores the settings stored at the last shutdown
+once the card is registered again, as for any other card.  A resume
+that follows a device reset goes through ``reset_resume`` instead of a
+re-probe, so a reset does not lose the state that way.
+
+A system suspend does lose the registers.  On resume the driver re-runs
+the cold init and replays the in-memory state (masters, crosspoints,
+routing flags, EQ) through the same paths the controls use.  Since
+almost nothing can be read back (see above), that in-memory state is
+still the only record of what the hardware should hold.
+
+The front-panel SELECT selection is the exception: it is not in the
+0x17 readback, so the driver has to be told it once and cannot know
+whether it changed meanwhile.  The driver tracks whether a unit has
+been probed since the module was loaded.  After a boot it takes the
+values alsactl restores; a re-probe of an already-seen unit ignores
+them and leaves the pairs unknown, because SELECT may have been pressed
+since the last store.  The "Front Panel Selection" controls let
+software correct the selection (see below).
+
+Front-panel emulation: the driver plays TotalMix's role
+==========================================================
+
+The front panel (IN/OUT/SET/MIX/SELECT/DIM buttons, the rotary
+wheel) has no on-device intelligence of its own for turning a wheel
+click into a mixer change - on Windows/Mac, RME's TotalMix
+application polls the same 0x17 status register this driver polls,
+decodes button/wheel deltas, and performs the resulting mixer writes
+itself.  Standalone (no host software) mode exists on the hardware,
+but the proprietary USB mode this driver targets always has a host
+attached, so this driver has to do what TotalMix does: poll 0x17 on
+a delayed work item (``panel_poll_ms`` module parameter, default
+20 ms to match TotalMix's own ~50 Hz), decode the button flash and
+signed wheel delta, and apply the resulting change (an output level
+step, a preamp gain step, a monitoring level step, a phantom toggle)
+exactly like the corresponding ALSA control's ``.put`` would.  A DIM
+press is only counted, for a mixer application to act on.  The
+front-panel ALSA
+controls this driver exposes are the read side of this: a way for
+userspace (WirePlumber, TuxMix) to observe what the physical panel is
+doing, not a way to drive the hardware.
+
+Some panel state - which channel SELECT currently has chosen, for
+instance - is not part of the 0x17 readback at all and exists only on
+the device's own internal state machine, which the driver cannot
+read.  The unit keeps one such selection for each IN pair, across IN
+switches and even across a power cycle; its LEDs stay dark until the
+next SELECT press, which only shows the selection again, and later
+presses step it.  The driver follows the presses and exposes the
+selection of each pair as a "Front Panel Selection" control (index 0
+is Ch 1/2), so that alsactl keeps it across boots like any other
+mixer setting.  It cannot know what the unit holds before it has been
+told once, so a pair starts out unknown, and SET and the wheel then do
+nothing instead of acting on a channel that may not be the lit one;
+setting the control to what the LEDs show for the pair tells it.  The
+values alsactl restores right after a probe are the ones of its last
+store: after a boot that is the newest record there is, but a re-probe
+of a unit already seen may follow SELECT presses made since, so the
+driver ignores them then and leaves the pairs unknown.  The stored
+values can be wrong only if the selection was changed while the driver
+was not running (the unit used on its own, or with another host).  The relevant code
+comments (``babyface_panel_start()``, the ``panel_select_armed``
+handling in ``bf_panel_tick()``) explain the details.
diff --git a/Documentation/sound/cards/index.rst b/Documentation/sound/cards/index.rst
index e68bbb13c..31051b7a4 100644
--- a/Documentation/sound/cards/index.rst
+++ b/Documentation/sound/cards/index.rst
@@ -12,6 +12,7 @@ Card-Specific Information
    emu10k1-jack
    via82xx-mixer
    audiophile-usb
+   babyface-pro
    mixart
    bt87x
    maya44
-- 
2.56.0

