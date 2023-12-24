Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063D9C46CD3
	for <alsa-devel@archiver.kernel.org>; Sun, 24 Dec 2023 19:28:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CFA5E12;
	Sun, 24 Dec 2023 20:28:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CFA5E12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1703446103;
	bh=/d4AhZ/iUVmFq0GpE6gkRUp4tNlnAbD3N+IEqfUfEXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Xwb4siYj24EwN9P3g+q0rCxKmKW7Hs5zVfhtuDYWF6wM+6zR8styTfiGrHQybwkKQ
	 IjqsePEGPs+m9Q++r/iv4lecY5j+lQihEk9/UhJOsyqQTHCskiOCY3k3FBiMX+FDFc
	 1rXOrzJDsiuty8SPWCh8YlIDlKkzmf3B2dKcUKbk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D4B8F80564; Sun, 24 Dec 2023 20:27:03 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B686F805AF;
	Sun, 24 Dec 2023 20:27:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F943F8015B; Sun, 24 Dec 2023 20:26:57 +0100 (CET)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 91EA7F80557
	for <alsa-devel@alsa-project.org>; Sun, 24 Dec 2023 20:26:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91EA7F80557
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=b4.vu header.i=@b4.vu header.a=rsa-sha256 header.s=m1
 header.b=QGuYcBak
Received: by m.b4.vu (Postfix, from userid 1000)
	id 9C6CA604B9CB; Mon, 25 Dec 2023 05:56:43 +1030 (ACDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.b4.vu 9C6CA604B9CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b4.vu; s=m1;
	t=1703446003; bh=6FOJ6A/6ciN/FIS2rCUkPKt6Pf1DgEf/C3ElQgZaInw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QGuYcBakB0x9RmAenovr6UYEM5f+96MDFbZQ09zmRdpXvq602rG3W65PMf6EebtjX
	 alkinMviWLlcWQYtKM5SEf3te/Uefnjfoqbp3//EUvyiunj5rKVQOlUoRpAdG7XSaB
	 ImG2s1XReZYLSjNntwyU7piPNKZQy1Wz0G8Gw0QB5ppOdA5DYkJzVozROYsEHPX9z/
	 an0gHfcT0UVuINjmU6vZh/AWWCOaVzLflADtU+s8hxb/ZdsHQSkDjMxgVJKGcIf6Ej
	 Q07EFLjWzmeOzp1FgtgLaI1YUodw5W59uss3rbDI8sIU9JroqSo12Xv0/AImOxwvOW
	 NBu61zyVXf/ZQ==
Date: Mon, 25 Dec 2023 05:56:43 +1030
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 09/23] ALSA: scarlett2: Refactor scarlett2_usb_set_config()
Message-ID: <257eca0b07708339133f916930e388057d116eb8.1703444932.git.g@b4.vu>
References: <cover.1703444932.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1703444932.git.g@b4.vu>
Message-ID-Hash: JQ47QG2LPE4AABOACRDCKUKWUKL2FBWC
X-Message-ID-Hash: JQ47QG2LPE4AABOACRDCKUKWUKL2FBWC
X-MailFrom: g@b4.vu
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JQ47QG2LPE4AABOACRDCKUKWUKL2FBWC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Pull out common code from scarlett2_usb_set_config() and create
scarlett2_usb_set_data() and scarlett2_usb_activate_config().

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett2.c | 57 ++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 4849dfeea429..bbc60b94b7bc 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -1583,20 +1583,52 @@ static void scarlett2_config_save_work(struct work_struct *work)
 	scarlett2_config_save(private->mixer);
 }
 
-/* Send a USB message to set a SCARLETT2_CONFIG_* parameter */
-static int scarlett2_usb_set_config(
+/* Send a SCARLETT2_USB_SET_DATA command.
+ * offset: location in the device's data space
+ * size: size in bytes of the value (1, 2, 4)
+ */
+static int scarlett2_usb_set_data(
 	struct usb_mixer_interface *mixer,
-	int config_item_num, int index, int value)
+	int offset, int size, int value)
 {
 	struct scarlett2_data *private = mixer->private_data;
-	const struct scarlett2_config *config_item =
-		&private->config_set->items[config_item_num];
 	struct {
 		__le32 offset;
-		__le32 bytes;
+		__le32 size;
 		__le32 value;
 	} __packed req;
-	__le32 req2;
+
+	req.offset = cpu_to_le32(offset);
+	req.size = cpu_to_le32(size);
+	req.value = cpu_to_le32(value);
+	return scarlett2_usb(private->mixer, SCARLETT2_USB_SET_DATA,
+			     &req, sizeof(u32) * 2 + size, NULL, 0);
+}
+
+/* Send a SCARLETT2_USB_DATA_CMD command.
+ * Configuration changes require activation with this after they have
+ * been uploaded by a previous SCARLETT2_USB_SET_DATA.
+ * The value for activate needed is determined by the configuration
+ * item.
+ */
+static int scarlett2_usb_activate_config(
+	struct usb_mixer_interface *mixer, int activate)
+{
+	__le32 req;
+
+	req = cpu_to_le32(activate);
+	return scarlett2_usb(mixer, SCARLETT2_USB_DATA_CMD,
+			     &req, sizeof(req), NULL, 0);
+}
+
+/* Send USB messages to set a SCARLETT2_CONFIG_* parameter */
+static int scarlett2_usb_set_config(
+	struct usb_mixer_interface *mixer,
+	int config_item_num, int index, int value)
+{
+	struct scarlett2_data *private = mixer->private_data;
+	const struct scarlett2_config *config_item =
+		&private->config_set->items[config_item_num];
 	int offset, size;
 	int err;
 
@@ -1638,19 +1670,12 @@ static int scarlett2_usb_set_config(
 	}
 
 	/* Send the configuration parameter data */
-	req.offset = cpu_to_le32(offset);
-	req.bytes = cpu_to_le32(size);
-	req.value = cpu_to_le32(value);
-	err = scarlett2_usb(mixer, SCARLETT2_USB_SET_DATA,
-			    &req, sizeof(u32) * 2 + size,
-			    NULL, 0);
+	err = scarlett2_usb_set_data(mixer, offset, size, value);
 	if (err < 0)
 		return err;
 
 	/* Activate the change */
-	req2 = cpu_to_le32(config_item->activate);
-	err = scarlett2_usb(mixer, SCARLETT2_USB_DATA_CMD,
-			    &req2, sizeof(req2), NULL, 0);
+	err = scarlett2_usb_activate_config(mixer, config_item->activate);
 	if (err < 0)
 		return err;
 
-- 
2.43.0

