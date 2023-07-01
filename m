Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE7BEB64DC
	for <alsa-devel@archiver.kernel.org>; Sat,  1 Jul 2023 04:52:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22AE383A;
	Sat,  1 Jul 2023 06:51:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22AE383A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688187147;
	bh=NDKhCva291HrBFyUCX2WUXWZp/DC9kjIhdFA4xInn0g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=sojxsKL0ORXFGJOriZWwryZk88SD6fIyDLKIlulD+dOdH4fRtyTQ1kxeWN0r+knS3
	 WKhB3v/DUt6QzpGBSwwBHqpzDeih8It8LhVhkpEB9yxJ7zSHqumQN758Z+bmDnO+Fr
	 g+iOLCE/aAJfOCoakzscaBTC3gb93oLYv+g3kAsw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AB40FF80093; Sat,  1 Jul 2023 06:51:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 17496F80093;
	Sat,  1 Jul 2023 06:51:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4B157F80246; Sat,  1 Jul 2023 06:48:56 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 743ADF80124
	for <alsa-devel@alsa-project.org>; Sat,  1 Jul 2023 06:48:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 743ADF80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=5BOjmmRR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Ouh+ENUfH7xDuVT7/QdgSLCq0AO5QpecmqQ9yR+vKU4=; b=5BOjmmRRZbyzHZwHcUwvpKsx0g
	z3P5naFfEu/0m6BSaanaNGWs0IRuQQBjI2xz2BRVJivDYa54kRd6nAFudndfJ41KsYlzYS9bpBIEo
	Jk+yvhFndjxf5pUexRyWK76ivhXUKoNgb/YzvdBzUi6CDAsM/8j1WWDo8sV0SW89W1qcqumHH4KEa
	pxRzobws8/Oz2fNBIWWeuAzP9w3Jj7Y6w6Pmc/GcV1WuOWOBXkSu6Q+x7t2/1iODekyJTH4LQtfz9
	rfAmqI+bgo2ITH9ai2jQ9nQadsFeDp8c0cwyq/9fGwl70hDCcIfEi6WY3q957fbrQ95rkuYjWj6N2
	/PRYpzcg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qFSXF-005AKU-1V;
	Sat, 01 Jul 2023 04:48:37 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	alsa-devel@alsa-project.org
Subject: [PATCH v2] ASoC: stac9766: fix build errors with REGMAP_AC97
Date: Fri, 30 Jun 2023 21:48:36 -0700
Message-ID: <20230701044836.18789-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6E6BVS6Y7JRZ4Z3JP2MT22SGL7IOPGM5
X-Message-ID-Hash: 6E6BVS6Y7JRZ4Z3JP2MT22SGL7IOPGM5
X-MailFrom: rdunlap@infradead.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6E6BVS6Y7JRZ4Z3JP2MT22SGL7IOPGM5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Select REGMAP_AC97 to fix these build errors:

ERROR: modpost: "regmap_ac97_default_volatile" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
ERROR: modpost: "__regmap_init_ac97" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!

Fixes: 6bbf787bb70c ("ASoC: stac9766: Convert to regmap")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
---
v2: rebase/resend

 sound/soc/codecs/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1707,6 +1707,7 @@ config SND_SOC_STA529
 config SND_SOC_STAC9766
 	tristate
 	depends on SND_SOC_AC97_BUS
+	select REGMAP_AC97
 
 config SND_SOC_STI_SAS
 	tristate "codec Audio support for STI SAS codec"
