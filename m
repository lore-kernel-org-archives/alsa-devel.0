Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFCEC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Dec 2021 04:01:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A3A51EFF;
	Tue, 14 Dec 2021 05:01:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A3A51EFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639454513;
	bh=+a2K0mhOGV9B7ALoF+9dJOTW0UNz6Me/1lgKth87Cw4=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=csOhmiJe8j/5VIKb3UB9bpuCEYsCWzLEpaCyFvtbO1A5+kM6GK0D5AbeBe5Wox6ek
	 z/wKjjQGWw/SO8NRiQBoVHNZfY69eXs5csaOy2rUbZGvQPCLR0BIV8bvsf8VWr6oY5
	 Pu99zOFKXzvAmb737cEc8yOuAN9YHDXcYrgZFffI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9702DF801EC;
	Tue, 14 Dec 2021 05:01:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9870BF80246; Tue, 14 Dec 2021 05:01:00 +0100 (CET)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14C4CF8016A
 for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2021 05:00:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14C4CF8016A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="KUYS2WNm"
Received: by mail-yb1-xb49.google.com with SMTP id
 h5-20020a255f45000000b005ffd939127bso33974163ybm.10
 for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2021 20:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=gH6VytNCcR/663SuXLz//aT5v81QXOOZ77y3idOPjPI=;
 b=KUYS2WNmggkO20Zmll03I/4/wpE7LncoJnK+g8c522aQ0VOShYg1J2Zo7mtzyNtyfZ
 7O1vdzMeRIzfVqbNOx79k5MrU00AsFWLDP+xAhU/26ztWIzyuPUDq6okL56jpphkJO64
 /k5O16IEiN8GX4DB+CuYBrEW5FWA0XkheykantgllsCRhOcKIm564bkQ57pEyMbVAJ49
 UZyN/It4QGdOC/f9Suqq/S2kqJ1BWqGM+9eU3eeVORznoO7+N3x7fdE0WoWptYJklfyH
 dliehqZjJWM8NEXPHDlGSmxOKD7qClfbSeSVgiXVFXQtEvTWF+2bQx1YT1QOevXM9s7h
 +I0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=gH6VytNCcR/663SuXLz//aT5v81QXOOZ77y3idOPjPI=;
 b=29cloTRKlk8q09dAozEHvSB2Khp0RxTuIBb8pfxGgBtq3vDPJFZeP/5Py0TCx9Cdhh
 kvgU2W0i3cPWT8VbIdiZEB64zGZXTc+Kzm2MXw11c8Tmnfmlnzag4Imr7nVB4JkuHX9W
 +3ZRfNuuVRPdxMZhpXwgGkffvUB5u5+Ma4AfRBfcFpKXQYd+ac5Ene5gjEWOiyYyDTam
 ppJjkkCWkY9dy9lQSQwqkp2Aji6Y9nQ4SYmjPOL/qlbhns3ZJctZ1plVfNxqdGjH5Fz+
 Br3hRstaloYizoC81UHYXq0oscKSe8tJD5obybLPiS1gU71d7vTfdvnkibUGckc2GLzW
 4zbw==
X-Gm-Message-State: AOAM530opmzZcYBXJiEoQeIp8/9GiR+vbrca7xKiwRmZjVC4AQMa77Tn
 9hTTJfcB4enx/KNjOj+kwOKrS1EAb8xa
X-Google-Smtp-Source: ABdhPJyJ+gRaNjgJGy9E0cHpu//789P5n3ECAFBUIUMkhGjSQmSpj9Wx6BMCctlIoRSkXsyJkLWIz/+9b8rK
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:16cc:acbf:e9c5:6393])
 (user=tzungbi job=sendgmr) by 2002:a25:7489:: with SMTP id
 p131mr3067762ybc.339.1639454446238; Mon, 13 Dec 2021 20:00:46 -0800 (PST)
Date: Tue, 14 Dec 2021 12:00:28 +0800
Message-Id: <20211214040028.2992627-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [RFC PATCH] ASoC: mediatek: mt8192-mt6359: fix device_node leak
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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

The of_parse_phandle() document:
    >>> Use of_node_put() on it when done.

The driver didn't call of_node_put().  Fixes the leak.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
Hi maintainers,

Need your comments.  The patch is one of the partial fixes that I think
it makes the most sense.

Option 1. Machine driver makes sure the object is valid until registered

This patch adopts the option.  It needs snd_soc_register_card() to call
of_node_get() somewhere to hold the reference count of of_node.  However,
I failed to find similar logic in soc-core.c.

Option 2. Machine driver borrows the reference count

This is what [1] adopts.  Decreasing the reference count in device's
remove() to make sure the object is valid for whole sound card's lifecycle.

[1]: https://elixir.bootlin.com/linux/v5.16-rc5/source/sound/soc/mediatek/mt8195/mt8195-mt6359-rt1019-rt5682.c#L1065


In fact, in my test environment, CONFIG_OF_DYNAMIC is not set.  The
implementation is empty[2].

Per [3]:
    >>> Hardly any platforms need this

[2]: https://elixir.bootlin.com/linux/v5.16-rc5/source/include/linux/of.h#L125
[3]: https://elixir.bootlin.com/linux/v5.16-rc5/source/drivers/of/Kconfig#L55

I am not sure if it is worthy to find somewhere to hold the reference count
in soc-core.c but I think option 1 makes it more clear to drivers.

 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index a606133951b7..24a5d0adec1b 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -1172,7 +1172,11 @@ static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return devm_snd_soc_register_card(&pdev->dev, card);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+
+	of_node_put(platform_node);
+	of_node_put(hdmi_codec);
+	return ret;
 }
 
 #ifdef CONFIG_OF
-- 
2.34.1.173.g76aa8bc2d0-goog

