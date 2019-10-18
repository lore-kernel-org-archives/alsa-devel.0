Return-Path: <SRS0=bEgE=YL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7053ACA9EA1
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:40:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB5521925
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WX+mas+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB5521925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34B29166F;
	Fri, 18 Oct 2019 09:40:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34B29166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571384450;
	bh=RmZ60KGyBdjkw688b6OIHAxFlKTARTQ7xv9MquQHNPw=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WX+mas+yDTg14upkdqrfab5gdPfhUPmEKIOCp3vPLsqlwltceLljXh/jBnYg8SBJE
	 aJf70MlojkBH4jonGDTWZOs3anNT2X1STERRRzejOWQmw+ocGDyoCqDaFeH/A+URUY
	 jpKHzdR4M/E/ASApZatf+9p38oney0NwopZO4gJs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 885B1F80377;
	Fri, 18 Oct 2019 09:39:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A06F5F80369; Fri, 18 Oct 2019 09:39:04 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7109F80323
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2019 09:39:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7109F80323
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1iLMqf-0006HU-RX; Fri, 18 Oct 2019 07:38:58 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: bhelgaas@google.com,
	tiwai@suse.com
Date: Fri, 18 Oct 2019 15:38:48 +0800
Message-Id: <20191018073848.14590-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018073848.14590-1-kai.heng.feng@canonical.com>
References: <20191018073848.14590-1-kai.heng.feng@canonical.com>
Cc: linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH v6 2/2] ALSA: hda: Allow HDA to be runtime
	suspended when dGPU is not bound to a driver
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Nvidia proprietary driver doesn't support runtime power management, so
when a user only wants to use the integrated GPU, it's a common practice
to let dGPU not to bind any driver, and let its upstream port to be
runtime suspended. At the end of runtime suspension the port uses
platform power management to disable power through _OFF method of power
resource, which is listed by _PR3.

After commit b516ea586d71 ("PCI: Enable NVIDIA HDA controllers"), when
the dGPU comes with an HDA function, the HDA won't be suspended if the
dGPU is unbound, so the power resource can't be turned off by its
upstream port driver.

Commit 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for
discrete GPU") only allows HDA to be runtime suspended once GPU is
bound, to keep APU's HDA working.

However, HDA on dGPU isn't that useful if dGPU is not bound to any
driver.  So let's relax the runtime suspend requirement for dGPU's HDA
function, to disable the power source to save lots of power.

BugLink: https://bugs.launchpad.net/bugs/1840835
Fixes: b516ea586d71 ("PCI: Enable NVIDIA HDA controllers")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v5, v6:
- No change.
v4:
- Find upstream port, it's callee's responsibility now.
v3:
- Make changelog more clear.
v2:
- Change wording.
- Rebase to Tiwai's branch.
 sound/pci/hda/hda_intel.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 240f4ca76391..e63b871343e5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1280,11 +1280,17 @@ static void init_vga_switcheroo(struct azx *chip)
 {
 	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
 	struct pci_dev *p = get_bound_vga(chip->pci);
+	struct pci_dev *parent;
 	if (p) {
 		dev_info(chip->card->dev,
 			 "Handle vga_switcheroo audio client\n");
 		hda->use_vga_switcheroo = 1;
-		chip->bus.keep_power = 1; /* cleared in either gpu_bound op or codec probe */
+
+		/* cleared in either gpu_bound op or codec probe, or when its
+		 * upstream port has _PR3 (i.e. dGPU).
+		 */
+		parent = pci_upstream_bridge(p);
+		chip->bus.keep_power = parent ? !pci_pr3_present(parent) : 1;
 		chip->driver_caps |= AZX_DCAPS_PM_RUNTIME;
 		pci_dev_put(p);
 	}
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
