Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C5AEB64DA
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jun 2023 07:52:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5801827;
	Wed, 14 Jun 2023 09:51:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5801827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686729135;
	bh=SHsRGGRQfIPzKnJ/GmHg5EWGSRe7iLhNHPVjQhTfDzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iRoBRPckMSskPWRLH/GGgV1nLASICOEeHswZewaff4Kh7FqJq00qeJvtJVa5sCo5q
	 lE0mkPwKQmwtO344sDwSsRS2srKPVaSGXT6fIQHzE0JPOFLQH4fGjICcNAVMh4D4Mi
	 3KcoSADpOBVr2mfq+C/O4XRekNwEfBiTGUidM3M0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 574DCF805BE; Wed, 14 Jun 2023 09:49:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A866F805B4;
	Wed, 14 Jun 2023 09:49:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0757DF80557; Wed, 14 Jun 2023 09:49:41 +0200 (CEST)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::225])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 36FCCF800BA
	for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2023 09:49:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36FCCF800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=oLJh22A5
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1686728974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgrvFu84ZrZIMRnZAFcmpkUkbG8qISQlNfLp/T/UU5I=;
	b=oLJh22A5HuMXJQbcnfPT/Xol6viKiHPqVmtZge5Z0fe7d4zquT9pB8unrK400DQ1I+nyK7
	JD/t9ZiFEUbaYdZWgdPvmRUYW3B88gBtBCnMnPhY1K9M3NDQ5iKZyp8g6eFD7UdIVzAwuF
	9taeIDgJCoD7dw/g8YGHYC6zj6acJCjBhkBOAfw4gBqXgMybvOSSgIKjx3L1/D9FclY+3E
	1bc7EUIOwzK3Ow6TCaOSfLdhtMOUmvy0WPhirIUazKY3PKPbe6YKB6c3C8ELPb6vsp/TPH
	wYstIbvp1stsk3UYySWsafTQhiwskrbRdeUs5RaxZE56+j+GG2XWOKJEkqNM1w==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 29D061C0016;
	Wed, 14 Jun 2023 07:49:33 +0000 (UTC)
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
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 04/13] iio: consumer.h: Fix raw values documentation notes
Date: Wed, 14 Jun 2023 09:48:55 +0200
Message-Id: <20230614074904.29085-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614074904.29085-1-herve.codina@bootlin.com>
References: <20230614074904.29085-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZKHSNPHYNWBV4VBBOKQONQWY3NAFKHQ6
X-Message-ID-Hash: ZKHSNPHYNWBV4VBBOKQONQWY3NAFKHQ6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZKHSNPHYNWBV4VBBOKQONQWY3NAFKHQ6/>
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
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

