Return-Path: <SRS0=M4Y+=24=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D5CC33C9B
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2020 21:49:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D481D24679
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2020 21:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YFhJGv6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D481D24679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3F1817A9;
	Tue,  7 Jan 2020 22:49:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3F1817A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578433794;
	bh=lQNUQvV7INsB/vZ+y77ZZ6nfNBONHtEaD8bXkVXWOh8=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YFhJGv6bkyC1B1UWrKLVU9eDdDb54eaWD9ifC3KmTGxqWps4DssPuKUNBTouiOBa8
	 FjA8rHGHbsMbnVKV8mZO1BaaFgnCNUEMIjkbJb9arf4/u5Ka9zq4QJ5XvTmjIT7ySo
	 n1ObwISC+W7EKexS0NO/2557hEZlnR39/AkBSh5w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39AE3F80140;
	Tue,  7 Jan 2020 22:49:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AF49EF8010B; Tue,  7 Jan 2020 22:49:02 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2F3EF8010B
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2020 22:48:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2F3EF8010B
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MhDIw-1jK8o71gSg-00eM6j; Tue, 07 Jan 2020 22:48:49 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Angus Ainslie (Purism)" <angus@akkea.ca>
Date: Tue,  7 Jan 2020 22:48:35 +0100
Message-Id: <20200107214846.1284981-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:hgbuQXLAyzDG0JLdaoMrLoDWbahmQuVhsc4uo1Y42HSztF/U8X6
 ljgOSi6NbIyjXc8pJuuPyyWWjY072XKl1nZa7gRqaSj3b4pZgsBevH/oICmQTvNFF9RE+UY
 Yt/NlSvRPQ5SU/coEP7/isRi1nD3iTQ1/xutnEX1rWhdL8H9l3g4n8rxw3IdBgwzi/ZyyHL
 nU2NpbirZydu/iaPee/Kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jDD5zrkTayQ=:EN/mtN5KHU2cVxtZeZDCMk
 xgZ8H2BYL/ixmxZ21NFKyG8bp3R+i/nAS3f2NjnUeasNXyDUXajUdENyH3nmi6yTtt3Dhvgre
 Poh/0wVsfsDZ4DK9V4TnRa6Z68admVkVOfm0g1ek52Tu0+bRvK7lcMxIYVEFf553fR0c23Bvs
 86Gt00GpxtUp/oE7SckjPvm/uMZixOwkfIF4ZpGkWuvAuxdOaEPpdgm1nZuoVeDCGiydd+KOZ
 5YfjJ1gm86kTl8lsA92siTw93yXTQ955iv8g0zqd7uw+bvH7aBsaKHD3zEs6sM3GnuWN3BAqL
 VRQbRvCmqm0ihoL8xVv3f/x4IeJOxSkt0ivi1akTjbnDTtvH/qQ6YlqGrgqMcmf5RD7jiIZ+l
 E7/fLjM1L/P6Gw3nbmsMw5MQ6TnjH/XX7pt8EgvrFcRS7uT7vXBolHHTcwTDt4SGCdl/JHw7e
 +oJ8ebXrMr+AP0RCNNANLnWpNuXAfMBnWXaumkfRKNRlpW72PdKAaPMoof/MxsdmSdCRuwQW2
 8a/ESpXM4Enx7dQqwGZ7qmrQAr7j9/RPaLKmlxhbqqxxvtevQWwpIjEZv2i+CIM+aBalhIFzv
 5VF69/WbcNqNGu/g0ANcsycf3hmgsb6p7KIqQHIQ95ifkcf7HWwbwf6Ej4iF/iqceGEVu370b
 yBEB/v9uLgQKHn2yMXUGpmltxwyQXGavNZqrNKey0t9cMhdqID8AGx+MYerkako8yxFKjyIUN
 OEn82awYzjE5t9T5Rd1L8qlkGeVaPelqx5rZGI8rQhCjeZz65uHTo0JXZHDIXTJ7s87lS3kIS
 FgidAOeuevJObQ50bHXv4L660UbaB6NlG1LAyBViHHO+b6q9gwVkwRvlgR+gGpsPxvqsgIW8l
 6RkABryq024BZXlNUo7A==
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Enrico Weigelt <info@metux.net>,
 Allison Randal <allison@lohutok.net>
Subject: [alsa-devel] [PATCH] ASoC: gtm601: fix build warning
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The driver produces warnings without CONFIG_OF, and makes
no sense without it either:

sound/soc/codecs/gtm601.c:50:34: error: 'bm818_dai' defined but not used [-Werror=unused-variable]
 static struct snd_soc_dai_driver bm818_dai = {
                                  ^~~~~~~~~
sound/soc/codecs/gtm601.c:32:34: error: 'gtm601_dai' defined but not used [-Werror=unused-variable]
 static struct snd_soc_dai_driver gtm601_dai = {
                                  ^~~~~~~~~~

Remove the #ifdef check to avoid the warning.

Fixes: 057a317a8d94 ("ASoC: gtm601: add Broadmobi bm818 sound profile")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/gtm601.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/gtm601.c b/sound/soc/codecs/gtm601.c
index 7f05ebcb88d1..ae9e1c70ca57 100644
--- a/sound/soc/codecs/gtm601.c
+++ b/sound/soc/codecs/gtm601.c
@@ -87,14 +87,12 @@ static int gtm601_platform_probe(struct platform_device *pdev)
 			(struct snd_soc_dai_driver *)dai_driver, 1);
 }
 
-#if defined(CONFIG_OF)
 static const struct of_device_id gtm601_codec_of_match[] = {
 	{ .compatible = "option,gtm601", .data = (void *)&gtm601_dai },
 	{ .compatible = "broadmobi,bm818", .data = (void *)&bm818_dai },
 	{},
 };
 MODULE_DEVICE_TABLE(of, gtm601_codec_of_match);
-#endif
 
 static struct platform_driver gtm601_codec_driver = {
 	.driver = {
-- 
2.20.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
