Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FA6C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:38:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E672024676
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Bs6IsGBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E672024676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD591839;
	Wed, 18 Dec 2019 17:37:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD591839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576687083;
	bh=Z/AN/6YURAtYbnRNZ94bRyv0sfEaIll0TJXApcJKij4=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Bs6IsGBIPoq8D8qVZSTVWGQxy2o4yM9H3krkBJf9G42UVRRKvzG5ajIxkxU/Jm2HF
	 JvhCUzWwQfEu6Lu7+prIaXbZU60xQsudqsLIuZLRD3qRw8DuvDwe8aEPVgaf/GHmle
	 CAnrjW01YDZwxsn5FzrSLa4w2PiqlQ33xbVjEajg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7160AF8014C;
	Wed, 18 Dec 2019 17:37:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBF9AF8022C; Wed, 18 Dec 2019 17:37:10 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D701F80059
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 17:37:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D701F80059
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MG9Xu-1iTL6J1RBk-00GY5i; Wed, 18 Dec 2019 17:37:03 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Charles Keepax <ckeepax@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Dec 2019 17:36:46 +0100
Message-Id: <20191218163701.171914-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:qgb4fv+y9jcZDdpdrYUzzZ6dcoTpOmWPWNxttY6NQEFKg1bDoXQ
 B8bqBnvvxos5FtMQnxCDOFQ527z89fM6fqTggu4VOZPdwXxYEy9r3w37gzECjT+eMTqGnF6
 ly9JMYeZKcJe3EuopMcDg8AL0lA4eT/yhs+C/64xsg5ABByb1llXoz3Uc2UmzGq6ONJoy1g
 2REgf8iAJKqKqxht1sJYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R7XF/1zRMos=:rp3V/WKf77fEMd73eFH0AC
 XfE2lkTKfYE6GtWPmzrYqXady4wg1PyKRAzgDKWZ+CA7kxJfOpadlZEtW9HC0hXifbbvMxhlo
 FtoXE7p2C+rWifRMsZXInr6rGUuBikVCCZ/CW2UETfN+C7MYdQNwDVyyvngfeBcCJ4cUG88NA
 kiyyMvEvtHt+4ygR4JtIS+yfqMiwmOY5ZB0npBnlXMYHsl02BbpcyeAPbK8DOFs+lTviqgMAh
 UIvMh4BINzOYUeTL6KlCeFGBrxRqrfGKHZl5gvIReuITkcnCMEfwgSEQ4yXE05kQopQsvzdma
 ImHi5E7Jhae12wCiWvk1qoQkZF/yqssco3orf/ancxLSwnUpRY4ULKkguqBj497u1WWjjQ4c9
 YF63nQRZ5abYyHbNdTJKZCGckwfJclo1WW7zIPa4L3Juz/LgjkqhzXVjNyP3m5eBhLlhdixhl
 7d9S6QTHnJW8iW+GNYkACv5GoV2RLjORwRv6Q96vtJ7kT8FwkRvhn4jwvHmI5p8nXlFoIDA2+
 WnwqOtgjmyEkDsNZBH/ZdPy1TTtVBJuB5xOwUHzHkzAA+SbBqMcsgmj979dYVSS4oHvmEE+tz
 Os0lKHQ3ejWk2A6v4KTFKjyxtLvW7l5y3v2Smc9adP6kqYzmOsf+oOQ9Vm5KLDP6zfIIZUR2j
 xx9aAE4XwAPBfvkNfn7q4gYRBxqj89Emcgr1I2c9VvP5CInn7T7Qi/s78hjLPrcSNti1Xd4nt
 8ZDNyamZZprFN8sHMIZo/tBD+SozGu1kGrg9O2LM1v3OpR8Hg2hx1utXYSKWZn8mFRMhABuvS
 Hl42gTjKfBvHrpWXhGPbfVEet4eapQAgdBDFtHT3aB/EBWANHtmm5/QrIq6BoaYBj2H9O/Y/b
 q+zRAyjuqTC7A1AQglAg==
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-gpio@vger.kernel.org
Subject: [alsa-devel] [PATCH] pinctrl: lochnagar: select GPIOLIB
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

In a rare randconfig build I came across one configuration that does
not enable CONFIG_GPIOLIB, which is needed by lochnagar:

ERROR: "devm_gpiochip_add_data" [drivers/pinctrl/cirrus/pinctrl-lochnagar.ko] undefined!
ERROR: "gpiochip_generic_free" [drivers/pinctrl/cirrus/pinctrl-lochnagar.ko] undefined!
ERROR: "gpiochip_generic_request" [drivers/pinctrl/cirrus/pinctrl-lochnagar.ko] undefined!
ERROR: "gpiochip_get_data" [drivers/pinctrl/cirrus/pinctrl-lochnagar.ko] undefined!

Add another 'select' like all other pinctrl drivers have.

Fixes: 0548448b719a ("pinctrl: lochnagar: Add support for the Cirrus Logic Lochnagar")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I wonder if GPIOLIB should just become mandatory when enabling the pinctrl
subsystem, or if there are still good reasons for leaving it disabled
on any machine that uses CONFIG_PINCTRL.
---
 drivers/pinctrl/cirrus/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/cirrus/Kconfig b/drivers/pinctrl/cirrus/Kconfig
index f1806fd781a0..530426a74f75 100644
--- a/drivers/pinctrl/cirrus/Kconfig
+++ b/drivers/pinctrl/cirrus/Kconfig
@@ -2,6 +2,7 @@
 config PINCTRL_LOCHNAGAR
 	tristate "Cirrus Logic Lochnagar pinctrl driver"
 	depends on MFD_LOCHNAGAR
+	select GPIOLIB
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
-- 
2.20.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
