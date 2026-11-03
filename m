Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DED1606A32C
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=CAMzqPeG;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wi0e5Eef
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B69AE6021D;
	Tue,  3 Nov 2026 08:58:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B69AE6021D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793692723;
	bh=WjCSOwuu02Te6yMNJYtFabr29zMkCkWsOK0zNQTJ3Ok=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=CAMzqPeG6fhyCxUgwSRP7Okm/rkAN6qHWo7Nna/xtsUqaOnUsvkLVBHuMzRuSvtTb
	 K79yNPeX1gXgwUdyxyuKVdfL9nmqohcSSdo3piIIGyTTNoRqMk+iB3g9Lj0JmnL2vb
	 pSdfujNVJW4CpFiQ4rk82Ny/2h8bBWN9H1tBs+/A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 10E9AF80602; Tue,  3 Nov 2026 08:58:09 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ED034F805FA;
	Tue,  3 Nov 2026 08:58:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42CC3F804CF; Tue,  3 Nov 2026 04:33:51 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1793676830;
	b=O6UWBRPU+17HT1vlaBa1TvzSvXx9R44O/KOGTENuzEK6sjeClsPbFeOGcAUScnS6P6ol
	 1jt/CrStS0cagNmBd+Af1Z+FI6onDeAQ9oNrpekMCuOdZBSNNDeDfD+/K560udcot7x1E
	 YYZSSPOvOMBJefb/Zj54XO4xBfcU++PYqWlNo6/6kzElN2XifjIKO+aBGNVzcdu3SSizD
	 YcrEKix5VlfvHOuQ+cDl6xtsT3XLFiY/4Gsj64avp9haIQIPURDSWvOc1xqUnXyz3T+Kj
	 wR4JbbAkI4V8eLo0Bf7elr27oROGHvWA7iRjLpZd/5dSy/TFlzIcd1c8Or1hiY2Q2/w==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793676830;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=WjCSOwuu02Te6yMNJYtFabr29zMkCkWsOK0zNQTJ3Ok=;
	b=J0c2v5awpfblUJg25/KJ6FNxZGPQYfZERA4H6AYh8o5waI9TQgHriT5XilSYU8KNwwYY
	 M5pk3JFbU50U23iWL482w9/i8X/JbJ6ve8HkEIoSN15MxJcluuaflgABJpOrjBuNXXktI
	 0M/LH5SoyQ9V0eibr36kmy4hVkXL38Fy/OLxeiSBjqX2Yv2tSXlHELKT3bHpc5TZERdlD
	 k/zeNRIlIQviUIdtH/5Ie7zeuSO13PXsObe+0QSktEvss5MKAPfLBdWh/l5wMF2tagfh2
	 bxAz497Bv8bavSOrVeHUN1GTMM7ZafrkrPPrmu/k1DbKbNnjtbEC1KEEfIkinHpjTKQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=wi0e5Eef;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D995AF80100
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2026 04:33:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D995AF80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=wi0e5Eef
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-91c7b00a75fso44723726d6.2
        for <alsa-devel@alsa-project.org>;
 Mon, 02 Nov 2026 19:33:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793676827; cv=none;
        d=google.com; s=arc-20260327;
        b=OlroJNxL3ddD1EVS8AO9099r/gjjsYl+DXqLXulQWkyCO9HIHOsPxOroQUmQajTOiN
         oFK7CGvuXtA2Xm3KjqvGhGqynEdvFX2MBBAsGN2Fkyns7QoDXnpELnaafNkSxvHMI+HD
         DVhN17Y9rKIwSd3CnMUh9pHEOWLqV00IFtn4stIvpnrYy0Wf1w81ms/XZLnBd55z8ovk
         GVcaPpgjogkq7qPvEdDsgRPv3Yd8IN7nr4RT1YhxMonaRXNauzP/xZqu+btdVxFeIn31
         NHhX1hT7CvIUZoKZ1A0yMjtKvBx+T1Fc4d7mF/5eDRbALNprNj7OA5Hj5xl95Hh1ts4f
         HZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=J/OcpMsXMmoNeS0GnvInAuRwFa0YGqF9a2RfY56wyr8=;
        fh=ICIMTKEHOP9hvWq2ObuhOt40qmrD2P3wq98I2ya/L0I=;
        b=SErbbn3mBcQJ1Mv400tOazEWjRlMJze5Fzg1KX0ujIsvv4KRtKrdFlXvbojCPwtWrJ
         c/BimtfxeQUIpPZo3/G7y8szH9TxR2AWn0SPe3lJqzAL2Af08/yfm1kzVqNG9Fu5/558
         z+/y5r4zSDj7Ii111YSdSeoUcJbT9kqpPQQUZFJDbxvWEck7FoMbntG54bomA2Zk/tp/
         oOa+goIJu/uyRU86+2RClG1I7Wz7e2hXe8rICBnJ5T3x0Kpvomr+XBf67+5qRy6EB5K0
         Eg6rSlkyNNh0Bi4XNZZ2hsYCB+sgxMSi+FgwIpfgThDgmCVAwsjfgng3nQv43Mswciuy
         aqZA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793676827; x=1794281627;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J/OcpMsXMmoNeS0GnvInAuRwFa0YGqF9a2RfY56wyr8=;
        b=wi0e5Eef+wV9Y95Uc/P7iYrsM2+eXice89re06pM/6QPpyvyKNv+fgTOPx4X3EiEZZ
         LrxxwYmgdsf81oRs7kbNHXliLt95d9BTYKM1/prY3vshxsrJ8e0x8+wbskdutEoWiJ3c
         ri3aH73oE3TFDRDwDs7WBmZB28toxPutGHTAAiw0+EZ5lmUSVaVsuSyp7Ky6Ad8No5z0
         B/Nl4Dauid1GXNe3rRjxSr3UMmZmXc3ZojdjJ6NY5WTvDFrtyQejgpm0QZNHpMozL8sU
         iadl2yyv5cY/Klc2s5i092mseGkncCI3A1/Qb5PEoyPA2W0kmt5HYMM7Ye4pfxXXFXb/
         cd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793676827; x=1794281627;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J/OcpMsXMmoNeS0GnvInAuRwFa0YGqF9a2RfY56wyr8=;
        b=j1gErNavVSOtp8NBlCUyrfvgM3zTi7XNKT34KpRG91DoP4r50sOxHBhr9Wzzn+BIck
         c05BTFpU4bdN2SKbJqqvnDwchXcdhfemfqleeh8QduXQZ3UmLqiBqwQB1XDYM9/labsG
         guen/qYtvGbD3TBkEF8AA2960HP9oGOU1lJWu00fONqGL/bM4Jyf+JcYmxfk9WXoPmoj
         9xQp4hbFSYPlg+ssVfIQS9duxP9tXNzJDiJMxlvkDHt0M/FKNSC69/ea247J4wVFlXfC
         yMCWzInMvyO7FHj2noEwnpWlzdmM67Myc10o4gcRQYMMO4MaXv6qICyiPonvoscgpuXO
         0UJA==
