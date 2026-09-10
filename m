Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC5EC79FBB
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2026 12:53:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 599CC6027F;
	Thu, 10 Sep 2026 14:53:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 599CC6027F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789044825;
	bh=vvYfpsDe2KbetiQ3K76gDgutEoU30cGc6wu1lV+QADo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BmFz0kvFfGVvFZIrA3jDbUPWDfKaH6BwPeJsxAvoc+b76WnOH2yZxBvuBb1KA9Qsw
	 6kSPr/J82g9ScoD3aA4lcrEYNWZkNwcd5UAb7yGe3Y/y9KC3BF+TYg4njZzPQ6XUb0
	 uyQi71Ah5aQcyCVYqvo641gyepsuhxRbr3h1NOqg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1088DF80603; Thu, 10 Sep 2026 14:53:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 880FFF805FD;
	Thu, 10 Sep 2026 14:53:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A08CF8051D; Thu, 10 Sep 2026 14:53:03 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789044782;
	b=d751uS/MkbFYwFgHO+KhLLLlLS4Y3b4emYksZaBYXyg5swRjJoL5zzUXvugqJ2RVwzjN
	 Gak4Dg2KcomPZRsmGn3IPyxZHXOBk+uEVCRNLv1idauhWm0WgZYKEmK5OhDuBnqtxZem4
	 MJkoasOob8RkPJ0ZbgH7ZT0K+sFhKNnsMT9QTTwiEi1x+TnJgVfOEdeGrIE7rKd3ylZkt
	 0Ry6/gul0xK0f89X2bzcqU/D5N3EUPfWyMnjWnf73+5xNVksJ3SrFT95dmv2PCPVVozxu
	 ElSkhYZOf5KZPDPnR/puHdg9W+bWHFI6TJoKUKjtmMRA/N5cJjSArbSNl/0XQyyaAag==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789044782;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vvYfpsDe2KbetiQ3K76gDgutEoU30cGc6wu1lV+QADo=;
	b=HU84L4VLVJZUlz+QkA/FdaaBnNn4wyjdZ91W+afPzNgluBbPWcjftKFhrc9SLfckwfaI
	 tDfi8PAM3KGfnyFxpaX2+ctUNu7nB3TmBW7mE9hXac4IyfDvtxta7xZSMoVtIxvVHNYMi
	 4cosHeLJGDWRvsX3olr+vY15tDT9EFBnHVO7R+eXTU9dhZDv5dlxSVq27C9SFLRW9eT/p
	 bMAB5FfAr/g3NuzqZ8UO08E6mEvuqQgPTQSmC55+ou++Ic0zCMt7hFppEM3Ue6Bgc7Eft
	 QW+ts9doMmxniuQWAp27S43ECSQZ7Y6+iiqTf3W/bpc7GZKZVk0dSxohaEiUezzzKIQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=g1pwZur7;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E685AF8003C
	for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2026 14:53:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E685AF8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=g1pwZur7
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6D5B7600E2;
	Thu, 10 Sep 2026 12:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A701F00899;
	Thu, 10 Sep 2026 12:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044778;
	bh=IjobrVW3sTn+KH6hFT/g60yk9WLBkL2zoemv+GXiOvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g1pwZur7NIPxZt4cbm7WcNlDzxb252TR/L56Ze6F3pKjchufxgxeS4IdpoHQTECpP
	 cqa+mhDDQtUA/gqdm3JEvFGw76iNOSX/Vsq+BvkyzI/8kGf+SD/vdmJp7/Gk1hmmdP
	 E9S9pAFzQMlL9jYzMg02gi6HdzXdz1jh1Oll1bzx/dBAoWyMbKrYiRpLArO43TSlru
	 RpSc97cS4tNC21Nos4uNKTUwpbJFr7SaT4EL7L/z4LKMnD/vW3LyLVxFScSYxo2llQ
	 0Q6dm7BS1PEj64KfFZA2/ewhmYMjQhq7qnWWEuzisPAulmPhvI1VraGc15DbDGZn8r
	 cXHcGzNS3TfQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amit Kumar Mahapatra via Alsa-devel <alsa-devel@alsa-project.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Dhruva Gole <d-gole@ti.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	William Zhang <william.zhang@broadcom.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] spi: Replace all spi->chip_select and spi->cs_gpiod
 references with function call
