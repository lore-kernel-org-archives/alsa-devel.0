Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF94CC0015E
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jul 2023 06:28:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1480FEA1;
	Tue, 25 Jul 2023 08:27:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1480FEA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690266499;
	bh=x07CpIYR8zJ3TzYNj6T4P12xvqlLDUfEAYK1AHoEQX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hkQbPpDKnW6Tj3IQAgIKELw/m4CumD4E2IItqQogti5jgxXOXxiCkFLB3HYqK+8QZ
	 Oj3QBMY5ZpwoOb8gcC0RiSvBoqIn2eYmIzYtfVd/p2/g7a2TrF9TO5g3tGBB43GlG9
	 8oBExr4lJL3nMzdAAcev0Irc43reIIEw3PhrUgA0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C6F18F80551; Tue, 25 Jul 2023 08:26:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 86007F80551;
	Tue, 25 Jul 2023 08:26:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 968B7F80163; Tue, 25 Jul 2023 08:26:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2001:67c:2178:6::1d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7719EF802E8
	for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2023 08:22:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7719EF802E8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=2Ig4JsL/;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=xDjJ4JW0
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BECB81F8B4;
	Tue, 25 Jul 2023 06:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1690266132;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oArbKxaeZCPtqMVbiTY1Kkik4trkyVoAFJEqdy+srBU=;
	b=2Ig4JsL/QSHJg3WDWvvrzuyGDYCR18LMLIt57WwZyLoTCo1GgcY7Xzy7f2AyB986CNYRxs
	CHwg6Z+t2ZGgJIdZeq/g3bvdkaW48M8CxDDyrkjNL8x3yFTOzGriyPYhKSWri7jfdn7FzI
	98m6R867vuat2R/nZI11btxhP7/3dGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690266132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oArbKxaeZCPtqMVbiTY1Kkik4trkyVoAFJEqdy+srBU=;
	b=xDjJ4JW01JxO/FJbwOQOcph3kuzi6/7sya8pmT73vBkumw52evG5v2znOBlSqF7R9s38Z5
	h/NBePTu1WYBIaAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 990DF13342;
	Tue, 25 Jul 2023 06:22:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id CB5+JBRqv2S0dQAAMHmgww
	(envelope-from <tiwai@suse.de>); Tue, 25 Jul 2023 06:22:12 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] usb: gadget: midi2: Add "Operation Mode" control
Date: Tue, 25 Jul 2023 08:22:05 +0200
Message-Id: <20230725062206.9674-7-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230725062206.9674-1-tiwai@suse.de>
References: <20230725062206.9674-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: EJIM44YKEWJC5TA3KGMPJ36KW33VNR2O
X-Message-ID-Hash: EJIM44YKEWJC5TA3KGMPJ36KW33VNR2O
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EJIM44YKEWJC5TA3KGMPJ36KW33VNR2O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add a new ALSA control element to watch the current operation mode
(MIDI 1.0 or MIDI 2.0).  It's a read-only control that reflects the
current value of altsetting, and 0 means unused, 1 for MIDI 1.0
(altset 0) and 2 for MIDI 2.0 (altset 1).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/usb/gadget-testing.rst  | 11 +++++++++
 drivers/usb/gadget/function/f_midi2.c | 35 +++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index 0f3708ae5bc8..1fb181d61322 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -1106,3 +1106,14 @@ On the host::
 The access to MIDI 1.0 on altset 0 on the host is supported, and it's
 translated from/to UMP packets on the gadget. It's bound to only
 Function Block 0.
+
+The current operation mode can be observed in ALSA control element
+"Operation Mode" for SND_CTL_IFACE_RAWMIDI.  For example::
+
+  $ amixer -c1 contents
+  numid=1,iface=RAWMIDI,name='Operation Mode'
+    ; type=INTEGER,access=r--v----,values=1,min=0,max=2,step=0
+    : values=2
+
+where 0 = unused, 1 = MIDI 1.0 (altset 0), 2 = MIDI 2.0 (altset 1).
+The example above shows it's running in 2, i.e. MIDI 2.0.
diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index a368ac51d349..ec9ef15abfea 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 
 #include <sound/core.h>
+#include <sound/control.h>
 #include <sound/ump.h>
 #include <sound/ump_msg.h>
 #include <sound/ump_convert.h>
@@ -1450,6 +1451,36 @@ static const struct snd_ump_ops f_midi2_ump_ops = {
 	.drain = f_midi2_ump_drain,
 };
 
+/*
+ * "Operation Mode" control element
+ */
+static int f_midi2_operation_mode_info(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = MIDI_OP_MODE_UNSET;
+	uinfo->value.integer.max = MIDI_OP_MODE_MIDI2;
+	return 0;
+}
+
+static int f_midi2_operation_mode_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct f_midi2 *midi2 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = midi2->operation_mode;
+	return 0;
+}
+
+static const struct snd_kcontrol_new operation_mode_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_RAWMIDI,
+	.name = "Operation Mode",
+	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.info = f_midi2_operation_mode_info,
+	.get = f_midi2_operation_mode_get,
+};
+
 /*
  * ALSA UMP instance creation / deletion
  */
@@ -1547,6 +1578,10 @@ static int f_midi2_create_card(struct f_midi2 *midi2)
 		id++;
 	}
 
+	err = snd_ctl_add(card, snd_ctl_new1(&operation_mode_ctl, midi2));
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
-- 
2.35.3