X-Gm-Message-State: APuU4Z8T9+h/f6FpYy7iacH0g+/s2RtYFwUSSvQlEGuPimP/9kLS9gy/
	11b3CZveRLDWsxfv0xrVR3IU2RZ+v48hpXa1L+lslNclslP0SFdzBSEQ29+PpZTtLkH1bHhGbAv
	k+At6rRPZiWoDbhFL0Mon3WlqNHwQJ8q5Eum6Cow=
X-Gm-Gg: AYBFou0M17MBsJP0cCkeRaTtEXjxbZzK7jSqspxsbYjUtFs4WqwMUi6QX4APPHp2efx
	C/L1bz9jEHY9lml2zbXdsQcjZctA1K82NemugQWm3Eau9fClB7iH/gqDrkLRLzye1f0rD+H7izV
	ewWMR1OEgyTA9hiXxasLE5bPX0u5HZw4MNZ/kORCem7hnC52Fk1GpU5Pudz+JXVntQ9lGYio//e
	qboJcn0W5tUjVFTfEcuB/KIbqSi/ZPwNsWidmHXYTBCzqsNAa2jmcJTRrHYBiu0LI7n96JsO98Y
	JrwzqhdYNltYNVgtNVzX3XWREtVqudATmnA6f60cMbrHpzNHet0Nil6yyteM/vHK99ET0AcivIY
	TK5U+rTKSJfnv+D75oB5OxY4Adoi7fZVrNL+X6z0bgg2ztHhUPWvd9o7O2nCfoWCftCNsmA==
X-Received: by 2002:a05:6214:4309:b0:917:a646:7fa2 with SMTP id
 6a1803df08f44-91ca4b09d1emr192527606d6.21.1793676826689; Mon, 02 Nov 2026
 19:33:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Cristiano Souza <cristianocps@gmail.com>
Date: Tue, 3 Nov 2026 00:33:35 -0300
X-Gm-Features: AclHuK-GX75TbJs2rLULmTcUuuHlWfWNm0rGKy6ktIur-Gz_gVcjdBWfi_QNoZ4
Message-ID: 
 <CANiPN4m_+iwVio0LvXeJrq5SdLi3-paL45XMs0yjuZu4KotmEw@mail.gmail.com>
Subject: [PATCH] ALSA: usb-audio: Skip broken playback feature unit on
 XiiSound chips
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: cristianocps@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: DGEUWEXKWKBVY3ZTIZRSPI6K25K2VAEI
X-Message-ID-Hash: DGEUWEXKWKBVY3ZTIZRSPI6K25K2VAEI
X-Mailman-Approved-At: Tue, 03 Nov 2026 07:58:02 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DGEUWEXKWKBVY3ZTIZRSPI6K25K2VAEI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Weltrend XiiSound-based devices (040b:0897, e.g. Redragon H878
wireless headset) expose a UAC1 playback feature unit whose volume
and mute controls are unusable in practice: the reported per-channel
dB range is only 0..+0.39dB, yet setting any volume below the
maximum mutes one or even both channels, and the mapping between
logical and physical channels is unreliable.  Any attempt by
userspace to drive the hardware volume therefore results in muted
or one-sided audio.