Date: Thu, 10 Sep 2026 08:52:53 -0400
Message-ID: <20260910125254.183393-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910125254.183393-1-sashal@kernel.org>
References: <2026090831-flashy-precook-e8f5@gregkh>
 <20260910125254.183393-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NNS42XYKWE3DOMR4QBS37J3CZAGXBD5A
X-Message-ID-Hash: NNS42XYKWE3DOMR4QBS37J3CZAGXBD5A
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NNS42XYKWE3DOMR4QBS37J3CZAGXBD5A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Amit Kumar Mahapatra via Alsa-devel <alsa-devel@alsa-project.org>

[ Upstream commit 9e264f3f85a56cc109cc2d6010a48aa89d5c1ff1 ]

Supporting multi-cs in spi drivers would require the chip_select & cs_gpiod
members of struct spi_device to be an array. But changing the type of these
members to array would break the spi driver functionality. To make the
transition smoother introduced four new APIs to get/set the
spi->chip_select & spi->cs_gpiod and replaced all spi->chip_select and
spi->cs_gpiod references with get or set API calls.
While adding multi-cs support in further patches the chip_select & cs_gpiod
members of the spi_device structure would be converted to arrays & the
"idx" parameter of the APIs would be used as array index i.e.,
spi->chip_select[idx] & spi->cs_gpiod[idx] respectively.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Acked-by: Heiko Stuebner <heiko@sntech.de> # Rockchip drivers
Reviewed-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org> # Aspeed driver
Reviewed-by: Dhruva Gole <d-gole@ti.com> # SPI Cadence QSPI
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com> # spi-stm32-qspi
Acked-by: William Zhang <william.zhang@broadcom.com> # bcm63xx-hsspi driver
Reviewed-by: Serge Semin <fancer.lancer@gmail.com> # DW SSI part
Link: https://lore.kernel.org/r/167847070432.26.15076794204368669839@mailman-core.alsa-project.org
Signed-off-by: Mark Brown <broonie@kernel.org>

Stable backport notes:
Limit this dependency to spi-bcm63xx-hsspi.c, the driver affected by
3b0cee026640 ("spi: bcm63xx-hsspi: disable clocks on resume failure").
Convert its eleven existing chip-select accesses using the accessor
already provided by this stable tree. Drop conversions in other drivers,
SPI memory core and trace events, which are unrelated to the target.

Keep the stable driver's existing transfer implementation; do not import
upstream prepend support, additional helpers or drivers absent from 6.1.
In the existing resume function, use the spi_controller type/accessors
and the local name host. The old spi_master names are compatibility
aliases here, so this preserves behavior while allowing the target's
spi_controller_resume(host) error-handling hunk to apply unchanged.
No functions are added.

