Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572C7CE7A88
	for <alsa-devel@archiver.kernel.org>; Sun, 24 Sep 2023 07:38:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63748A4A;
	Sun, 24 Sep 2023 09:37:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63748A4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695541123;
	bh=k272lIinFWvLzU4fCGJHuzF68L5tfzewdqBxZ1N7s3g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=bICUKB1+AAKAJVX0MqTV6nZA3u2ivvsgm9BUbl8AahodYmAb3+MnVfyBELzQ1WqFD
	 YIV+DgYb6l69mRVSkeGTS3zgCyYEqvivrb5o96Tib/A3OG7yrKFYNaPDkJO1/LHn15
	 1IwV5XJpaXkeGGCccZBOlKgF/pCwXfG/peLLcnVQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 100F4F8016A; Sun, 24 Sep 2023 09:37:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 19E51F8016A;
	Sun, 24 Sep 2023 09:37:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6CCBF8016A; Sun, 24 Sep 2023 09:36:13 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr
 [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 57B82F80130
	for <alsa-devel@alsa-project.org>; Sun, 24 Sep 2023 09:36:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57B82F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256
 header.s=t20230301 header.b=pQy7OeR8
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id kJesqk7nIGc65kJesqQUu3; Sun, 24 Sep 2023 09:36:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1695540963;
	bh=018xaLEDvxggoMddYpgeo/uvtqjMWAwwaPEHKHKhtvA=;
	h=From:To:Cc:Subject:Date;
	b=pQy7OeR8/JRokKoalfqARW7ycJBOE9XFchZQxVNYhEXztu4UfdU1+F0kj2pmV28aO
	 avdVOG0lO5QJB3GNl3bBX6xGCB2HsPjwCPGC7ZqDlHUFdlzbmmvmofoZQq2OofMt9g
	 zl975c9qmr6bq2Ji42XXpKuAK1ig5oC5yVccIcVpOOYiEBRfXSZAmwF1uA43icMWrh
	 mmlPixtAbDWeRPqP7MHo3XDf6exTjL5hhPh0Jj86aRb/YFxqXekWxjXu7y0/iYnUU+
	 /R1zrZGk5lKkqODxeXGwJv1SG2Ja2xHQcrjd2mCUOXlK3zLH7MsnQCVsRnV9LjF8N4
	 mYyvzM4ZCl5dg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 24 Sep 2023 09:36:03 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: audio-iio-aux: Use flex array to simplify code
Date: Sun, 24 Sep 2023 09:36:01 +0200
Message-Id: 
 <1c0090aaf49504eaeaff5e7dd119fd37173290b5.1695540940.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FLJXKJR5OJU5Z5UCPZUS6ASTGG4IPVQB
X-Message-ID-Hash: FLJXKJR5OJU5Z5UCPZUS6ASTGG4IPVQB
X-MailFrom: christophe.jaillet@wanadoo.fr
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FLJXKJR5OJU5Z5UCPZUS6ASTGG4IPVQB/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

"io-channel-names" is expected to have few values, so there is no real
point to allocate audio_iio_aux_chan structure with a dedicate memory
allocation.

Using a flexible array for struct audio_iio_aux->chans avoids the
overhead of an additional, managed, memory allocation.

This also saves an indirection when the array is accessed.

Finally, __counted_by() can be used for run-time bounds checking if
configured and supported by the compiler.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/audio-iio-aux.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/audio-iio-aux.c b/sound/soc/codecs/audio-iio-aux.c
index a8bf14239bd7..1e8e1effc2af 100644
--- a/sound/soc/codecs/audio-iio-aux.c
+++ b/sound/soc/codecs/audio-iio-aux.c
@@ -26,8 +26,8 @@ struct audio_iio_aux_chan {
 
 struct audio_iio_aux {
 	struct device *dev;
-	struct audio_iio_aux_chan *chans;
 	unsigned int num_chans;
+	struct audio_iio_aux_chan chans[]  __counted_by(num_chans);
 };
 
 static int audio_iio_aux_info_volsw(struct snd_kcontrol *kcontrol,
@@ -250,23 +250,18 @@ static int audio_iio_aux_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
-	iio_aux = devm_kzalloc(dev, sizeof(*iio_aux), GFP_KERNEL);
+	count = device_property_string_array_count(dev, "io-channel-names");
+	if (count < 0)
+		return dev_err_probe(dev, count, "failed to count io-channel-names\n");
+
+	iio_aux = devm_kzalloc(dev, struct_size(iio_aux, chans, count), GFP_KERNEL);
 	if (!iio_aux)
 		return -ENOMEM;
 
 	iio_aux->dev = dev;
 
-	count = device_property_string_array_count(dev, "io-channel-names");
-	if (count < 0)
-		return dev_err_probe(dev, count, "failed to count io-channel-names\n");
-
 	iio_aux->num_chans = count;
 
-	iio_aux->chans = devm_kmalloc_array(dev, iio_aux->num_chans,
-					    sizeof(*iio_aux->chans), GFP_KERNEL);
-	if (!iio_aux->chans)
-		return -ENOMEM;
-
 	names = kcalloc(iio_aux->num_chans, sizeof(*names), GFP_KERNEL);
 	if (!names)
 		return -ENOMEM;
-- 
2.34.1

