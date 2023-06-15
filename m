Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFF3EB64D9
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jun 2023 15:31:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68900A4C;
	Thu, 15 Jun 2023 17:30:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68900A4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686843095;
	bh=L4kCCpZGPhvPAwdPQJaD/7Mdp/dpoL1bMOukyGSSSfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OaPblw6OSgoAy3EGkVWk+cwmsZ/YsdTul/giYwTr7uKH/EfN6BmKY/EShjvdoQxQj
	 5Afx0a6pqoW4mMJqV2wmwD7I0Fn22QTS+9QUeY8omZOv7Xt6eqfhQgnufflAfBxF3I
	 dx8M/dEppsiEeyGuPfQ+oYsSQ82Poe1TqHjPBBi8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4FBCCF80301; Thu, 15 Jun 2023 17:29:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D4B77F80301;
	Thu, 15 Jun 2023 17:29:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C21D0F80301; Thu, 15 Jun 2023 17:28:57 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0A950F80563
	for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2023 17:26:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A950F80563
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=C0+ccOGH
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1686842809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LumG9lQbCoaqWnFFIaPRrig8474uJ6glW5VjjTMChr8=;
	b=C0+ccOGHKHKM70Ug0wQ6ZwGEeenn6Xz/MyH1DNCkFHQKamD2rS7kEXbScP4gRuSPnF5pL+
	oWPaOm9gZ9wLz+92W/rhWYqiMKlDL3/hI1DwYQKnTNVl6mYn6/1W0YFlILdzVIeGnyYLNT
	gm7+zOqIa8uPNz9NjvceT5vrKuf49Xhawb1gYqFbK+xg0kw499OZuvMU/uIqodplYlWbe+
	wWLzx0L9gLaCJmeuLc01AzWKo6A/t1xvX3UOnyCJWbVC/1FAU2D0uOGnDWLI7jWhB5iApe
	L67YVgIZxnRQ5mPjTqwpE3ME6jyu3ogVkEGMpdmEpMDGAP5/rjt/L81QGfPpXA==
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
Received: by mail.gandi.net (Postfix) with ESMTPA id 9E4D3FF807;
	Thu, 15 Jun 2023 15:26:47 +0000 (UTC)
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v5 08/13] iio: inkern: Use max_array() to get the maximum
 value from an array
Date: Thu, 15 Jun 2023 17:26:26 +0200
Message-Id: <20230615152631.224529-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230615152631.224529-1-herve.codina@bootlin.com>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CF6II52HTRMJEQKZNVWYKIESWR6CDR6O
X-Message-ID-Hash: CF6II52HTRMJEQKZNVWYKIESWR6CDR6O
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CF6II52HTRMJEQKZNVWYKIESWR6CDR6O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use max_array() to get the maximum value from an array instead of a
custom local loop.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/inkern.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 71d0424383b6..8bfd91f74101 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -5,6 +5,7 @@
  */
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/slab.h>
@@ -875,11 +876,7 @@ static int iio_channel_read_max(struct iio_channel *chan,
 			return -EINVAL;
 		switch (*type) {
 		case IIO_VAL_INT:
-			*val = vals[--length];
-			while (length) {
-				if (vals[--length] > *val)
-					*val = vals[length];
-			}
+			*val = max_array(vals, length);
 			break;
 		default:
 			/* FIXME: learn about max for other iio values */
-- 
2.40.1

