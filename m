Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB07C05027
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Jan 2023 08:52:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8EC3E96;
	Thu, 26 Jan 2023 09:52:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8EC3E96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674723172;
	bh=ECfBEratHnYXDaZQPhIW8OTrBKZi3olh2e4DbOVFlB8=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=YpyrIifbl5ukgKHT8i9p9x1dQbG/48NPtLsI3aUURBbQbWON4vP2erEWIAGpVSOBF
	 nXBoQQwF9rLT/gWpijmseFAtdXl0TZw88ZY3jnkFYYk16XrgwcJkShIFpnMkTSxatX
	 dSg4FQfbH6uRUJovgLA549i/cZ7hFfnZ7TmSAiTk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BCFA0F802DF;
	Thu, 26 Jan 2023 09:52:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68528F8027D; Thu, 26 Jan 2023 09:51:59 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83218F800AE
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2023 09:51:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83218F800AE
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=milrD4gE
Received: (Authenticated sender: herve.codina@bootlin.com)
 by mail.gandi.net (Postfix) with ESMTPA id CC2ED40023;
 Thu, 26 Jan 2023 08:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1674723115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fb4xrMYpWKXqyARukWe11gMYfz6J7B9pExDFH2CdKBE=;
 b=milrD4gEphaJ7kPdpchUKyFVd1T6kzhe2LKCbkaMDTiOqBwF/BigSNxn2+7t/ZZx+X2Tjj
 Bonod7PAvsY9udm2OugALZtPl/8lHKhr4LPjTa/+Zwk5IIWZFKsC3+SykNBKKKg+I//Mp3
 q3w7MYdAQL3bp9nw0GwqEiYveKp7DCOf6CRVhP9YRH+kMqXu2XLU6CMbcq+Y8imrqfl7E6
 SkIiejKBnHayvFcChzX8xREMlITHail0j6KPfC00tzfVmzPxaIbv23wEWFs/56Q4IZPraL
 19CgAJL+PC+xWetseYwIxetJw+KmDBcaRggZXvpaFqztHcHwZ/euj1KFA7miRw==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v3 0/3] Add the Renesas IDT821034 codec support
Date: Thu, 26 Jan 2023 09:51:34 +0100
Message-Id: <20230126085137.375814-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-gpio@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

The Renesas IDT821034 codec is four channel PCM codec with on-chip
filters and programmable gain setting.
It also provides SLIC (Subscriber Line Interface Circuit) signals as
GPIOs.

Based on previous iteration,
  https://lore.kernel.org/linux-kernel/20230120095036.514639-1-herve.codina@bootlin.com/
this v3 series mainly:
  - Fixes _put() methods
  - Introduces and uses idt821034_2x8bit_write()
  - Removes the '#if IS_ENABLED(CONFIG_GPIOLIB)' conditional

Best regards,
Herve Codina

Changes v2 -> v3:
  - Patch 1
    Fix the example node name.
    Add 'Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>'

  - Patch 2
    Fix _put() methods return code.
    Remove 'select REGMAP_SPI' from Kconfig
    Introduce and use idt821034_2x8bit_write()
    Remove the '#if IS_ENABLED(CONFIG_GPIOLIB)' conditional
    Fix comments and other minor code simplifications

Changes v1 -> v2:
  - All patches
    Reformat commit log

  - Patch 1
    Remove '$ref: /schemas/gpio/gpio.yaml#'
    Use 'unevaluatedProperties: false'
    Update the node name and remove the sound node in the example

  - Patch 2
    Change the file header comment format
    Rework in order to remove the regmap virtual registers

Herve Codina (3):
  dt-bindings: sound: Add Renesas IDT821034 codec
  ASoC: codecs: Add support for the Renesas IDT821034 codec
  MAINTAINERS: add the Renesas IDT821034 codec entry

 .../bindings/sound/renesas,idt821034.yaml     |   75 ++
 MAINTAINERS                                   |    7 +
 sound/soc/codecs/Kconfig                      |   11 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/idt821034.c                  | 1180 +++++++++++++++++
 5 files changed, 1275 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,idt821034.yaml
 create mode 100644 sound/soc/codecs/idt821034.c

-- 
2.39.0