[ sashal: Reduced backport -- upstream 9e264f3f85a56 touches 92 file(s), this
  backport carries 1. Not backported here:
  drivers/spi/spi-altera-core.c
  drivers/spi/spi-amd.c
  drivers/spi/spi-ar934x.c
  drivers/spi/spi-armada-3700.c
  drivers/spi/spi-aspeed-smc.c
  drivers/spi/spi-at91-usart.c
  drivers/spi/spi-ath79.c
  drivers/spi/spi-atmel.c
  ... and 83 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 3b0cee026640 ("spi: bcm63xx-hsspi: disable clocks on resume failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 9948c2a459c12..16e2873c4d4b3 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -132,7 +132,7 @@ static void bcm63xx_hsspi_set_cs(struct bcm63xx_hsspi *bs, unsigned int cs,
 static void bcm63xx_hsspi_set_clk(struct bcm63xx_hsspi *bs,
 				  struct spi_device *spi, int hz)
 {
-	unsigned int profile = spi->chip_select;
+	unsigned int profile = spi_get_chipselect(spi, 0);
 	u32 reg;
 
 	reg = DIV_ROUND_UP(2048, DIV_ROUND_UP(bs->speed_hz, hz));
@@ -159,7 +159,7 @@ static void bcm63xx_hsspi_set_clk(struct bcm63xx_hsspi *bs,
 static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
-	unsigned int chip_select = spi->chip_select;
+	unsigned int chip_select = spi_get_chipselect(spi, 0);
 	u16 opcode = 0;
 	int pending = t->len;
 	int step_size = HSSPI_BUFFER_LEN;
@@ -168,7 +168,7 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 	u32 val = 0;
 
 	bcm63xx_hsspi_set_clk(bs, spi, t->speed_hz);
-	bcm63xx_hsspi_set_cs(bs, spi->chip_select, true);
+	bcm63xx_hsspi_set_cs(bs, spi_get_chipselect(spi, 0), true);
 
 	if (tx && rx)
 		opcode = HSSPI_OP_READ_WRITE;
@@ -236,14 +236,14 @@ static int bcm63xx_hsspi_setup(struct spi_device *spi)
 	u32 reg;
 
 	reg = __raw_readl(bs->regs +
-			  HSSPI_PROFILE_SIGNAL_CTRL_REG(spi->chip_select));
+			  HSSPI_PROFILE_SIGNAL_CTRL_REG(spi_get_chipselect(spi, 0)));
 	reg &= ~(SIGNAL_CTRL_LAUNCH_RISING | SIGNAL_CTRL_LATCH_RISING);
 	if (spi->mode & SPI_CPHA)
 		reg |= SIGNAL_CTRL_LAUNCH_RISING;
 	else
 		reg |= SIGNAL_CTRL_LATCH_RISING;
 	__raw_writel(reg, bs->regs +
-		     HSSPI_PROFILE_SIGNAL_CTRL_REG(spi->chip_select));
+		     HSSPI_PROFILE_SIGNAL_CTRL_REG(spi_get_chipselect(spi, 0)));
 
 	mutex_lock(&bs->bus_mutex);
 	reg = __raw_readl(bs->regs + HSSPI_GLOBAL_CTRL_REG);
@@ -251,16 +251,16 @@ static int bcm63xx_hsspi_setup(struct spi_device *spi)
 	/* only change actual polarities if there is no transfer */
 	if ((reg & GLOBAL_CTRL_CS_POLARITY_MASK) == bs->cs_polarity) {
 		if (spi->mode & SPI_CS_HIGH)
-			reg |= BIT(spi->chip_select);
+			reg |= BIT(spi_get_chipselect(spi, 0));
 		else
-			reg &= ~BIT(spi->chip_select);
+			reg &= ~BIT(spi_get_chipselect(spi, 0));
 		__raw_writel(reg, bs->regs + HSSPI_GLOBAL_CTRL_REG);
 	}
 
 	if (spi->mode & SPI_CS_HIGH)
-		bs->cs_polarity |= BIT(spi->chip_select);
+		bs->cs_polarity |= BIT(spi_get_chipselect(spi, 0));
 	else
-		bs->cs_polarity &= ~BIT(spi->chip_select);
+		bs->cs_polarity &= ~BIT(spi_get_chipselect(spi, 0));
 
 	mutex_unlock(&bs->bus_mutex);
 
@@ -291,7 +291,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 	 * e. At the end restore the polarities again to their default values.
 	 */
 
-	dummy_cs = !spi->chip_select;
+	dummy_cs = !spi_get_chipselect(spi, 0);
 	bcm63xx_hsspi_set_cs(bs, dummy_cs, true);
 
 	list_for_each_entry(t, &msg->transfers, transfer_list) {
@@ -304,7 +304,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 		spi_transfer_delay_exec(t);
 
 		if (t->cs_change)
-			bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
+			bcm63xx_hsspi_set_cs(bs, spi_get_chipselect(spi, 0), false);
 	}
 
 	mutex_lock(&bs->bus_mutex);
@@ -518,8 +518,8 @@ static int bcm63xx_hsspi_suspend(struct device *dev)
 
 static int bcm63xx_hsspi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(bs->clk);
@@ -534,7 +534,7 @@ static int bcm63xx_hsspi_resume(struct device *dev)
 		}
 	}
 
-	spi_master_resume(master);
+	spi_controller_resume(host);
 
 	return 0;
 }
-- 
2.53.0

