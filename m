Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADD9C433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 16:25:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D1F610E5
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 16:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61D1F610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE0AF83A;
	Wed,  6 Oct 2021 18:24:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE0AF83A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633537510;
	bh=M9pBZ2i3661yZ6JJHEIP+KXk6XRYietBl0/XSFsupFw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GESgOwyopuJzXFphR5X4YrytK51o0fh/k9dFVmb9JMwG7eLBNsEQ4FU3+U8MiXUHE
	 kyp0aHQNIec2eUaF+cY1ddQ3057YlbkTAKH3aU8IbeJsI7UKsJx0ViP3D8K3GOr1Pi
	 5Akx1N8qOt2DYdJ8wUA/bj1WH8bGV19PT/hopxZA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64E5CF8025C;
	Wed,  6 Oct 2021 18:24:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4FA7F802D2; Wed,  6 Oct 2021 18:24:18 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2103F800FE
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 18:24:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2103F800FE
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="249316638"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; d="scan'208";a="249316638"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 09:20:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; d="scan'208";a="657046626"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.56])
 by orsmga005.jf.intel.com with ESMTP; 06 Oct 2021 09:20:05 -0700
From: Brent Lu <brent.lu@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/3] ASoC: soc-acpi: add alternative id field for machine
 driver matching
Date: Thu,  7 Oct 2021 00:18:03 +0800
Message-Id: <20211006161805.938950-2-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211006161805.938950-1-brent.lu@intel.com>
References: <20211006161805.938950-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Rander Wang <rander.wang@intel.com>,
 Mac Chiang <mac.chiang@intel.com>, Gongjun Song <gongjun.song@intel.com>,
 Bard Liao <bard.liao@intel.com>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
 Yong Zhi <yong.zhi@intel.com>, Charles Keepax <ckeepax@opensource.cirrus.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 Paul Olaru <paul.olaru@oss.nxp.com>, Brent Lu <brent.lu@intel.com>,
 Libin Yang <libin.yang@intel.com>,
 Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Curtis Malainey <cujomalainey@chromium.org>
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

Current design to support second headphone driver in the same machine
driver is to duplicate the entries in snd_soc_acpi_mach array and
board configs in machine driver. We can avoid this by adding an id_alt
field in snd_soc_acpi_mach structure to specify alternative ACPI HIDs
for machine driver enumeration and leave the codec type detection to
machine driver if necessary.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 include/sound/soc-acpi.h |  2 ++
 sound/soc/soc-acpi.c     | 21 ++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 2f3fa385c092..fcf6bae9f9d7 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -129,6 +129,7 @@ struct snd_soc_acpi_link_adr {
  * all firmware/topology related fields.
  *
  * @id: ACPI ID (usually the codec's) used to find a matching machine driver.
+ * @id_alt: array of ACPI IDs used as an alternative of id field.
  * @link_mask: describes required board layout, e.g. for SoundWire.
  * @links: array of link _ADR descriptors, null terminated.
  * @drv_name: machine driver name
@@ -146,6 +147,7 @@ struct snd_soc_acpi_link_adr {
 /* Descriptor for SST ASoC machine driver */
 struct snd_soc_acpi_mach {
 	const u8 id[ACPI_ID_LEN];
+	struct snd_soc_acpi_codecs *id_alt;
 	const u32 link_mask;
 	const struct snd_soc_acpi_link_adr *links;
 	const char *drv_name;
diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
index 395229bf5c51..ab67d640c20f 100644
--- a/sound/soc/soc-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -8,6 +8,25 @@
 #include <linux/module.h>
 #include <sound/soc-acpi.h>
 
+static bool snd_soc_acpi_id_present(struct snd_soc_acpi_mach *machine)
+{
+	struct snd_soc_acpi_codecs *id_alt = machine->id_alt;
+	int i;
+
+	if (acpi_dev_present(machine->id, NULL, -1))
+		return true;
+
+	if (id_alt == NULL)
+		return false;
+
+	for (i = 0; i < id_alt->num_codecs; i++) {
+		if (acpi_dev_present(id_alt->codecs[i], NULL, -1))
+			return true;
+	}
+
+	return false;
+}
+
 struct snd_soc_acpi_mach *
 snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
 {
@@ -15,7 +34,7 @@ snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
 	struct snd_soc_acpi_mach *mach_alt;
 
 	for (mach = machines; mach->id[0]; mach++) {
-		if (acpi_dev_present(mach->id, NULL, -1)) {
+		if (snd_soc_acpi_id_present(mach) != false) {
 			if (mach->machine_quirk) {
 				mach_alt = mach->machine_quirk(mach);
 				if (!mach_alt)
-- 
2.25.1

