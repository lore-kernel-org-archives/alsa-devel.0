Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315F2C48BE5
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:14:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E806115B
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E806115B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43F3316CC;
	Mon, 21 Jun 2021 20:13:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43F3316CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624299251;
	bh=bo8UWv1o7PXNmZigW5otDOyN8WVqD1Gwy3yAQcAcTL8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ur6tmQWThtUDlOelgKIhOU0VP0q7vR3ScnXDoYqQMFsYn1m+RTqNjRBhovK9q7acg
	 nXRrBalE2hbXlD3/G4FuiSghnaTRGSfyAy8m/IG6V+72fJmZzp4UhXDC58wubd/0/f
	 LEClYx9ecNaO1H1FuTdNFcLj6FtR1R0aNaTonGa4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0F5CF80524;
	Mon, 21 Jun 2021 20:09:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D20D7F80519; Mon, 21 Jun 2021 20:09:40 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 252A1F80510
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 20:09:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 252A1F80510
Received: by m.b4.vu (Postfix, from userid 1000)
 id AB4EC61E287C; Tue, 22 Jun 2021 03:39:35 +0930 (ACST)
Date: Tue, 22 Jun 2021 03:39:35 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/31] ALSA: usb-audio: scarlett2: Remove repeated device
 info comments
Message-ID: <3486e4d38973333d4ec38f32578c16a9f97bf6c8.1624294591.git.g@b4.vu>
References: <cover.1624294591.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1624294591.git.g@b4.vu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>,
 Vladimir Sadovnikov <sadko4u@gmail.com>
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

Document the fields of struct scarlett2_device_info in the definition
of the struct, not in each instantiation.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 5cc4296944f5..ded99baa92de 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -218,10 +218,24 @@ struct scarlett2_ports {
 
 struct scarlett2_device_info {
 	u32 usb_id; /* USB device identifier */
-	u8 line_out_hw_vol; /* line out hw volume is sw controlled */
-	u8 level_input_count; /* inputs with level selectable */
-	u8 pad_input_count; /* inputs with pad selectable */
+
+	/* line out hw volume is sw controlled */
+	u8 line_out_hw_vol;
+
+	/* the number of analogue inputs with a software switchable
+	 * level control that can be set to line or instrument
+	 */
+	u8 level_input_count;
+
+	/* the number of analogue inputs with a software switchable
+	 * 10dB pad control
+	 */
+	u8 pad_input_count;
+
+	/* additional description for the line out volume controls */
 	const char * const line_out_descrs[SCARLETT2_ANALOGUE_MAX];
+
+	/* port count and type data */
 	struct scarlett2_ports ports[SCARLETT2_PORT_TYPE_COUNT];
 };
 
@@ -260,12 +274,7 @@ struct scarlett2_data {
 static const struct scarlett2_device_info s6i6_gen2_info = {
 	.usb_id = USB_ID(0x1235, 0x8203),
 
-	/* The first two analogue inputs can be switched between line
-	 * and instrument levels.
-	 */
 	.level_input_count = 2,
-
-	/* The first two analogue inputs have an optional pad. */
 	.pad_input_count = 2,
 
 	.line_out_descrs = {
@@ -315,12 +324,7 @@ static const struct scarlett2_device_info s6i6_gen2_info = {
 static const struct scarlett2_device_info s18i8_gen2_info = {
 	.usb_id = USB_ID(0x1235, 0x8204),
 
-	/* The first two analogue inputs can be switched between line
-	 * and instrument levels.
-	 */
 	.level_input_count = 2,
-
-	/* The first four analogue inputs have an optional pad. */
 	.pad_input_count = 4,
 
 	.line_out_descrs = {
@@ -378,9 +382,6 @@ static const struct scarlett2_device_info s18i8_gen2_info = {
 static const struct scarlett2_device_info s18i20_gen2_info = {
 	.usb_id = USB_ID(0x1235, 0x8201),
 
-	/* The analogue line outputs on the 18i20 can be switched
-	 * between software and hardware volume control
-	 */
 	.line_out_hw_vol = 1,
 
 	.line_out_descrs = {
-- 
2.31.1

