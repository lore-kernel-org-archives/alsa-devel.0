Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6647FECAAD3
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Sep 2022 08:11:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EF4218FF;
	Thu, 15 Sep 2022 10:10:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EF4218FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663229461;
	bh=rMkbh9JYe3AiiaPztJLWHFdcYPKfJtVSSvI8FUUY0Pk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XsbcTxNjWYUaUs/3e5tafDLT/f58R8TOYokWFPYBV9T7latCZJ5Ts03XTtQmWSQ50
	 ZAW8Ih7q8VySA5kmpVfbCfQpNIeyn1LgqabGu8X78z6vRxB+Gy3b06ylVOHCJP1qy9
	 AazwH1lng56V3+7N51Ec1bFMskmSlOBStpofRaHo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B1D8F80482;
	Thu, 15 Sep 2022 10:09:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 775B8F80482; Thu, 15 Sep 2022 10:09:49 +0200 (CEST)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15E3AF8013D
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2022 10:09:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15E3AF8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev
 header.b="xbzjfqrw"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="BUcPEp7G"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 9E2F53200B6F;
 Thu, 15 Sep 2022 04:09:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Thu, 15 Sep 2022 04:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
 :cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1663229378; x=1663315778; bh=dM
 fmPBWYKlmBZ304Vkqkg+k2Mpdstu9DKucN48OgE4M=; b=xbzjfqrwUDX5GopTNT
 3X6goUOaQDVCQWGNHm2rw68w7zpIPtIaqdxMUFsgwks8JbjSRHusD0+rZ56gezhz
 nvypBNZbSxl60j0bq3vWA77NvYfTV9DIFJ19s4371vmqNWoV1PuY5iuBUTKRRYSa
 3xdjiK1ETELWx2elmhtpih+ZpxYsR995i8+yJPn1SGMNFjz5rs30DGNWSe4BqhZT
 47KsUe7kzj6cJ3WDUyfgVOYpn/HS3HcBBtUWmUkiY14hb8uHTF5z58cfJyGgiWbW
 l14oiyp66dCAg/kOWWPAMi42crXkxwZgBaZlN/Yn/fCiygOgaUXGKWs0Ko19L/pW
 gi9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1663229378; x=1663315778; bh=dMfmPBWYKlmBZ
 304Vkqkg+k2Mpdstu9DKucN48OgE4M=; b=BUcPEp7GmAktWHGaXPhWwlNgxBhlc
 dJyJENHScLvg1n+g3U3uJQxGoREjd/f6pXLg/nSQHQejkM4+3QuVA02bgDGcZaYC
 H41QCTp8eD1XBnWXBvEPD55746ZppJvndD2ofhLjE+nu1VuFtW5pGWT2Hq5VYnNv
 Yc+NpRitGHkJo2a80+w8UtIQkmWvlnb5o/423nbLVQGbg9xhHxZCj6p/BOGdEbpl
 PvWENOd01fv22cjtxkpaYy9NGhNYv+ZCItV5ZTDoHRJ2/8DeMgoGOdi5mSEZPp5v
 wyJZPc5D+lJVGanOR79MEbqq1RrR4jL1W6GcVsEXvGetdD/5oNjPKlllA==
X-ME-Sender: <xms:wd0iY0Do4eZO5phqhI97VKDa2Nr_U3vL0Q172200wGb6q-39g8LmUg>
 <xme:wd0iY2h_zyfZaa0PDkcOGDmt-gWctql2jmOrj4o0m9bmuDxbfUBw5YQj04logtjQI
 e5azJZ4mLoowONrFBg>
X-ME-Received: <xmr:wd0iY3kHEfuXZooq1aDBopa5Js21QVS3ZFi0nLzIy9F8rVT8nY6JBNZeBfpe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedukecutefuodetggdotefrodftvfcurf
 hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
 dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
 vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugffgle
 eltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:wd0iY6xQZkl50xYU2ivYym5S__Fd7PvgHLDMI0HhR8hXgeeshbZvJg>
 <xmx:wd0iY5Sl3u8YFPPEFUEq1Ew97xcLJLLcvaAoNS91prSoPim0TOifPA>
 <xmx:wd0iY1YU5qdw9-4jmWKlD242yZM6VWvGjwKmBN9URnHmDpm8muk6kQ>
 <xmx:wt0iY0dRucsATsSGZ_gdurvsxytUDP8UNqrpxhxYkD2IxBFa-Pdosw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Sep 2022 04:09:34 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: tiwai@suse.com
Subject: [PATCH v2 1/3] sound: realtek: Add pincfg for ASUS G513 HP jack
Date: Thu, 15 Sep 2022 20:09:19 +1200
Message-Id: <20220915080921.35563-2-luke@ljones.dev>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220915080921.35563-1-luke@ljones.dev>
References: <20220915080921.35563-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, "Luke D. Jones" <luke@ljones.dev>,
 linux-kernel@vger.kernel.org
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

Fixes up the pincfg for ASUS ROG Strix G513 headphone and mic combo jack

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fd630d62b5a0..1485dea712d8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7025,6 +7025,7 @@ enum {
 	ALC294_FIXUP_ASUS_GU502_HP,
 	ALC294_FIXUP_ASUS_GU502_PINS,
 	ALC294_FIXUP_ASUS_GU502_VERBS,
+	ALC294_FIXUP_ASUS_G513_PINS,
 	ALC285_FIXUP_HP_GPIO_LED,
 	ALC285_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_GPIO_LED,
@@ -8362,6 +8363,15 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC294_FIXUP_ASUS_GU502_HP] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc294_fixup_gu502_hp,
+	},
+	 [ALC294_FIXUP_ASUS_G513_PINS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+				{ 0x19, 0x03a11050 }, /* front HP mic */
+				{ 0x1a, 0x03a11c30 }, /* rear external mic */
+				{ 0x21, 0x03211420 }, /* front HP out */
+				{ }
+		},
 	},
 	[ALC294_FIXUP_ASUS_COEF_1B] = {
 		.type = HDA_FIXUP_VERBS,
@@ -9314,6 +9324,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
+	SND_PCI_QUIRK(0x1043, 0x1e5e, "ASUS ROG Strix G513", ALC294_FIXUP_ASUS_G513_PINS),
 	SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
-- 
2.37.3

