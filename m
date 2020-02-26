Return-Path: <SRS0=ZBV5=4O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE0FC4BA09
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 02:28:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9A624672
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 02:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LgiEv2Wz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="Fw5VqHZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9A624672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tsoy.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A82A166A;
	Wed, 26 Feb 2020 03:28:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A82A166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582684137;
	bh=H6r8OFNp0CPLxVIS5LiyToi8MgYV1QU6slA+yhGlgTQ=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LgiEv2WzNX74ECiEYE8SQeCUccA74t7DrABmsBuWSQRLHGEgXa04ro4tAQUuhHy/G
	 dWas0aqWlTn8gE5uGDaq8ltdfBLRuaJ5JeK+fStN50sw+jz8WYP3kVJ2ECne1QeH2U
	 WdfU89w/81l6k/Gsi2Wb8UiXPtqwLW9Cvs6fVLHM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A1FF4F8013E;
	Wed, 26 Feb 2020 03:28:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 77A7DF80142; Wed, 26 Feb 2020 03:28:00 +0100 (CET)
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E72EF80090
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 03:27:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E72EF80090
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me
 header.b="Fw5VqHZz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
 s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:Content-Type:
 References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4WzjcFOg+LPLGNtWEV05GEQf5za0E83jgvKB5Vxqj8Y=; b=Fw5VqHZzPXEdiMIFsNgHSs4cEM
 Eu+pmqIKTxD4LqsnSzR2mQOpZU6PdVYUqx/LKtq8JzMwdwphvXOJAkdDMsEXzDi/M+WwWXYrKxR2t
 WjpDGTNrcTUVi51yJpGR+iB5mg+LMMPUeNx0EiMwRhjzQxKz5fGFSfM9Ecr0tWRJEMLY=;
Received: from [2a00:1370:8125:a23e:55c9:2d3a:3db9:4bca] (helo=home)
 by puleglot.ru with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <puleglot@puleglot.ru>)
 id 1j6mQW-000C2x-2Z; Wed, 26 Feb 2020 05:27:56 +0300
Message-ID: <1834c6e91bb7bdc29e33abc0976a04eb3b7f85f0.camel@tsoy.me>
Subject: Re: [alsa-devel] motu microbook iic
From: Alexander Tsoy <alexander@tsoy.me>
To: thomas rost <thomasrost@gmail.com>, alsa-devel@alsa-project.org
Date: Wed, 26 Feb 2020 05:27:55 +0300
In-Reply-To: <CAJ_PRtDf4+-ce_D+=ec36Kv4=m_NT2L5shmownNBi_HgbR0aCg@mail.gmail.com>
References: <CAJ_PRtDf4+-ce_D+=ec36Kv4=m_NT2L5shmownNBi_HgbR0aCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

В Ср, 07/08/2019 в 19:30 +0200, thomas rost пишет:
> Hello,
> 
> can anybody help me get the 'class compliant' motu microbook iic to
> run?
> 
> this is my alsa-info.sh output:
> 
> http://alsa-project.org/db/?f=0fd9a8df7bae3400d83b6af8b75c45aa0760d84d
> 
> thanks in advance.
> 
> thomas

Hello, Thomas!

Could you test the patch below? It should apply cleanly on 5.4.22 and
newer.

There are still issues with usb descriptors and clock validity checks,
so the card is quite noisy in the kernel logs.


diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index bd258f1ec2dd..04ccc7d80671 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -358,9 +358,13 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 		ifnum = 1;
 		goto add_sync_ep_from_ifnum;
 	case USB_ID(0x07fd, 0x0004): /* MOTU MicroBook II */
-		ep = 0x84;
-		ifnum = 0;
-		goto add_sync_ep_from_ifnum;
+		if (altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC) {
+			ep = 0x84;
+			ifnum = 0;
+			goto add_sync_ep_from_ifnum;
+		}
+		/* else MicroBook IIc */
+		return 0;
 	case USB_ID(0x07fd, 0x0008): /* MOTU M Series */
 		ep = 0x81;
 		ifnum = 2;
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index d187aa6d50db..1c8719292eee 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3472,7 +3472,7 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 },
 /* MOTU Microbook II */
 {
-	USB_DEVICE(0x07fd, 0x0004),
+	USB_DEVICE_VENDOR_SPEC(0x07fd, 0x0004),
 	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "MOTU",
 		.product_name = "MicroBookII",
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 7f558f4b4520..369e5163e9c9 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1113,6 +1113,12 @@ static int snd_usb_motu_microbookii_boot_quirk(struct usb_device *dev)
 	return err;
 }
 
+static int snd_usb_motu_microbookiic_boot_quirk(struct usb_device *dev)
+{
+	msleep(3000);
+	return 0;
+}
+
 static int snd_usb_motu_m_series_boot_quirk(struct usb_device *dev)
 {
 	int ret;
@@ -1316,7 +1322,11 @@ int snd_usb_apply_boot_quirk(struct usb_device *dev,
 	case USB_ID(0x2466, 0x8010): /* Fractal Audio Axe-Fx 3 */
 		return snd_usb_axefx3_boot_quirk(dev);
 	case USB_ID(0x07fd, 0x0004): /* MOTU MicroBook II */
-		return snd_usb_motu_microbookii_boot_quirk(dev);
+		if (get_iface_desc(intf->altsetting)->bInterfaceClass ==
+		    USB_CLASS_VENDOR_SPEC &&
+		    get_iface_desc(intf->altsetting)->bInterfaceNumber < 3)
+			return snd_usb_motu_microbookii_boot_quirk(dev);
+		break;
 	}
 
 	return 0;
@@ -1328,6 +1338,11 @@ int snd_usb_apply_boot_quirk_once(struct usb_device *dev,
 				  unsigned int id)
 {
 	switch (id) {
+	case USB_ID(0x07fd, 0x0004): /* MOTU MicroBook IIc */
+		if (get_iface_desc(intf->altsetting)->bInterfaceClass ==
+		    USB_CLASS_AUDIO)
+			return snd_usb_motu_microbookiic_boot_quirk(dev);
+		break;
 	case USB_ID(0x07fd, 0x0008): /* MOTU M Series */
 		return snd_usb_motu_m_series_boot_quirk(dev);
 	}
@@ -1754,5 +1769,12 @@ void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
 		else
 			fp->ep_attr |= USB_ENDPOINT_SYNC_SYNC;
 		break;
+	case USB_ID(0x07fd, 0x0004):  /* MOTU MicroBook IIc */
+		/*
+		 * Due to an error in descriptors this card produces only
+		 * noise on sample rates other than 96KHz
+		 */
+		fp->attributes &= ~UAC_EP_CS_ATTR_FILL_MAX;
+		break;
 	}
 }

