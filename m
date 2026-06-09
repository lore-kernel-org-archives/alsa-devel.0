Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B22CD8CB2
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:59:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F0C760214;
	Wed, 10 Jun 2026 09:59:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F0C760214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781078360;
	bh=Sz0vOnxXS1aB9WNoNrVQ4+rsRwzr8fA19p8UVE44/Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YmwZ8PH6gXwIRuKl0Gb4PWc1XYq8c3N8nKdC4mJ1aUCEU1ndbRh2kBAuHo6SxQ5CX
	 2+CTgQB/nQ8zWviOzj94gDq7+8ndR+S2wDcZtRwpYMDFJM+snGmZtbsyPKOg7XkZD8
	 5YOXLdKBPQ304oISytcB5UNFUDXCG8EeeaDHQgM0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4B20FF80606; Wed, 10 Jun 2026 09:58:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 49FD7F80606;
	Wed, 10 Jun 2026 09:58:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 03A22F801F5; Wed, 10 Jun 2026 00:18:21 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781043497;
	b=HEicj7mHkymchAEWvIv0rHNtbHdsSGv8EI3XFigACbzwV+NgKK7f5X638owMP0D7rlcK
	 eMfsuiv7ORGZwMBar2oA8a2m7H1SZsowMV5J94ynwefu3r3XMAJd/8k6hulpuanuNBsRY
	 GFWUTTQj+ozGThFKwrxJuEKs/b4NUyj/kz2p1MR3b7pX0g5c9tbcJvQTXAhaIfT+m02Ez
	 c7oonu0dtNt1jUiH38t2Ti86ubP24nNzfIQjrqCYFDfJOMowzZ3/yLV0YR9aSy6G0UYei
	 rr0oFZEzMHucO2K0z8/7hohYbji1TWiXTF6b7REGfKdIjZx4LAhe0xVh5lvhi0tfpKA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781043497;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Sz0vOnxXS1aB9WNoNrVQ4+rsRwzr8fA19p8UVE44/Q8=;
	b=Qp2G+yTB0wxidyZpVVucUNn/+fm78KN1xe6OWb1wxQAbmjk3j/nFyXRuiQwtqcbaxdd3
	 G63ajqAamHo/E2dtjw+5fz9DHg4e+GRanViIpfDbYS0RDXvUd6k74kM5l3XwlrzOuYK5O
	 Y+F2M8MgenUqVx92AozV1GJwztYKBzFrNNnXaHu9/P4MSj6o11nr6KPjI0Swp+IKCVq76
	 LhOvnos1ktytOvvP7kaorEAYQCB06onUYQyN7d8+D89ekD/p784yoIZTLOin2+AJHnkfS
	 Yw0TKrBKkPcOQbYyM3nx4l8jfIuCw39YbKJAviKBPMue4drEeCIr6rFf2U7iLUJ6DKw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UeLHZjNS;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com
 [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D006DF8058C
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 00:18:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D006DF8058C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UeLHZjNS
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-66039d3efcbso6216951d50.2
        for <alsa-devel@alsa-project.org>;
 Tue, 09 Jun 2026 15:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043495; x=1781648295;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFM2PPaWqmlxefco354ETeB7PVCiAaWpn1ByMKsDUio=;
        b=UeLHZjNSgQYxP1zNyN8jNznXsE6m41jcIeZGrud9vq4HO949PCKAvOHkdpDeICozlg
         XfXhYlhtrfNz0S5jmO6GP7eQmTotZFsujf+guGCNRMt0t1BqMQlPPmcCkoRMjAJusiLU
         kmib/dC/P0tKt61mbuZMGILtXEXlSekJb89d48GJnbZjHM0S52K4JBrDwhYKeiNRGNVd
         h0P8LwdLXs8SeIDHkrlguaMlLCPjvzot5riaxx9Oi9oHaxDhAbgr+Cd/xctaDc8FnhEH
         qgrBDoe/6CO3b+bpr80qOYBym/1tKxcVVkR3KBXIdVgQm0X+SDC8RIXumMgu7RP6W4fa
         9oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043495; x=1781648295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFM2PPaWqmlxefco354ETeB7PVCiAaWpn1ByMKsDUio=;
        b=FKUNDhg1wwg1IO3EPdJXdQA7E65e27fGAAxizLdJR+nTJVYsyRecB+byCNvVUGWNNs
         1wbbCFY23/2KZ8xIqlA9c4BqLpB9/iO8C0EOCFwNGu1SFnfU3+IMc57x+bcSLI26brNF
         gF3slykCXlm6eoxmBFmh5u9F+vRzXL8r3L0HTwJUJJqMRkB00VH8+TB6m7T/HRAcRlR/
         snqG7IcEvSTJbEZuyrjt7ErpLmHvMvkopeLfCXvcmoK3Aybfiir7HJA/rWbwNXCIbeQa
         wiIhjkuUIs1q9wvUbKLa1etQBV0/O+YopG7C4DWoT1w20KIl6espnGkYuBEXsE/41dCB
         STFQ==
X-Gm-Message-State: AOJu0Yyinxfk61iMNiBJ5fFcVwfyVSDynUiHIAB/cvka36IDj381Evmm
	lCbGSy5gs4qpi4QGg8iqPI5uVFSjRdJfMTttY/+6G1wAwFQQrtYDLcAx
X-Gm-Gg: Acq92OESQ4LDW0Lh8Ix2jyYSt13MSxjMdyr8KDoXJ1K57BymBzcEPMt137kVcdXbzo+
	ryJ5XGm8HXcWuYOMZDOFJM8IFf4sx6FZdt2gOFQG4G2WdV0Lrl99jRaDu0bHGdMJvxk8zE22mIb
	KCzBgO4PU6a+8lg7uNHS3HUXXvDC1CgI8NjzJQdzjb0mfZBJwfjS50WzbCWK3VQNpn+jJdC8zSK
	loEpne7u8YI1SUKTX2o4SV+wS1MYLiStkmjPxC9NrYSx+VdrNmWqrojFD5lBOuuC4wXClrXdMxq
	7IeEQ6rcT4RdXh+blyKNig6WZ0UqrdzyCSK8l3QFfNekzpY62VUer9lnHjUTLqTrf3Fb7Feqt36
	S4OaeHD7M/vJfOlDHYGSAzei9E/lEfOtpu6XTmQdEyy/DSIA2w36eTu+wGl11B2EiVQUxdFjA1b
	IWAA3EDTGSRL7nWItMkmGDpciudkuzsgitzAunv0FqVkMGYVyu4aPn6qNEIJH62XObCA+6CsMLL
	3efnBBT6i1TM9Da9tOXoAl1WxbGRKcpZuSmzmWXEtZHg8zEew==
X-Received: by 2002:a05:690e:43c6:b0:65c:468:7b6f with SMTP id
 956f58d0204a3-66106e88122mr14537030d50.25.1781043495212;
        Tue, 09 Jun 2026 15:18:15 -0700 (PDT)
Received: from alsa-dev.int.suenodeluz.com.do ([74.244.193.113])
        by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-660d6205a5bsm11414260d50.10.2026.06.09.15.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:18:14 -0700 (PDT)
From: Frank van de Pol <fvdpol@gmail.com>
To: tiwai@suse.de,
	perex@perex.cz
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Frank van de Pol <fvdpol@gmail.com>
Subject: [PATCH 1/1] ALSA: usb: Add support for Reloop Jockey 3 DJ controllers
Date: Tue,  9 Jun 2026 18:16:43 -0400
Message-ID: <20260609221643.3439698-2-fvdpol@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609221643.3439698-1-fvdpol@gmail.com>
References: <20260609221643.3439698-1-fvdpol@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: fvdpol@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: PWFLWDNKQQXAUQWHVYW4EGZ5ADAO5ZDS
X-Message-ID-Hash: PWFLWDNKQQXAUQWHVYW4EGZ5ADAO5ZDS
X-Mailman-Approved-At: Wed, 10 Jun 2026 07:58:25 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PWFLWDNKQQXAUQWHVYW4EGZ5ADAO5ZDS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Introduce a dedicated repository subdirectory and driver for the Reloop
Jockey 3 Master Edition and Reloop Jockey 3 Remix USB DJ controllers.

Because these devices utilize a non-standard, proprietary Ploytec USB
framing protocol instead of standard USB Audio Class (UAC) mechanisms,
they require specialized handling outside of standard quirks.

This driver provides:
 - 24-bit multi-channel (6x4) audio capture and playback.
 - Support for 44.1, 48, 88.2, and 96 kHz sample rates.
 - ALSA RawMIDI input and output mapping for the integrated control surface.

The custom Ploytec encapsulation and streaming format was successfully
reverse-engineered via USB protocol analysis and is isolated cleanly into
a local hardware-independent codec abstraction.

Signed-off-by: Frank van de Pol <fvdpol@gmail.com>
---
 MAINTAINERS                       |   7 +
 sound/usb/Kconfig                 |   1 +
 sound/usb/Makefile                |   1 +
 sound/usb/jockey3/Kconfig         |  19 +
 sound/usb/jockey3/Makefile        |   3 +
 sound/usb/jockey3/jockey3.c       | 841 ++++++++++++++++++++++++++++++
 sound/usb/jockey3/ploytec_codec.c | 116 +++++
 sound/usb/jockey3/ploytec_codec.h |  34 ++
 8 files changed, 1022 insertions(+)
 create mode 100644 sound/usb/jockey3/Kconfig
 create mode 100644 sound/usb/jockey3/Makefile
 create mode 100644 sound/usb/jockey3/jockey3.c
 create mode 100644 sound/usb/jockey3/ploytec_codec.c
 create mode 100644 sound/usb/jockey3/ploytec_codec.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ec290e38b44..c73a2bcec584 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22530,6 +22530,13 @@ F:	Documentation/filesystems/relay.rst
 F:	include/linux/relay.h
 F:	kernel/relay.c
 
+RELOOP JOCKEY 3 DJ CONTROLLER DRIVER
+M:	Frank van de Pol <fvdpol@gmail.com>
+L:	linux-sound@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
+F:	sound/usb/jockey3/
+
 REGISTER MAP ABSTRACTION
 M:	Mark Brown <broonie@kernel.org>
 L:	linux-kernel@vger.kernel.org
diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index b4588915efa1..d7edfbaf099b 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -205,6 +205,7 @@ config SND_USB_AUDIO_QMI
 	  will be called snd-usb-audio-qmi.
 
 source "sound/usb/line6/Kconfig"
+source "sound/usb/jockey3/Kconfig"
 
 endif	# SND_USB
 
diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index e62794a87e73..1f045c00dbc9 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -37,3 +37,4 @@ obj-$(CONFIG_SND_USB_US122L) += snd-usbmidi-lib.o
 
 obj-$(CONFIG_SND) += misc/ usx2y/ caiaq/ 6fire/ hiface/ bcd2000/ qcom/
 obj-$(CONFIG_SND_USB_LINE6)	+= line6/
+obj-$(CONFIG_SND_USB_JOCKEY3) += jockey3/
diff --git a/sound/usb/jockey3/Kconfig b/sound/usb/jockey3/Kconfig
new file mode 100644
index 000000000000..0e397a987a11
--- /dev/null
+++ b/sound/usb/jockey3/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config SND_USB_JOCKEY3
+	tristate "Reloop Jockey 3 support"
+	default m
+	depends on SND_USB && USB
+	select SND_PCM
+	select SND_RAWMIDI
+	help
+	  Say Y here to include support for the Reloop Jockey 3 DJ controllers.
+          These devices utilize a non-standard, proprietary Ploytec USB
+          protocol.
+
+	  Supported devices:
+
+            * Reloop Jockey 3 Master Edition
+            * Reloop Jockey 3 Remix
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-usb-jockey3.
diff --git a/sound/usb/jockey3/Makefile b/sound/usb/jockey3/Makefile
new file mode 100644
index 000000000000..833a5766985e
--- /dev/null
+++ b/sound/usb/jockey3/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_SND_USB_JOCKEY3) += snd-reloop-jockey3.o
+snd-reloop-jockey3-objs := jockey3.o ploytec_codec.o
\ No newline at end of file
diff --git a/sound/usb/jockey3/jockey3.c b/sound/usb/jockey3/jockey3.c
new file mode 100644
index 000000000000..8c215d3fc8b0
--- /dev/null
+++ b/sound/usb/jockey3/jockey3.c
@@ -0,0 +1,841 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   ALSA driver for Reloop Jockey 3 devices
+ *
+ *   Copyright (c) 2026 by Frank van de Pol <fvdpol@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/rawmidi.h>
+#include <sound/pcm.h>
+#include <linux/mutex.h>
+#include <linux/cleanup.h>
+#include "ploytec_codec.h"
+
+#define RELOOP_VENDOR_ID         0x200c
+#define RELOOP_JOCKEY3_ME_PID    0x1009
+#define RELOOP_JOCKEY3_REMIX_PID 0x1037
+
+enum { JOCKEY3_ME, JOCKEY3_REMIX };
+
+#define JOCKEY3_N_URBS 8
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
+static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
+static int debug;
+
+#define CARD_NAME "Reloop Jockey 3"
+
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
+module_param_array(id, charp, NULL, 0444);
+MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
+module_param_array(enable, bool, NULL, 0444);
+MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Enable debug messages for " CARD_NAME " soundcard.");
+
+#define J3_DEBUG
+#ifdef J3_DEBUG
+#define j3_dbg(dev, fmt, ...) \
+	do { \
+		if (debug) \
+			dev_info(dev, fmt, ##__VA_ARGS__); \
+	} while (0)
+#else
+#define j3_dbg(dev, fmt, ...) \
+	do { } while (0)
+#endif
+
+struct jockey3_chip {
+	struct snd_card *card;
+	struct usb_device *dev;
+	struct usb_interface *intf0;
+	struct usb_interface *intf1;
+	unsigned char *xfer_buf;
+	unsigned int current_rate;
+	unsigned int midi_out_acc;
+	struct mutex rate_mutex; // serializes sample rate changes and active stream tracking
+	int active_streams;
+
+	struct urb *midi_in_urb;
+	unsigned char *midi_in_buf;
+	struct snd_rawmidi *rmidi;
+	struct snd_rawmidi_substream *midi_in_substream;
+	struct snd_rawmidi_substream *midi_out_substream;
+	spinlock_t midi_lock; // protects MIDI substreams in completion handlers and rate-limiting
+
+	struct snd_pcm *pcm;
+	struct snd_pcm_substream *playback_substream;
+	struct urb *playback_urbs[JOCKEY3_N_URBS];
+	unsigned char *playback_bufs[JOCKEY3_N_URBS];
+	spinlock_t playback_lock; // protects playback stream state and buffer offsets
+	unsigned int dma_off;
+	unsigned int period_off;
+	bool stream_running;
+
+	struct snd_pcm_substream *capture_substream;
+	struct urb *capture_urbs[JOCKEY3_N_URBS];
+	unsigned char *capture_bufs[JOCKEY3_N_URBS];
+	spinlock_t capture_lock; // protects capture stream state and buffer offsets
+	unsigned int capture_dma_off;
+	unsigned int capture_period_off;
+	bool capture_running;
+};
+
+static void jockey3_process_out_packet(struct jockey3_chip *chip, u8 *urb_buf)
+{
+	struct snd_pcm_substream *substream = chip->playback_substream;
+	struct snd_pcm_runtime *runtime;
+	unsigned int pcm_buffer_size;
+	unsigned int alsa_frame_size;
+	int f;
+
+	if (unlikely(!substream || !substream->runtime))
+		return;
+
+	runtime = substream->runtime;
+	if (unlikely(!runtime->dma_area))
+		return;
+
+	pcm_buffer_size = snd_pcm_lib_buffer_bytes(substream);
+	alsa_frame_size = runtime->channels * 3;
+
+	for (f = 0; f < PLOYTEC_PLAYBACK_FRAMES; f++) {
+		ploytec_encode_s24_3le(urb_buf + f * PLOYTEC_PLAYBACK_FRAME_SIZE,
+				       runtime->dma_area + chip->dma_off);
+		chip->dma_off += alsa_frame_size;
+		if (chip->dma_off >= pcm_buffer_size)
+			chip->dma_off -= pcm_buffer_size;
+		chip->period_off += alsa_frame_size;
+	}
+
+	if (chip->period_off >= runtime->period_size * alsa_frame_size) {
+		chip->period_off %= runtime->period_size * alsa_frame_size;
+		snd_pcm_period_elapsed(substream);
+	}
+}
+
+static void jockey3_process_in_packet(struct jockey3_chip *chip, const u8 *urb_buf)
+{
+	struct snd_pcm_substream *substream = chip->capture_substream;
+	struct snd_pcm_runtime *runtime;
+	unsigned int pcm_buffer_size;
+	unsigned int alsa_frame_size;
+	int f;
+
+	if (unlikely(!substream || !substream->runtime))
+		return;
+
+	runtime = substream->runtime;
+	if (unlikely(!runtime->dma_area))
+		return;
+
+	pcm_buffer_size = snd_pcm_lib_buffer_bytes(substream);
+	alsa_frame_size = runtime->channels * 3; // 6 * 3 = 18 bytes
+
+	for (f = 0; f < PLOYTEC_CAPTURE_FRAMES; f++) {
+		ploytec_decode_s24_3le(runtime->dma_area + chip->capture_dma_off,
+				       urb_buf + f * PLOYTEC_CAPTURE_FRAME_SIZE);
+		chip->capture_dma_off += alsa_frame_size;
+		if (chip->capture_dma_off >= pcm_buffer_size)
+			chip->capture_dma_off -= pcm_buffer_size;
+		chip->capture_period_off += alsa_frame_size;
+	}
+
+	if (chip->capture_period_off >= runtime->period_size * alsa_frame_size) {
+		chip->capture_period_off %= runtime->period_size * alsa_frame_size;
+		snd_pcm_period_elapsed(substream);
+	}
+}
+
+static void jockey3_capture_callback(struct urb *urb)
+{
+	struct jockey3_chip *chip = urb->context;
+	int ret;
+
+	if (urb->status) {
+		if (urb->status == -ENOENT || urb->status == -ECONNRESET ||
+		    urb->status == -ESHUTDOWN || urb->status == -EPROTO)
+			return;
+		dev_err(&chip->intf0->dev, "Capture URB error: %d\n",
+			urb->status);
+	} else {
+		scoped_guard(spinlock_irqsave, &chip->capture_lock) {
+			if (chip->capture_running && chip->capture_substream)
+				jockey3_process_in_packet(chip, urb->transfer_buffer);
+		}
+	}
+
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	if (ret < 0 && ret != -ENODEV && ret != -EPERM)
+		dev_err(&chip->intf0->dev, "Failed to resubmit capture URB: %d\n", ret);
+}
+
+static void jockey3_playback_callback(struct urb *urb)
+{
+	struct jockey3_chip *chip = urb->context;
+	unsigned char *buf = (unsigned char *)urb->transfer_buffer;
+	int i, ret;
+
+	if (urb->status) {
+		if (urb->status == -ENOENT || urb->status == -ECONNRESET ||
+		    urb->status == -ESHUTDOWN || urb->status == -EPROTO)
+			return;
+		dev_err(&chip->intf0->dev, "Playback URB error: %d\n", urb->status);
+	} else {
+		guard(spinlock_irqsave)(&chip->playback_lock);
+		if (chip->stream_running && chip->playback_substream)
+			jockey3_process_out_packet(chip, buf);
+		else
+			memset(buf, 0, PLOYTEC_PKT_SIZE);
+
+		guard(spinlock)(&chip->midi_lock);
+
+		/*
+		 * Rate limit MIDI to ~3125 bytes/sec (standard MIDI baud rate).
+		 * The Ploytec firmware has a small MIDI buffer; sending at the
+		 * PCM packet rate (~4410-4800 pkts/sec) causes buffer overflows
+		 * and message truncation in the device.
+		 */
+		chip->midi_out_acc += 3125;
+		if (chip->midi_out_acc >= (chip->current_rate / 10)) {
+			chip->midi_out_acc -= (chip->current_rate / 10);
+			if (chip->midi_out_substream) {
+				u8 byte;
+
+				if (snd_rawmidi_transmit(chip->midi_out_substream, &byte, 1) == 1)
+					buf[480] = byte;
+				else
+					buf[480] = PLOYTEC_MIDI_IDLE_BYTE;
+			} else {
+				buf[480] = PLOYTEC_MIDI_IDLE_BYTE;
+			}
+		} else {
+			buf[480] = PLOYTEC_MIDI_IDLE_BYTE;
+		}
+
+		/* Ploytec Sync byte and gap padding */
+		buf[481] = 0xFF;
+		for (i = 482; i < PLOYTEC_PKT_SIZE; i++)
+			buf[i] = PLOYTEC_MIDI_IDLE_BYTE;
+	}
+
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	if (ret < 0 && ret != -ENODEV && ret != -EPERM)
+		dev_err(&chip->intf0->dev, "Failed to resubmit playback URB: %d\n", ret);
+}
+
+static void jockey3_midi_in_callback(struct urb *urb)
+{
+	struct jockey3_chip *chip = urb->context;
+	unsigned char *buf = (unsigned char *)urb->transfer_buffer;
+	int i, ret;
+
+	if (urb->status) {
+		if (urb->status == -ENOENT || urb->status == -ECONNRESET ||
+		    urb->status == -ESHUTDOWN || urb->status == -EPROTO)
+			return;
+		dev_err(&chip->intf0->dev, "MIDI IN URB error: %d\n", urb->status);
+	} else {
+		scoped_guard(spinlock_irqsave, &chip->midi_lock) {
+			if (chip->midi_in_substream) {
+				for (i = 0; i < urb->actual_length; i++) {
+					if (buf[i] != PLOYTEC_MIDI_IDLE_BYTE && buf[i] != 0xF9) {
+						j3_dbg(&chip->intf0->dev, "MIDI IN: 0x%02x\n",
+						       buf[i]);
+						snd_rawmidi_receive(chip->midi_in_substream,
+								    &buf[i], 1);
+					}
+				}
+			}
+		}
+	}
+
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	if (ret < 0 && ret != -ENODEV && ret != -EPERM)
+		dev_err(&chip->intf0->dev, "Failed to resubmit MIDI IN URB: %d\n", ret);
+}
+
+static void jockey3_stop_urbs(struct jockey3_chip *chip)
+{
+	int i;
+
+	j3_dbg(&chip->intf0->dev, "Stopping all URBs\n");
+	usb_kill_urb(chip->midi_in_urb);
+	for (i = 0; i < JOCKEY3_N_URBS; i++) {
+		usb_kill_urb(chip->playback_urbs[i]);
+		usb_kill_urb(chip->capture_urbs[i]);
+	}
+}
+
+static void jockey3_start_urbs(struct jockey3_chip *chip)
+{
+	int i, ret;
+
+	j3_dbg(&chip->intf0->dev, "Starting all URBs\n");
+	for (i = 0; i < JOCKEY3_N_URBS; i++) {
+		ret = usb_submit_urb(chip->playback_urbs[i], GFP_KERNEL);
+		if (ret < 0)
+			dev_err(&chip->intf0->dev, "Failed to submit playback URB %d: %d\n",
+				i, ret);
+		ret = usb_submit_urb(chip->capture_urbs[i], GFP_KERNEL);
+		if (ret < 0)
+			dev_err(&chip->intf0->dev, "Failed to submit capture URB %d: %d\n",
+				i, ret);
+	}
+	ret = usb_submit_urb(chip->midi_in_urb, GFP_KERNEL);
+	if (ret < 0)
+		dev_err(&chip->intf0->dev, "Failed to submit MIDI IN URB: %d\n", ret);
+}
+
+static int jockey3_set_rate(struct jockey3_chip *chip, unsigned int rate)
+{
+	int ret;
+
+	chip->xfer_buf[0] = rate & 0xFF;
+	chip->xfer_buf[1] = (rate >> 8) & 0xFF;
+	chip->xfer_buf[2] = (rate >> 16) & 0xFF;
+
+	j3_dbg(&chip->intf0->dev, "Setting rate to %u Hz\n", rate);
+	ret = usb_control_msg_send(chip->dev, 0, 0x01, 0x22, 0x0100, 0x0086,
+				   chip->xfer_buf, 3, 2000, GFP_KERNEL);
+	if (ret < 0) {
+		dev_err(&chip->intf0->dev, "Failed to set rate on EP 0x86: %d\n", ret);
+		return ret;
+	}
+	j3_dbg(&chip->intf0->dev, "Rate set on EP 0x86 OK\n");
+	msleep(50);
+	ret = usb_control_msg_send(chip->dev, 0, 0x01, 0x22, 0x0100, 0x0005,
+				   chip->xfer_buf, 3, 2000, GFP_KERNEL);
+	if (ret < 0) {
+		dev_err(&chip->intf0->dev, "Failed to set rate on EP 0x05: %d\n", ret);
+		return ret;
+	}
+	j3_dbg(&chip->intf0->dev, "Rate set on EP 0x05 OK\n");
+	msleep(50);
+	return 0;
+}
+
+static int jockey3_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct jockey3_chip *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	j3_dbg(&chip->intf0->dev, "PCM open stream %d\n", substream->stream);
+
+	runtime->hw.info =
+		SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_MMAP_VALID;
+	runtime->hw.formats = SNDRV_PCM_FMTBIT_S24_3LE;
+	runtime->hw.rates =
+		SNDRV_PCM_RATE_44100 |
+		SNDRV_PCM_RATE_48000 |
+		SNDRV_PCM_RATE_88200 |
+		SNDRV_PCM_RATE_96000;
+	runtime->hw.rate_min = 44100;
+	runtime->hw.rate_max = 96000;
+	runtime->hw.buffer_bytes_max = 1024 * 1024;
+	runtime->hw.period_bytes_min = 64;
+	runtime->hw.period_bytes_max = 512 * 1024;
+	runtime->hw.periods_min = 2;
+	runtime->hw.periods_max = 1024;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		runtime->hw.channels_min = 4;
+		runtime->hw.channels_max = 4;
+		chip->playback_substream = substream;
+	} else {
+		runtime->hw.channels_min = 6;
+		runtime->hw.channels_max = 6;
+		chip->capture_substream = substream;
+	}
+
+	guard(mutex)(&chip->rate_mutex);
+	chip->active_streams++;
+	j3_dbg(&chip->intf0->dev, "active_streams incremented to %d\n", chip->active_streams);
+
+	return 0;
+}
+
+static int jockey3_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct jockey3_chip *chip = snd_pcm_substream_chip(substream);
+
+	j3_dbg(&chip->intf0->dev, "PCM close stream %d\n", substream->stream);
+
+	guard(mutex)(&chip->rate_mutex);
+	chip->active_streams--;
+	j3_dbg(&chip->intf0->dev, "active_streams decremented to %d\n", chip->active_streams);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		chip->playback_substream = NULL;
+	else
+		chip->capture_substream = NULL;
+	return 0;
+}
+
+static int jockey3_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct jockey3_chip *chip = snd_pcm_substream_chip(substream);
+
+	j3_dbg(&chip->intf0->dev, "PCM prepare stream %d\n", substream->stream);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		chip->dma_off = 0;
+		chip->period_off = 0;
+	} else {
+		chip->capture_dma_off = 0;
+		chip->capture_period_off = 0;
+	}
+	return 0;
+}
+
+static int jockey3_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct jockey3_chip *chip = snd_pcm_substream_chip(substream);
+
+	j3_dbg(&chip->intf0->dev, "PCM trigger stream %d, cmd %d\n", substream->stream, cmd);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (cmd == SNDRV_PCM_TRIGGER_START)
+			chip->stream_running = true;
+		else if (cmd == SNDRV_PCM_TRIGGER_STOP)
+			chip->stream_running = false;
+	} else {
+		if (cmd == SNDRV_PCM_TRIGGER_START)
+			chip->capture_running = true;
+		else if (cmd == SNDRV_PCM_TRIGGER_STOP)
+			chip->capture_running = false;
+	}
+
+	return 0;
+}
+
+static snd_pcm_uframes_t jockey3_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct jockey3_chip *chip = snd_pcm_substream_chip(substream);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return bytes_to_frames(substream->runtime, chip->dma_off);
+	else
+		return bytes_to_frames(substream->runtime, chip->capture_dma_off);
+}
+
+static int jockey3_handshake_step(struct jockey3_chip *chip)
+{
+	u8 status;
+	int ret;
+
+	ret = usb_set_interface(chip->dev, 0, 1);
+	if (ret < 0) {
+		dev_err(&chip->intf0->dev, "Failed to set altsetting 1 on interface 0: %d\n", ret);
+		return ret;
+	}
+	msleep(20);
+	ret = usb_set_interface(chip->dev, 1, 1);
+	if (ret < 0) {
+		dev_err(&chip->intf0->dev, "Failed to set altsetting 1 on interface 1: %d\n", ret);
+		return ret;
+	}
+	msleep(20);
+
+	ret = usb_control_msg_recv(chip->dev, 0, 0x56, 0xC0, 0, 0, chip->xfer_buf, 15, 2000,
+				   GFP_KERNEL);
+	if (ret < 0)
+		j3_dbg(&chip->intf0->dev, "Handshake step 1 (0x56) failed: %d (ignoring)\n", ret);
+	msleep(20);
+
+	ret = usb_control_msg_recv(chip->dev, 0, 0x49, 0xC0, 0, 0, chip->xfer_buf, 1, 2000,
+				   GFP_KERNEL);
+	if (ret < 0) {
+		dev_err(&chip->intf0->dev, "Handshake step 2 (0x49 R) failed: %d\n", ret);
+		return ret;
+	}
+	status = chip->xfer_buf[0];
+	msleep(20);
+
+	if (!(status & 0x20)) {
+		ret = usb_control_msg_send(chip->dev, 0, 0x49, 0x40,
+					   (uint16_t)(int16_t)(int8_t)(status | 0x20), 0,
+					   NULL, 0, 2000, GFP_KERNEL);
+		if (ret < 0) {
+			dev_err(&chip->intf0->dev, "Handshake step 3 (0x49 W) failed: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int jockey3_pcm_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *hw_params)
+{
+	struct jockey3_chip *chip = snd_pcm_substream_chip(substream);
+	unsigned int rate = params_rate(hw_params);
+	int ret = 0;
+
+	j3_dbg(&chip->intf0->dev, "PCM hw_params rate %u, active_streams %d\n",
+	       rate, chip->active_streams);
+
+	guard(mutex)(&chip->rate_mutex);
+
+	if (chip->current_rate == rate) {
+		j3_dbg(&chip->intf0->dev, "Rate already set to %u, skipping change\n", rate);
+		return 0;
+	}
+
+	if (chip->active_streams > 1) {
+		dev_err(&chip->intf0->dev, "Cannot change rate while other stream is active\n");
+		return -EBUSY;
+	}
+
+	jockey3_stop_urbs(chip);
+	msleep(50);
+
+	ret = jockey3_set_rate(chip, rate);
+	if (ret == 0) {
+		chip->current_rate = rate;
+		j3_dbg(&chip->intf0->dev, "Rate changed to %u successfully, resetting device\n",
+		       rate);
+		/*
+		 * Mandatory: Ploytec chipsets require a full USB reset to re-synchronize
+		 * the internal engine after a sample rate change. Without this, the
+		 * Capture EP (0x86) may stop transmitting data, leading to EIO.
+		 * pre_reset/post_reset callbacks handle the URB lifecycle.
+		 */
+		usb_reset_device(chip->dev);
+	} else {
+		dev_err(&chip->intf0->dev, "Rate change to %u failed: %d\n", rate, ret);
+		jockey3_start_urbs(chip);
+	}
+
+	return ret;
+}
+
+static const struct snd_pcm_ops jockey3_pcm_ops = {
+	.open = jockey3_pcm_open,
+	.close = jockey3_pcm_close,
+	.hw_params = jockey3_pcm_hw_params,
+	.prepare = jockey3_pcm_prepare,
+	.trigger = jockey3_pcm_trigger,
+	.pointer = jockey3_pcm_pointer,
+};
+
+static int jockey3_midi_in_open(struct snd_rawmidi_substream *substream)
+{
+	return 0;
+}
+
+static int jockey3_midi_in_close(struct snd_rawmidi_substream *substream)
+{
+	return 0;
+}
+
+static void jockey3_midi_in_trigger(struct snd_rawmidi_substream *substream, int up)
+{
+	struct jockey3_chip *chip = substream->rmidi->private_data;
+
+	guard(spinlock_irqsave)(&chip->midi_lock);
+	chip->midi_in_substream = up ? substream : NULL;
+}
+
+static int jockey3_midi_out_open(struct snd_rawmidi_substream *substream)
+{
+	return 0;
+}
+
+static int jockey3_midi_out_close(struct snd_rawmidi_substream *substream)
+{
+	return 0;
+}
+
+static void jockey3_midi_out_trigger(struct snd_rawmidi_substream *substream, int up)
+{
+	struct jockey3_chip *chip = substream->rmidi->private_data;
+
+	guard(spinlock_irqsave)(&chip->midi_lock);
+	chip->midi_out_substream = up ? substream : NULL;
+}
+
+static const struct snd_rawmidi_ops jockey3_midi_in_ops = {
+	.open = jockey3_midi_in_open,
+	.close = jockey3_midi_in_close,
+	.trigger = jockey3_midi_in_trigger
+};
+
+static const struct snd_rawmidi_ops jockey3_midi_out_ops = {
+	.open = jockey3_midi_out_open,
+	.close = jockey3_midi_out_close,
+	.trigger = jockey3_midi_out_trigger
+};
+
+static int jockey3_handshake(struct jockey3_chip *chip)
+{
+	int ret;
+
+	ret = jockey3_handshake_step(chip);
+	if (ret < 0)
+		return ret;
+
+	chip->current_rate = 44100;
+	ret = jockey3_set_rate(chip, 44100);
+	if (ret < 0)
+		return ret;
+	msleep(20);
+
+	j3_dbg(&chip->intf0->dev, "Handshake complete.\n");
+
+	jockey3_start_urbs(chip);
+
+	return 0;
+}
+
+static const struct usb_device_id jockey3_ids[] = {
+	{ USB_DEVICE(RELOOP_VENDOR_ID, RELOOP_JOCKEY3_ME_PID), .driver_info = JOCKEY3_ME },
+	{ USB_DEVICE(RELOOP_VENDOR_ID, RELOOP_JOCKEY3_REMIX_PID), .driver_info = JOCKEY3_REMIX },
+	{}
+};
+MODULE_DEVICE_TABLE(usb, jockey3_ids);
+
+static struct usb_driver jockey3_driver;
+
+static void jockey3_release_intf1(void *data)
+{
+	struct usb_interface *intf1 = data;
+
+	usb_driver_release_interface(&jockey3_driver, intf1);
+}
+
+static void jockey3_free_urb_action(void *data)
+{
+	usb_free_urb(data);
+}
+
+static void jockey3_stop_urbs_action(void *data)
+{
+	jockey3_stop_urbs(data);
+}
+
+static int jockey3_probe(struct usb_interface *intf, const struct usb_device_id *usb_id)
+{
+	struct usb_device *dev = interface_to_usbdev(intf);
+	struct usb_interface *intf1;
+	struct snd_card *card;
+	struct jockey3_chip *chip;
+	char *jockey3_type;
+	int ret, i, j;
+	static int dev_idx;
+
+	if (intf->cur_altsetting->desc.bInterfaceNumber != 0)
+		return -ENODEV;
+
+	intf1 = usb_ifnum_to_if(dev, 1);
+	if (!intf1)
+		return -ENODEV;
+
+	while (dev_idx < SNDRV_CARDS && !enable[dev_idx])
+		dev_idx++;
+
+	if (dev_idx >= SNDRV_CARDS)
+		return -ENODEV;
+
+	ret = snd_devm_card_new(&intf->dev, index[dev_idx], id[dev_idx], THIS_MODULE,
+				sizeof(struct jockey3_chip), &card);
+	if (ret < 0)
+		return ret;
+
+	chip = card->private_data;
+	chip->card = card;
+	chip->dev = dev;
+	chip->intf0 = intf;
+	chip->intf1 = intf1;
+	chip->midi_out_acc = 0;
+	spin_lock_init(&chip->midi_lock);
+	spin_lock_init(&chip->playback_lock);
+	spin_lock_init(&chip->capture_lock);
+	mutex_init(&chip->rate_mutex);
+
+	chip->xfer_buf = devm_kmalloc(&intf->dev, 64, GFP_KERNEL);
+	if (!chip->xfer_buf)
+		return -ENOMEM;
+
+	chip->midi_in_buf = devm_kmalloc(&intf->dev, PLOYTEC_PKT_SIZE, GFP_KERNEL);
+	if (!chip->midi_in_buf)
+		return -ENOMEM;
+
+	chip->midi_in_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!chip->midi_in_urb)
+		return -ENOMEM;
+	ret = devm_add_action_or_reset(&intf->dev, jockey3_free_urb_action, chip->midi_in_urb);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < JOCKEY3_N_URBS; i++) {
+		chip->playback_bufs[i] = devm_kzalloc(&intf->dev, PLOYTEC_PKT_SIZE, GFP_KERNEL);
+		if (!chip->playback_bufs[i])
+			return -ENOMEM;
+
+		chip->playback_urbs[i] = usb_alloc_urb(0, GFP_KERNEL);
+		if (!chip->playback_urbs[i])
+			return -ENOMEM;
+		ret = devm_add_action_or_reset(&intf->dev, jockey3_free_urb_action,
+					       chip->playback_urbs[i]);
+		if (ret)
+			return ret;
+
+		/* Initial pattern: all MIDI positions are idle, sync byte at 481 */
+		for (j = 480; j < PLOYTEC_PKT_SIZE; j++)
+			chip->playback_bufs[i][j] = PLOYTEC_MIDI_IDLE_BYTE;
+		chip->playback_bufs[i][481] = 0xFF;
+
+		usb_fill_bulk_urb(chip->playback_urbs[i], dev,
+				  usb_sndbulkpipe(dev, PLOYTEC_EP_PCM_OUT),
+				  chip->playback_bufs[i], PLOYTEC_PKT_SIZE,
+				  jockey3_playback_callback, chip);
+
+		chip->capture_bufs[i] = devm_kzalloc(&intf->dev, PLOYTEC_PKT_SIZE, GFP_KERNEL);
+		if (!chip->capture_bufs[i])
+			return -ENOMEM;
+
+		chip->capture_urbs[i] = usb_alloc_urb(0, GFP_KERNEL);
+		if (!chip->capture_urbs[i])
+			return -ENOMEM;
+		ret = devm_add_action_or_reset(&intf->dev, jockey3_free_urb_action,
+					       chip->capture_urbs[i]);
+		if (ret)
+			return ret;
+
+		usb_fill_bulk_urb(chip->capture_urbs[i], dev,
+				  usb_rcvbulkpipe(dev, PLOYTEC_EP_PCM_IN),
+				  chip->capture_bufs[i], PLOYTEC_PKT_SIZE,
+				  jockey3_capture_callback, chip);
+	}
+
+	usb_fill_bulk_urb(chip->midi_in_urb, dev,
+			  usb_rcvbulkpipe(dev, PLOYTEC_EP_MIDI_IN),
+			  chip->midi_in_buf, PLOYTEC_PKT_SIZE,
+			  jockey3_midi_in_callback, chip);
+
+	/* Stop all URBs on disconnect */
+	ret = devm_add_action(&intf->dev, jockey3_stop_urbs_action, chip);
+	if (ret)
+		return ret;
+
+	ret = snd_pcm_new(card, CARD_NAME " Audio", 0, 1, 1, &chip->pcm);
+	if (ret < 0)
+		return ret;
+
+	strscpy(chip->pcm->name, CARD_NAME " Audio", sizeof(chip->pcm->name));
+	chip->pcm->private_data = chip;
+	snd_pcm_set_ops(chip->pcm, SNDRV_PCM_STREAM_PLAYBACK, &jockey3_pcm_ops);
+	snd_pcm_set_ops(chip->pcm, SNDRV_PCM_STREAM_CAPTURE, &jockey3_pcm_ops);
+	snd_pcm_set_managed_buffer_all(chip->pcm, SNDRV_DMA_TYPE_VMALLOC, NULL, 0, 0);
+
+	ret = snd_rawmidi_new(card, CARD_NAME " MIDI", 0, 1, 1, &chip->rmidi);
+	if (ret < 0)
+		return ret;
+
+	chip->rmidi->private_data = chip;
+	strscpy(chip->rmidi->name, CARD_NAME " MIDI", sizeof(chip->rmidi->name));
+	snd_rawmidi_set_ops(chip->rmidi, SNDRV_RAWMIDI_STREAM_INPUT, &jockey3_midi_in_ops);
+	snd_rawmidi_set_ops(chip->rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, &jockey3_midi_out_ops);
+	chip->rmidi->info_flags = SNDRV_RAWMIDI_INFO_INPUT |
+				  SNDRV_RAWMIDI_INFO_OUTPUT |
+				  SNDRV_RAWMIDI_INFO_DUPLEX;
+
+	strscpy(card->driver, "snd-reloop-jockey3", sizeof(card->driver));
+	strscpy(card->shortname, CARD_NAME, sizeof(card->shortname));
+
+	switch (usb_id->driver_info) {
+	case JOCKEY3_ME:
+		jockey3_type = "Master Edition";
+		break;
+	case JOCKEY3_REMIX:
+		jockey3_type = "Remix";
+		break;
+	default:
+		jockey3_type = "Unknown";
+	}
+	snprintf(card->longname, sizeof(card->longname),
+		 "%s %s at USB %s", CARD_NAME, jockey3_type, dev_name(&dev->dev));
+
+	if (card->id[0] == '\0')
+		snd_card_set_id(card, "RJ3");
+
+	ret = usb_driver_claim_interface(&jockey3_driver, intf1, chip);
+	if (ret < 0)
+		return ret;
+	ret = devm_add_action_or_reset(&intf->dev, jockey3_release_intf1, intf1);
+	if (ret)
+		return ret;
+
+	ret = snd_card_register(card);
+	if (ret < 0)
+		return ret;
+
+	usb_set_intfdata(intf, chip);
+	ret = jockey3_handshake(chip);
+	if (ret < 0)
+		return ret;
+
+	dev_idx++;
+	return 0;
+}
+
+static void jockey3_disconnect(struct usb_interface *intf)
+{
+	struct jockey3_chip *chip = usb_get_intfdata(intf);
+
+	if (chip && intf == chip->intf0) {
+		chip->stream_running = false;
+		chip->capture_running = false;
+		/*
+		 * Card cleanup, URB stopping/freeing, and interface release
+		 * are all handled automatically by devres.
+		 */
+	}
+	usb_set_intfdata(intf, NULL);
+}
+
+static int jockey3_pre_reset(struct usb_interface *intf)
+{
+	struct jockey3_chip *chip = usb_get_intfdata(intf);
+
+	if (chip && intf == chip->intf0)
+		jockey3_stop_urbs(chip);
+	return 0;
+}
+
+static int jockey3_post_reset(struct usb_interface *intf)
+{
+	struct jockey3_chip *chip = usb_get_intfdata(intf);
+
+	if (chip && intf == chip->intf0) {
+		jockey3_handshake_step(chip);
+		jockey3_start_urbs(chip);
+	}
+	return 0;
+}
+
+static struct usb_driver jockey3_driver = {
+	.name = "snd-reloop-jockey3",
+	.probe = jockey3_probe,
+	.disconnect = jockey3_disconnect,
+	.pre_reset = jockey3_pre_reset,
+	.post_reset = jockey3_post_reset,
+	.id_table = jockey3_ids
+};
+
+module_usb_driver(jockey3_driver);
+
+MODULE_AUTHOR("Frank van de Pol");
+MODULE_DESCRIPTION(CARD_NAME " ALSA Driver");
+MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: snd-pcm snd-rawmidi");
diff --git a/sound/usb/jockey3/ploytec_codec.c b/sound/usb/jockey3/ploytec_codec.c
new file mode 100644
index 000000000000..d4bc122d3282
--- /dev/null
+++ b/sound/usb/jockey3/ploytec_codec.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   ALSA driver for Reloop Jockey 3 devices
+ *
+ *   Copyright (c) 2026 by Frank van de Pol <fvdpol@gmail.com>
+ */
+
+#include "ploytec_codec.h"
+
+/**
+ * ploytec_encode_s24_3le - Encode 4-channel S24_3LE to 48-byte Ploytec frame
+ * @dest: 48-byte destination buffer
+ * @src: 12-byte source buffer (4 channels * 3 bytes)
+ */
+void ploytec_encode_s24_3le(u8 *dest, const u8 *src)
+{
+	int i;
+
+	/* First 24 bytes: odd channels (ALSA Ch 1 & 3) */
+	for (i = 0; i < 8; i++) {
+		dest[i] = (((src[2] >> (7 - i)) & 1) << 0) |
+			  (((src[8] >> (7 - i)) & 1) << 1);
+	}
+	for (i = 0; i < 8; i++) {
+		dest[8 + i] = (((src[1] >> (7 - i)) & 1) << 0) |
+			      (((src[7] >> (7 - i)) & 1) << 1);
+	}
+	for (i = 0; i < 8; i++) {
+		dest[16 + i] = (((src[0] >> (7 - i)) & 1) << 0) |
+			       (((src[6] >> (7 - i)) & 1) << 1);
+	}
+
+	/* Second 24 bytes: even channels (ALSA Ch 2 & 4) */
+	for (i = 0; i < 8; i++) {
+		dest[24 + i] = (((src[5] >> (7 - i)) & 1) << 0) |
+			       (((src[11] >> (7 - i)) & 1) << 1);
+	}
+	for (i = 0; i < 8; i++) {
+		dest[24 + 8 + i] = (((src[4] >> (7 - i)) & 1) << 0) |
+				   (((src[10] >> (7 - i)) & 1) << 1);
+	}
+	for (i = 0; i < 8; i++) {
+		dest[24 + 16 + i] = (((src[3] >> (7 - i)) & 1) << 0) |
+				    (((src[9] >> (7 - i)) & 1) << 1);
+	}
+}
+
+/**
+ * ploytec_decode_s24_3le - Decode 64-byte Ploytec frame to 6-channel S24_3LE
+ * @dest: 18-byte destination buffer (6 channels * 3 bytes)
+ * @src: 64-byte source buffer
+ */
+void ploytec_decode_s24_3le(u8 *dest, const u8 *src)
+{
+	int i;
+
+	/* Channel 1: odd channel 1 (bit 0 of bytes 0x00-0x17) */
+	dest[0x00] = 0;
+	dest[0x01] = 0;
+	dest[0x02] = 0;
+	for (i = 0; i < 8; i++) {
+		dest[0x00] |= ((src[0x10 + i] & 0x01) << (7 - i));
+		dest[0x01] |= ((src[0x08 + i] & 0x01) << (7 - i));
+		dest[0x02] |= ((src[0x00 + i] & 0x01) << (7 - i));
+	}
+
+	/* Channel 2: even channel 2 (bit 0 of bytes 0x20-0x37) */
+	dest[0x03] = 0;
+	dest[0x04] = 0;
+	dest[0x05] = 0;
+	for (i = 0; i < 8; i++) {
+		dest[0x03] |= ((src[0x30 + i] & 0x01) << (7 - i));
+		dest[0x04] |= ((src[0x28 + i] & 0x01) << (7 - i));
+		dest[0x05] |= ((src[0x20 + i] & 0x01) << (7 - i));
+	}
+
+	/* Channel 3: odd channel 3 (bit 1 of bytes 0x00-0x17) */
+	dest[0x06] = 0;
+	dest[0x07] = 0;
+	dest[0x08] = 0;
+	for (i = 0; i < 8; i++) {
+		dest[0x06] |= (((src[0x10 + i] & 0x02) >> 1) << (7 - i));
+		dest[0x07] |= (((src[0x08 + i] & 0x02) >> 1) << (7 - i));
+		dest[0x08] |= (((src[0x00 + i] & 0x02) >> 1) << (7 - i));
+	}
+
+	/* Channel 4: even channel 4 (bit 1 of bytes 0x20-0x37) */
+	dest[0x09] = 0;
+	dest[0x0A] = 0;
+	dest[0x0B] = 0;
+	for (i = 0; i < 8; i++) {
+		dest[0x09] |= (((src[0x30 + i] & 0x02) >> 1) << (7 - i));
+		dest[0x0A] |= (((src[0x28 + i] & 0x02) >> 1) << (7 - i));
+		dest[0x0B] |= (((src[0x20 + i] & 0x02) >> 1) << (7 - i));
+	}
+
+	/* Channel 5: odd channel 5 (bit 2 of bytes 0x00-0x17) */
+	dest[0x0C] = 0;
+	dest[0x0D] = 0;
+	dest[0x0E] = 0;
+	for (i = 0; i < 8; i++) {
+		dest[0x0C] |= (((src[0x10 + i] & 0x04) >> 2) << (7 - i));
+		dest[0x0D] |= (((src[0x08 + i] & 0x04) >> 2) << (7 - i));
+		dest[0x0E] |= (((src[0x00 + i] & 0x04) >> 2) << (7 - i));
+	}
+
+	/* Channel 6: even channel 6 (bit 2 of bytes 0x20-0x37) */
+	dest[0x0F] = 0;
+	dest[0x10] = 0;
+	dest[0x11] = 0;
+	for (i = 0; i < 8; i++) {
+		dest[0x0F] |= (((src[0x30 + i] & 0x04) >> 2) << (7 - i));
+		dest[0x10] |= (((src[0x28 + i] & 0x04) >> 2) << (7 - i));
+		dest[0x11] |= (((src[0x20 + i] & 0x04) >> 2) << (7 - i));
+	}
+}
diff --git a/sound/usb/jockey3/ploytec_codec.h b/sound/usb/jockey3/ploytec_codec.h
new file mode 100644
index 000000000000..e756f54d8ca8
--- /dev/null
+++ b/sound/usb/jockey3/ploytec_codec.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   ALSA driver for Reloop Jockey 3 devices
+ *
+ *   Copyright (c) 2026 by Frank van de Pol <fvdpol@gmail.com>
+ */
+
+#ifndef PLOYTEC_CODEC_H
+#define PLOYTEC_CODEC_H
+
+#include <linux/types.h>
+
+/* Ploytec Protocol Constants */
+#define PLOYTEC_PKT_SIZE 512
+#define PLOYTEC_MIDI_IDLE_BYTE 0xFD
+
+/* Playback (EP 0x05) */
+#define PLOYTEC_EP_PCM_OUT 0x05
+#define PLOYTEC_PLAYBACK_FRAMES 10
+#define PLOYTEC_PLAYBACK_FRAME_SIZE 48
+
+/* Capture (EP 0x86) */
+#define PLOYTEC_EP_PCM_IN 0x86
+#define PLOYTEC_CAPTURE_FRAMES 8
+#define PLOYTEC_CAPTURE_FRAME_SIZE 64
+
+/* MIDI (EP 0x83) */
+#define PLOYTEC_EP_MIDI_IN 0x83
+
+/* Bit-shuffling codec for S24_3LE (3 bytes per sample) */
+void ploytec_encode_s24_3le(u8 *dest, const u8 *src);
+void ploytec_decode_s24_3le(u8 *dest, const u8 *src);
+
+#endif /* PLOYTEC_CODEC_H */
-- 
2.47.3

