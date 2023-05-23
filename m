Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B06C7EE26
	for <alsa-devel@archiver.kernel.org>; Tue, 23 May 2023 15:15:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA63983B;
	Tue, 23 May 2023 17:14:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA63983B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684854903;
	bh=0j6HFxNsZpLS0q8NIkLckwtshJIE16XVruIPnFGFY1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qN4zPRzfo/olXLLfuJfJPbhdxzAYajdkvNqMqdbLFYqV+4Sv/k0/XR12SqGBojU/X
	 vsEPb9JiZlzh369tWtlUl0d8a4SL0gwO3gdtf7QwgRAWM32VU6r10XuBdP3A+nGr2L
	 YMkHfacA43PsPxhgjwnD7fKdUAXo1DkGa9BrCs0E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DCC44F805A1; Tue, 23 May 2023 17:12:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 67414F805A0;
	Tue, 23 May 2023 17:12:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1652F80568; Tue, 23 May 2023 17:12:48 +0200 (CEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::226])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B5CF4F80548
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2023 17:12:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5CF4F80548
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=DCytTTlw
Received: (Authenticated sender: herve.codina@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPA id BB54AC0013;
	Tue, 23 May 2023 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1684854764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5Rp2Pe2hP+HZpzHQ6QCIJu8OkM1HG2ZQQx1TOta918=;
	b=DCytTTlwfYZ07XCnOC1y/PBxT/gt5Bv3UFAB1EGhRvleTo7U3AOLO8sxWlvI8yCC0E5kJS
	hpdV6Nx4P+qyD22hEu+LTLixj4X2zB/efzVU0C2VRSSinU3m/rfAcPup0BHVQSk3uxYh2P
	mFRLWDfTLBEW1GBVHtMaEeP7q5QAmR7hEaY2V4cwIUPHj2Ynid7erDgBv2fbMX7Hl3C6RA
	Ptx7ur7w85pztC+90lDvuhCgjxyjfuv32j7XqgLXnRmgq+2aYluashCX0sIDzD+SyjQeuo
	GXwV0M4nRAM/LZamGyqdUMVZ4aKLA/gi73pV79ZxUbqjigH9hGmJKAy5M8Yvfw==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 4/9] iio: consumer.h: Fix raw values documentation notes
Date: Tue, 23 May 2023 17:12:18 +0200
Message-Id: <20230523151223.109551-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523151223.109551-1-herve.codina@bootlin.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QL5JNAMC4GVVBYYGYPC4YA43IMH4MHE3
X-Message-ID-Hash: QL5JNAMC4GVVBYYGYPC4YA43IMH4MHE3
X-MailFrom: herve.codina@bootlin.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QL5JNAMC4GVVBYYGYPC4YA43IMH4MHE3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The raw values notes mention 'ADC counts' and are not fully accurate.

Reword the notes in order to remove the 'ADC counts' and describe the
conversion needed between a raw value and a value in the standard units.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/iio/consumer.h | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 6802596b017c..f536820b9cf2 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -201,8 +201,9 @@ struct iio_dev
  * @chan:		The channel being queried.
  * @val:		Value read back.
  *
- * Note raw reads from iio channels are in adc counts and hence
- * scale will need to be applied if standard units required.
+ * Note, if standard units are required, raw reads from iio channels
+ * need the offset (default 0) and scale (default 1) to be applied
+ * as (raw + offset) * scale.
  */
 int iio_read_channel_raw(struct iio_channel *chan,
 			 int *val);
@@ -212,8 +213,9 @@ int iio_read_channel_raw(struct iio_channel *chan,
  * @chan:		The channel being queried.
  * @val:		Value read back.
  *
- * Note raw reads from iio channels are in adc counts and hence
- * scale will need to be applied if standard units required.
+ * Note, if standard units are required, raw reads from iio channels
+ * need the offset (default 0) and scale (default 1) to be applied
+ * as (raw + offset) * scale.
  *
  * In opposit to the normal iio_read_channel_raw this function
  * returns the average of multiple reads.
@@ -281,8 +283,9 @@ int iio_read_channel_attribute(struct iio_channel *chan, int *val,
  * @chan:		The channel being queried.
  * @val:		Value being written.
  *
- * Note raw writes to iio channels are in dac counts and hence
- * scale will need to be applied if standard units required.
+ * Note that for raw writes to iio channels, if the value provided is
+ * in standard units, the affect of the scale and offset must be removed
+ * as (value / scale) - offset.
  */
 int iio_write_channel_raw(struct iio_channel *chan, int val);
 
@@ -292,8 +295,9 @@ int iio_write_channel_raw(struct iio_channel *chan, int val);
  * @chan:		The channel being queried.
  * @val:		Value read back.
  *
- * Note raw reads from iio channels are in adc counts and hence
- * scale will need to be applied if standard units are required.
+ * Note, if standard units are required, raw reads from iio channels
+ * need the offset (default 0) and scale (default 1) to be applied
+ * as (raw + offset) * scale.
  */
 int iio_read_max_channel_raw(struct iio_channel *chan, int *val);
 
@@ -308,8 +312,9 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val);
  * For ranges, three vals are always returned; min, step and max.
  * For lists, all the possible values are enumerated.
  *
- * Note raw available values from iio channels are in adc counts and
- * hence scale will need to be applied if standard units are required.
+ * Note, if standard units are required, raw available values from iio
+ * channels need the offset (default 0) and scale (default 1) to be applied
+ * as (raw + offset) * scale.
  */
 int iio_read_avail_channel_raw(struct iio_channel *chan,
 			       const int **vals, int *length);
-- 
2.40.1

