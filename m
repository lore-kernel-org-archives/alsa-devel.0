Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248F2C61DA4
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Feb 2023 11:15:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD09742;
	Fri,  3 Feb 2023 12:14:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD09742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675422928;
	bh=Klki+5BXEhj8/DZeiWZannPuh6qWty6qUF3JxXgLJS4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=skepTRoAwEkaX0ZmxDAx5vuuy6hyBmikA0kxv774lCe+dsi4N4DnLtXAR+Vct1+eK
	 iMeNB7ugEtSoFN53NaUP1LKAMQhnIQ0iYPBWXMdtcv7oqLudHg+XPPI4G7y38edSA6
	 RBcfssOMWUpPw2JjeVGQzlgXX2cIncdrOFb6bBFI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3702CF8032B;
	Fri,  3 Feb 2023 12:14:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80F4EF80423; Fri,  3 Feb 2023 12:14:37 +0100 (CET)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9BB42F800E3
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2023 12:14:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9BB42F800E3
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=A3ZfWhkC
Received: (Authenticated sender: herve.codina@bootlin.com)
 by mail.gandi.net (Postfix) with ESMTPA id B67FD1C000F;
 Fri,  3 Feb 2023 11:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1675422873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HAMONlr9R1WXauSk/Wj92zOzmiMIj87cwyrNJBK5Ezk=;
 b=A3ZfWhkCsAD4ulDqxrzeWbibM3BdocWhNXDIyJM9oR5wq7EKn1P7f/+wwuvj9xwv+O66PA
 2zcQydBGBDSbJMU//fm+piM5NsXyWq8mJbQRjixdQxDlRSxKnqoTXtlxvxLJ+ouiGRGPCe
 eZmkKF2O2K1phXQnRtNZkRyrPGfdAS1Nv0JIw8ONeOZWkTqbuAVdcHfUpwY2n+ItSubbhu
 tpFZxGIvtVSOkIcK6DWkjuVw93Z/yp+NX790IGNELwf1rdNO68aPJ2MYhh9+3Z8kgymtFQ
 DTDzv1u3dRafXpCqZqh2Jijr6CoUvTkBFQyLFrmuyfLo8nxtC5Rb01E+JT7icg==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 0/3] Add the Renesas X9250 potentiometers ASoC support
Date: Fri,  3 Feb 2023 12:14:19 +0100
Message-Id: <20230203111422.142479-1-herve.codina@bootlin.com>
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

The Renesas X9250 is a quad digitally controlled potentiometers.

In the audio path, it can be present on amplifiers designs and it can
be used in ALSA as an auxiliary audio device to control these amplifiers.

Best regards,
Herve Codina

Herve Codina (3):
  dt-bindings: sound: Add the Renesas X9250 potentiometers
  ASoC: codecs: Add support for the Renesas X9250 potentiometers
  MAINTAINERS: add the Renesas X9250 ASoC entry

 .../bindings/sound/renesas,x9250.yaml         |  60 ++++
 MAINTAINERS                                   |   7 +
 sound/soc/codecs/Kconfig                      |  11 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/x9250.c                      | 276 ++++++++++++++++++
 5 files changed, 356 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,x9250.yaml
 create mode 100644 sound/soc/codecs/x9250.c

-- 
2.39.0

