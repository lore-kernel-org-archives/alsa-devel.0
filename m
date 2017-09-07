From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH] ASoC: All bytes readable in 6 byte PLL
 register in ADAU17x1
Date: Thu, 7 Sep 2017 15:48:01 +0200
Message-ID: <alpine.DEB.2.11.1709071538410.14549@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id A14A72669F3
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 15:48:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id C81742E444
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 15:48:07 +0200 (CEST)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id ZsGB5Ejbae9i for <alsa-devel@alsa-project.org>;
 Thu,  7 Sep 2017 15:48:07 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
 by bes.se.axis.com (Postfix) with ESMTPS id 1E3552E154
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 15:48:06 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D5441A07B
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 15:48:06 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 824EA1A066
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 15:48:06 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
 by boulder02.se.axis.com (Postfix) with ESMTP
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 15:48:06 +0200 (CEST)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
 by seth.se.axis.com (Postfix) with ESMTP id 76ABB2A3E
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 15:48:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


The PLL register in the ADAU17x1 is 6 bytes long, so mark all bytes as =

readable.

This is of no importance for existing code, but is useful when =

instrumenting the code for debugging purposes.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
---
diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 2c1bd27..b324c6f 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -759,7 +759,13 @@ bool adau17x1_readable_register(struct device *dev, un=
signed int reg)
 =

 	switch (reg) {
 	case ADAU17X1_CLOCK_CONTROL:
+	/* The PLL register is 6 bytes long */
 	case ADAU17X1_PLL_CONTROL:
+	case ADAU17X1_PLL_CONTROL + 1:
+	case ADAU17X1_PLL_CONTROL + 2:
+	case ADAU17X1_PLL_CONTROL + 3:
+	case ADAU17X1_PLL_CONTROL + 4:
+	case ADAU17X1_PLL_CONTROL + 5:
 	case ADAU17X1_REC_POWER_MGMT:
 	case ADAU17X1_MICBIAS:
 	case ADAU17X1_SERIAL_PORT0:

-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
