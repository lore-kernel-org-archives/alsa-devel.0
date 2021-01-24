Return-Path: <SRS0=viVi=G3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1E3C433DB
	for <alsa-devel@archiver.kernel.org>; Sun, 24 Jan 2021 18:43:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C8922252
	for <alsa-devel@archiver.kernel.org>; Sun, 24 Jan 2021 18:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C8922252
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=base.nu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B0861678;
	Sun, 24 Jan 2021 19:42:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B0861678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611513797;
	bh=HrFMC5zGuY9W24pZ8WDJ0EkARdQBDBGe7wX+cpjaqag=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I7supq2apv7GiNvJsRmPA27PAD4iNbhyS2IV8Z6dZhv9hoWLw8YAWxhZoJFvCghCh
	 01xonoPwnidhbu+xtySfiWdiHl3ZmQvnsjAIma7h5pX5FMIcYESd7ks0YxRxtDHguc
	 8oCWZWKAp9lJ5TowvuBHc80TJaGxHgc/ksOaHNr8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2573F80114;
	Sun, 24 Jan 2021 19:42:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C94D5F8015B; Sun, 24 Jan 2021 19:42:23 +0100 (CET)
Received: from hellmouth.base.nu (hellmouth.base.nu [192.248.168.186])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64D56F80114
 for <alsa-devel@alsa-project.org>; Sun, 24 Jan 2021 19:42:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64D56F80114
Received: from baphomet.hell (<unknown> [192.168.179.1])
 by hellmouth.base.nu (OpenSMTPD) with ESMTP id 488fcaa4;
 Sun, 24 Jan 2021 18:42:14 +0000 (UTC)
Received: from baphomet.hell (localhost.hell [127.0.0.1])
 by baphomet.hell (OpenSMTPD) with ESMTP id b0eac8eb;
 Sun, 24 Jan 2021 18:42:13 +0000 (GMT)
Received: from base.nu ([192.168.178.2]) by baphomet.hell with ESMTPSA
 id UZy1EIW/DWCJfgEAnQSWfg
 (envelope-from <livvy@base.nu>); Sun, 24 Jan 2021 18:42:13 +0000
Date: Sun, 24 Jan 2021 18:42:09 +0000
From: Olivia Mackintosh <livvy@base.nu>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2] ALSA: usb-audio: Re-add sample rate quirk for Pioneer
 DJM-750
Message-ID: <20210124184209.x2bf42wtild4v6fb@base.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: dmitry@d-systems.ee, franta-linux@frantovo.cz
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

Re-add the sample-rate quirk originally implemented by Dmitry
Panchenko for the DJM-900NXS2 but for the DJM-750.  This commit only
adds it again for the DJM-750 since I can only verify that it is
absolutely required for this device. Other models may need this patch
but I'm hesitant to add them as I cannot test.

The 'wIndex' is passed literally in the function call as we cannot
derive this from 'fmt->sync_ep' due to it not being set.  We can change
this if and when we revisit implicit FB.

Signed-off-by: Olivia Mackintosh <livvy@base.nu>
---
 sound/usb/quirks.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index e196e364cef1..b49a66f863f3 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1470,6 +1470,23 @@ static void set_format_emu_quirk(struct snd_usb_substream *subs,
 	subs->pkt_offset_adj = (emu_samplerate_id >= EMU_QUIRK_SR_176400HZ) ? 4 : 0;
 }
 
+static int pioneer_djm_set_format_quirk(struct snd_usb_substream *subs,
+					u16 windex)
+{
+	unsigned int cur_rate = subs->data_endpoint->cur_rate;
+	u8 sr[3];
+	// Convert to little endian
+	sr[0] = cur_rate&0xff;
+	sr[1] = (cur_rate>>8)&0xff;
+	sr[2] = (cur_rate>>16)&0xff;
+	usb_set_interface(subs->dev, 0, 1);
+	// we should derive windex from fmt-sync_ep but it's not set
+	snd_usb_ctl_msg(subs->stream->chip->dev,
+		usb_rcvctrlpipe(subs->stream->chip->dev, 0),
+		0x01, 0x22, 0x0100, windex, &sr, 0x0003);
+	return 0;
+}
+
 void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 			      const struct audioformat *fmt)
 {
@@ -1483,6 +1500,9 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 	case USB_ID(0x534d, 0x2109): /* MacroSilicon MS2109 */
 		subs->stream_offset_adj = 2;
 		break;
+	case USB_ID(0x08e4, 0x017f): /* Pioneer DJM-750 */
+		pioneer_djm_set_format_quirk(subs, 0x0086);
+		break;
 	}
 }
 
-- 
2.30.0

