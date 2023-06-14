Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1058AEB64D9
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jun 2023 07:53:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0055784C;
	Wed, 14 Jun 2023 09:52:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0055784C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686729186;
	bh=qbmVPAzFI1XOwkwskj5o2eNXuVt/Ikrzs/nBEeqOaDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KfBf5SLwwhc63Qb4z5uGN1fmcTPV6nHsll+PtFNJDvOrKR76egBc0QYxTGqqty4NJ
	 NlLOeAuddpb5+9aeBPFunaW2O57qpn+OFBpYQbLF4EAkG7NxWe+lbAjAJjYEccARlk
	 UAi37tbkZ5G7YL6VGPk6cn7RsGlWdKDw9GDskhF4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EF655F805E4; Wed, 14 Jun 2023 09:50:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 96B6BF805E5;
	Wed, 14 Jun 2023 09:50:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7D9EF8056F; Wed, 14 Jun 2023 09:49:43 +0200 (CEST)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 00B2EF8052E
	for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2023 09:49:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00B2EF8052E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=UvT5GVn8
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1686728981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnpK8aRuMvnC0Ke7Gmvf/IJzrUVS+kKViuz7i3kW6rw=;
	b=UvT5GVn8CRS3Cprdn6Tj2AX5c7jHRpv0b9CD7gcrB0INlIYy2bJ0z1JL+pO1e9Uzvio1Ap
	E3Uau4ahQ+4Z9NG50v3Q0H+n2TTs0ztktonPqFmobHxZF8uDmre0DvS9csZ+leJx7Nu83U
	uP9Lb9TLGjbDKIGqIZ74maAmTu35d1LiHLC15Zn0Ks4x633swWLnydhd9BIBM/1WSxFRbg
	3vBU2a1/Us2MgDUyAXOuo/R2eHQ451gbrFjjjZRJIdhqxwPthCef5T+rJ0R/f34eQJumwc
	NiDSenu01M0V8nRKTPSO9/txbaMC9irsjWJwaPvbqq8Bsa3L0CAMb3yyy02l6g==
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
Received: by mail.gandi.net (Postfix) with ESMTPA id 44A311C0017;
	Wed, 14 Jun 2023 07:49:40 +0000 (UTC)
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
Subject: [PATCH v4 09/13] iio: inkern: Replace a FIXME comment by a TODO one
Date: Wed, 14 Jun 2023 09:49:00 +0200
Message-Id: <20230614074904.29085-10-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614074904.29085-1-herve.codina@bootlin.com>
References: <20230614074904.29085-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: HOUJSQEQTODDGI4I2X7OOYPOUJMRB5OM
X-Message-ID-Hash: HOUJSQEQTODDGI4I2X7OOYPOUJMRB5OM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HOUJSQEQTODDGI4I2X7OOYPOUJMRB5OM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This FIXME comment is more a TODO one.
It is a note when someone will need for this currently unsupported case.

Change from FIXME to TODO.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/inkern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 8bfd91f74101..19ddd77adb11 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -879,7 +879,7 @@ static int iio_channel_read_max(struct iio_channel *chan,
 			*val = max_array(vals, length);
 			break;
 		default:
-			/* FIXME: learn about max for other iio values */
+			/* TODO: learn about max for other iio values */
 			return -EINVAL;
 		}
 		return 0;
-- 
2.40.1