Skip the playback feature unit entirely so that userspace falls back
to software volume, and pin the unit's master and per-channel volumes
to the reported maximum with mutes cleared when the mixer is created,
so the signal path always stays fully open.  The capture path
(microphone feature unit) is not affected and keeps working.

Tested with a Redragon H878 wireless headset on PipeWire/PulseAudio:
stereo output works on both channels at any volume, software volume
applies smoothly, and mute/unmute works.

Cc: stable@vger.kernel.org
Signed-off-by: Cristiano Souza <cristianocps@gmail.com>
---
 sound/usb/mixer.c        | 16 ++++++++++++
 sound/usb/mixer_quirks.c | 56 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 95209ec..1423c72 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2277,6 +2277,22 @@ static int parse_audio_feature_unit(struct
mixer_build *state, int unitid,
  /* disable non-functional volume control */
  channels = 0;
  break;
+ case USB_ID(0x040b, 0x0897):
+ /* Weltrend XiiSound chips (e.g. Redragon H878): the
+ * playback feature unit is broken -- its volume controls
+ * act like mute switches below the maximum value and the
+ * channel mapping is unreliable, so any hardware volume
+ * change mutes one or both channels.  Skip the unit
+ * entirely so that userspace falls back to software
+ * volume; the unit is pinned to maximum/unmuted by the
+ * mixer quirk in mixer_quirks.c.
+ */
+ if ((iterm.type & 0xff00) == 0x0100) {
+ usb_audio_info(state->chip,
+       "usbmixer: skipping broken playback FU for XiiSound chip\n");
+ return 0;
+ }
+ break;

  }

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 5eee501..fe389ee 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -4419,6 +4419,59 @@ static int snd_djm_controls_create(struct
usb_mixer_interface *mixer,
  return 0;
 }

+/*
+ * Weltrend XiiSound chips (040b:0897, e.g. Redragon H878):
+ * the playback feature unit is broken -- its volume controls act like
+ * mute switches below the maximum value and the channel mapping is
+ * unreliable, so the unit is hidden from userspace entirely (see the
+ * quirk in mixer.c) and userspace falls back to software volume.
+ * Pin the unit's master and channel volumes to the reported maximum
+ * and unmute them, so the audio path stays fully open.
+ */
+static int snd_xiisound_init_fu_pins(struct usb_mixer_interface *mixer)
+{
+ struct snd_usb_audio *chip = mixer->chip;
+ unsigned char buf[2];
+ int ifnum, ch, err;
+
+ if (mixer->protocol != UAC_VERSION_1)
+ return 0;
+
+ ifnum = snd_usb_ctrl_intf(chip->ctrl_intf);
+
+ /* unit 5 is the playback feature unit on these chips */
+ for (ch = 0; ch <= 2; ch++) {
+ err = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0),
+      UAC_GET_MAX,
+      USB_DIR_IN | USB_TYPE_CLASS |
+      USB_RECIP_INTERFACE,
+      (UAC_FU_VOLUME << 8) | ch,
+      (5 << 8) | ifnum, buf, 2);
+ if (err < 0)
+ return 0; /* no such unit/channels, nothing to pin */
+
+ err = snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+      UAC_SET_CUR,
+      USB_DIR_OUT | USB_TYPE_CLASS |
+      USB_RECIP_INTERFACE,
+      (UAC_FU_VOLUME << 8) | ch,
+      (5 << 8) | ifnum, buf, 2);
+ if (err < 0)
+ return err;
+
+ buf[0] = 0; /* unmute */
+ err = snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+      UAC_SET_CUR,
+      USB_DIR_OUT | USB_TYPE_CLASS |
+      USB_RECIP_INTERFACE,
+      (UAC_FU_MUTE << 8) | ch,
+      (5 << 8) | ifnum, buf, 1);
+ if (err < 0)
+ return err;
+ }
+ return 0;
+}
+
 int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 {
  int err = 0;
@@ -4432,6 +4485,9 @@ int snd_usb_mixer_apply_create_quirk(struct
usb_mixer_interface *mixer)
  case USB_ID(0x0644, 0x8047):
  err = snd_us16x08_controls_create(mixer);
  break;
+ case USB_ID(0x040b, 0x0897): /* Weltrend XiiSound (Redragon H878) */
+ err = snd_xiisound_init_fu_pins(mixer);
+ break;
  case USB_ID(0x041e, 0x3020):
  case USB_ID(0x041e, 0x3040):
  case USB_ID(0x041e, 0x3042):
--
2.43.0
