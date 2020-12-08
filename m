Return-Path: <SRS0=8QnY=FM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8A1C4361B
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 15:38:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0C723A9B
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 15:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0C723A9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A51016D7;
	Tue,  8 Dec 2020 16:37:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A51016D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607441885;
	bh=LDnsnK02u4RnJzHw2TjdanG4ZVPpLn6WUWx36Sj6O5A=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=M7Zbg/uMA2nL6Lhk0kVVJhLrO69MsH185LJ7BvwfPwp2y0h28dDmUPgV4Xlbv/cE3
	 Xl+lRoHPqazUyIqzDpxnwdAw1jPDno+RH36EgUXSG6/oHOFZ/XQiRvCTRjVrI5blKt
	 4wjmZUAgtX/urOh8BEEnvihL7j3Up1IgT2R45CGI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C25EF80164;
	Tue,  8 Dec 2020 16:37:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4293F8019D; Tue,  8 Dec 2020 16:37:12 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E01BFF800E1
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 16:37:06 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id BBBE3A0040;
 Tue,  8 Dec 2020 16:37:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz BBBE3A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1607441824; bh=kSeMdyTvaRHC4iiCVm+N7bf46MOLAnyiNIbgqg8CkAc=;
 h=From:To:Cc:Subject:Date:From;
 b=2FQOCxj3JChOCDnt9nQMZn+alm3MVdsIjvG41Ysnb86t0/m7sUDHImGinMzITXoZX
 pAqFZTw0/oeRkDVSaTNri0JSIdDhR8G+vCfsMQU6PDAAjcSmh68ilO7DXt189wfRTa
 po73hk3GYlnWm4Hd7BrfBN7d6Bry5gwN4D30uapo=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue,  8 Dec 2020 16:36:58 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: [PATCH] ASoC: AMD Renoir - add DMI table to avoid the ACP mic probe
 (broken BIOS)
Date: Tue,  8 Dec 2020 16:36:54 +0100
Message-Id: <20201208153654.2733354-1-perex@perex.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, stable@kernel.org
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

Users reported that some Lenovo AMD platforms do not have ACP microphone,
but the BIOS advertises it via ACPI.

This patch create a simple DMI table, where those machines with the broken
BIOS can be added. The DMI description for Lenovo IdeaPad 5 and
IdeaPad Flex 5 devices are added there.

Also describe the dmic_acpi_check kernel module parameter in a more
understandable way.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1892115
Cc: <stable@kernel.org>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/soc/amd/renoir/rn-pci-acp3x.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c b/sound/soc/amd/renoir/rn-pci-acp3x.c
index b943e59fc302..3289ab3eae6f 100644
--- a/sound/soc/amd/renoir/rn-pci-acp3x.c
+++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
@@ -6,6 +6,7 @@
 
 #include <linux/pci.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/delay.h>
@@ -20,14 +21,13 @@ module_param(acp_power_gating, int, 0644);
 MODULE_PARM_DESC(acp_power_gating, "Enable acp power gating");
 
 /**
- * dmic_acpi_check = -1 - Checks ACPI method to know DMIC hardware status runtime
- *                 = 0 - Skips the DMIC device creation and returns probe failure
- *                 = 1 - Assumes that platform has DMIC support and skips ACPI
- *                       method check
+ * dmic_acpi_check = -1 - Use ACPI/DMI method to detect the DMIC hardware presence at runtime
+ *                 =  0 - Skip the DMIC device creation and return probe failure
+ *                 =  1 - Force DMIC support
  */
 static int dmic_acpi_check = ACP_DMIC_AUTO;
 module_param(dmic_acpi_check, bint, 0644);
-MODULE_PARM_DESC(dmic_acpi_check, "checks Dmic hardware runtime");
+MODULE_PARM_DESC(dmic_acpi_check, "Digital microphone presence (-1=auto, 0=none, 1=force)");
 
 struct acp_dev_data {
 	void __iomem *acp_base;
@@ -163,6 +163,17 @@ static int rn_acp_deinit(void __iomem *acp_base)
 	return 0;
 }
 
+static const struct dmi_system_id rn_acp_quirk_table[] = {
+	{
+		/* Lenovo IdeaPad Flex 5 14ARE05, IdeaPad 5 15ARE05 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "LNVNB161216"),
+		}
+	},
+	{}
+};
+
 static int snd_rn_acp_probe(struct pci_dev *pci,
 			    const struct pci_device_id *pci_id)
 {
@@ -172,6 +183,7 @@ static int snd_rn_acp_probe(struct pci_dev *pci,
 	acpi_handle handle;
 	acpi_integer dmic_status;
 #endif
+	const struct dmi_system_id *dmi_id;
 	unsigned int irqflags;
 	int ret, index;
 	u32 addr;
@@ -232,6 +244,12 @@ static int snd_rn_acp_probe(struct pci_dev *pci,
 			goto de_init;
 		}
 #endif
+		dmi_id = dmi_first_match(rn_acp_quirk_table);
+		if (dmi_id && !dmi_id->driver_data) {
+			dev_warn(&pci->dev, "ACPI settings override using DMI (ACP mic is not present)");
+			ret = -ENODEV;
+			goto de_init;
+		}
 	}
 
 	adata->res = devm_kzalloc(&pci->dev,
-- 
2.26.2
