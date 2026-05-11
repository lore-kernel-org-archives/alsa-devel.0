Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4CACD37BE
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2026 21:26:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17E5C601CA;
	Mon, 11 May 2026 23:26:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17E5C601CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778534786;
	bh=+4XU+4vbgbs4z1rWJ942uCcsb/xJBS52FXcbV22pp9o=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ecNtZSks+zO7qCdvlOQP+KsRJeFwvBYiRnVq0SqFq5XYhU4O3zocwORPSpypfwxBN
	 YIwKyADEDptkVqaykM28phpN9RVBoDbVxImxj5B+KivgIt85Tre30TdVM/jND+dxWu
	 r63hATYBNuRngS5MZJ9gGQh1lVpHREIrWbxCA/6c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 779F0F805E1; Mon, 11 May 2026 23:25:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3EBB0F805E9;
	Mon, 11 May 2026 23:25:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D9306F80535; Mon, 11 May 2026 23:25:46 +0200 (CEST)
Received: from cheetah.ash.relay.mailchannels.net
 (cheetah.ash.relay.mailchannels.net [23.83.222.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8204FF80171
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2026 23:25:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8204FF80171
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=mungewell.org header.i=@mungewell.org
 header.a=rsa-sha256 header.s=default header.b=oZA+xF+M
X-Sender-Id: idigitalinternetinc|x-authuser|simon@mungewell.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 007EF402311
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2026 21:25:17 +0000 (UTC)
Received: from barmail5.idig.net (trex-green-8.trex.outbound.svc.cluster.local
 [100.98.1.152])
	(Authenticated sender: idigitalinternetinc)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6A25A4016BC
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2026 21:25:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1778534716;
	b=ZOQ8Yc1r7wknSZNaoQYUBuldhFC3kiKXHGcZTyA6roL7pBIc7S3UEHcfz/Oi9UhpFA+CP2
	oWF0XgOrbep/IuehnuWzoHNwlZbYpZtVXDRH+7eY1yPOfs9PmmHwaBCU0g75t9lIwNnKZU
	dLsL3Yb+a0uEcbDGsM9B/3roC8w+rzpvXAGWCKvcWqVaFx28BczBr7sfgePXnK0Y/dXI+O
	cOakOACKyu+y1NQnFhLq+x/lt7E4rcDsAvU0yCpS/jwFh+JMcYsIoEMrBbu3tNtVk4RAr6
	NESGyCqynGdHKDrifCFUqeP9HFJq2GgLgMlEhpQPX+rH/qSa6MSAuY75sO8bMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1778534716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=gO/l+PrpBQIE81oCGZS84ryjmN5q7PHpeH4KZzgS+sk=;
	b=accujj1CLoJOllbFtTzQeEfoxDlmlXrKACuXE3BUtzBFw69lTac4xRSunAiHZCUqmJVgIU
	nLXIClFLDqv8pOi0KOG7ZK5TvmbwQQ6k9IBnCWt0Bq7Dn/qG3xPPCTIsVRI99/HgbNiTUq
	Bc1TmhyPuMOtuo8L7R7toraB/Oo7WaVXgkZS5n4lpMk96WaXEFZsu1NX9TpRU0QW1Q30Aj
	AW56bfqCwstJn2oADbP989lIpi5Yw6hicUKigRJ5bwhEXiQoB0yydisUm2FQE7Je6ZJCwQ
	mBDPFy1A+oeS3ioFGMLonNW3aMoAfYu7kloLY07Is84q4rafh8mnCemikwUPjQ==
ARC-Authentication-Results: i=1;
	rspamd-5c5444c55f-8gxc9;
	auth=pass smtp.auth=idigitalinternetinc smtp.mailfrom=simon@mungewell.org
X-Sender-Id: idigitalinternetinc|x-authuser|simon@mungewell.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: idigitalinternetinc|x-authuser|simon@mungewell.org
X-MailChannels-Auth-Id: idigitalinternetinc
X-Soft-Exultant: 23bdeccd0a67f07e_1778534716660_1247719021
X-MC-Loop-Signature: 1778534716660:2335567305
X-MC-Ingress-Time: 1778534716660
Received: from barmail5.idig.net (barmail5.idig.net [104.36.151.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.1.152 (trex/7.1.5);
	Mon, 11 May 2026 21:25:16 +0000
Received: from cwh28.canadianwebhosting.com (cwh28.canadianwebhosting.com
 [66.85.29.119]) by barmail5.idig.net with ESMTP id rb5PYwDNo7QxBGqT
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Mon, 11 May 2026 14:25:15 -0700 (PDT)
X-Barracuda-Envelope-From: simon@mungewell.org
X-Barracuda-Effective-Source-IP: cwh28.canadianwebhosting.com[66.85.29.119]
X-Barracuda-Apparent-Source-IP: 66.85.29.119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mungewell.org; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gO/l+PrpBQIE81oCGZS84ryjmN5q7PHpeH4KZzgS+sk=; b=oZA+xF+M7UVf5OYZGF6JE/uZT8
	ez/JNzOZBx00/oiYkoPf4igsODVmKUs+r8Otu3/JIekx3x6PRscpb26JtAyABgRtPjHU0mVrtaRGK
	t7W1FprQI501PAjIatRMr59b5zszwS8z23T0IUUhl5Zv6H693EhDz3aukTju527N5tSeYlQHul1Hy
	g/yFDF/2RA1eSaQ4D11idVJpNNMrp5TrZ/byDvQ3Tt+iXhqwyZXflfc9f6gOsJQyefIQA+fIN7NeC
	VqWSVwsI/znkaC1rpFOY4u4zD4PxO3zAp+dzDgcE494Ca144aILMJicEqWIOAMwTUiMpqImwt2TnF
	MzbFhhWQ==;
Received: from [129.222.141.190] (port=59574 helo=localhost.localdomain)
	by cwh28.canadianwebhosting.com with esmtpsa  (TLS1.3) tls
 TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <simon@mungewell.org>)
	id 1wMY7n-0000000EsHX-10ZB;
	Mon, 11 May 2026 17:25:14 -0400
From: Simon Wood <simon@mungewell.org>
To: perex@perex.cz,
	tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Simon Wood <simon@mungewell.org>
Subject: [PATCH] ALSA: M-Audio C600 disable Output Gain Knob
Date: Mon, 11 May 2026 15:24:58 -0600
X-ASG-Orig-Subj: [PATCH] ALSA: M-Audio C600 disable Output Gain Knob
Message-ID: <20260511212458.44142-1-simon@mungewell.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: simon@mungewell.org
X-Barracuda-Connect: cwh28.canadianwebhosting.com[66.85.29.119]
X-Barracuda-Start-Time: 1778534715
X-Barracuda-Encrypted: TLS_AES_256_GCM_SHA384
X-Barracuda-URL: https://104.36.151.219:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at idig.net
X-Barracuda-Scan-Msg-Size: 3400
X-Barracuda-BRTS-Status: 0
X-ASG-Debug-ID: 1778534715-13d5ac29ecd05b0001-UKjUFf
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No,
 SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=8.0
 KILL_LEVEL=4.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ----------------------
 --------------------------------------------------	
Message-ID-Hash: GOX3X4L5IJMN5QMEFDET7A43QYAO56UT
X-Message-ID-Hash: GOX3X4L5IJMN5QMEFDET7A43QYAO56UT
X-MailFrom: simon@mungewell.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GOX3X4L5IJMN5QMEFDET7A43QYAO56UT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The C400/C600 interfaces have a large output gain knob which attenuates
the outputs as stereo pairs (1/2, 3/4 and 5/6). The Windows driver/app
provides a control to disable this knob/behaviour on any/all outputs,
forcing maximum gain on each.

The 'disable behaviour' is desirable if any outputs are being used for
aux/effects sends, or if interface is being used as a live/matrix mixer.

This patch adds a control to select which output pairs are affected by
the Output Gain Knob. Default behaviour is to select all outputs.

Tested on the C600, likely also works for the C400.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 sound/usb/mixer_quirks.c | 46 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 11e205da7964..16d8eb111d01 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1282,7 +1282,7 @@ static int snd_ftu_eff_switch_init(struct usb_mixer_interface *mixer,
 
 	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC_GET_CUR,
 			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
-			      pval & 0xff00,
+			      (pval & 0xff00) | ((pval & 0xff0000) >> 16),
 			      snd_usb_ctrl_intf(mixer->hostif) | ((pval & 0xff) << 8),
 			      value, 2);
 	if (err < 0)
@@ -1315,7 +1315,7 @@ static int snd_ftu_eff_switch_update(struct usb_mixer_elem_list *list)
 			       usb_sndctrlpipe(chip->dev, 0),
 			       UAC_SET_CUR,
 			       USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
-			       pval & 0xff00,
+			       (pval & 0xff00) | ((pval & 0xff0000) >> 16),
 			       snd_usb_ctrl_intf(list->mixer->hostif) | ((pval & 0xff) << 8),
 			       value, 2);
 }
@@ -1728,6 +1728,44 @@ static int snd_c400_create_effect_ret_vol_ctls(struct usb_mixer_interface *mixer
 	return 0;
 }
 
+/* output gain knob selectively adjusts outputs as stereo pairs */
+/* reuses functions from FTU effect switch */
+static int snd_c400_knob_switch_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const texts[8] = {
+		"None", "1/2", "3/4", "1/2 3/4",
+		"5/6", "1/2 5/6", "3/4 5/6", "1/2 3/4 5/6"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(texts), texts);
+}
+
+static int snd_c400_create_knob_switch(struct usb_mixer_interface *mixer,
+	int validx, int bUnitID)
+{
+	static struct snd_kcontrol_new template = {
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output Gain Knob",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_c400_knob_switch_info,
+		.get = snd_ftu_eff_switch_get,
+		.put = snd_ftu_eff_switch_put
+	};
+	struct usb_mixer_elem_list *list;
+	int err;
+
+	err = add_single_ctl_with_resume(mixer, bUnitID,
+					 snd_ftu_eff_switch_update,
+					 &template, &list);
+	if (err < 0)
+		return err;
+	list->kctl->private_value = (validx << 8) | bUnitID;
+	snd_ftu_eff_switch_init(mixer, list->kctl);
+	return 0;
+}
+
 static int snd_c400_create_mixer(struct usb_mixer_interface *mixer)
 {
 	int err;
@@ -1760,6 +1798,10 @@ static int snd_c400_create_mixer(struct usb_mixer_interface *mixer)
 	if (err < 0)
 		return err;
 
+	err = snd_c400_create_knob_switch(mixer, 0x0900, 0x20);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
 
-- 
2.43.0

