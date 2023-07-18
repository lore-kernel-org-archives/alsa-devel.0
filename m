Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DACEB64DA
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Jul 2023 10:16:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DAA36E72;
	Tue, 18 Jul 2023 12:15:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DAA36E72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689675364;
	bh=ptYraEo1qAB14mqA1M/9HK/cRzV4KA8Al39yu2DpwN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SIa8zGupqGvXMi3UarBkGtBnUHx1YBXvtF4+SjDw8gjwVvgdUOIttf6ibO9ewy05p
	 Oejnp/ZnpR5DWaznfPF73UuupeNfa9l+ZAFrIAvC7pvTwQJ3DO1re90sX4Zbs0G0dl
	 m1gyqYrj7pQ9j2fjY0nTsLukflNrOYmaKEdxN4uQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 16024F8057F; Tue, 18 Jul 2023 12:14:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 58F2AF8055B;
	Tue, 18 Jul 2023 12:14:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9B2ABF80520; Tue, 18 Jul 2023 10:46:11 +0200 (CEST)
Received: from mblankhorst.nl (lankhorst.se
 [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1C590F8032D;
	Tue, 18 Jul 2023 10:46:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C590F8032D
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: sound-open-firmware@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 2/7] ALSA: hda/i915: Allow xe as match for
 i915_component_master_match
Date: Tue, 18 Jul 2023 10:45:17 +0200
Message-Id: <20230718084522.116952-3-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718084522.116952-1-maarten.lankhorst@linux.intel.com>
References: <20230718084522.116952-1-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: mlankhorst@mblankhorst.nl
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: RKM3F3KDLGFJNT2PFL63EC73ZNWX5REN
X-Message-ID-Hash: RKM3F3KDLGFJNT2PFL63EC73ZNWX5REN
X-Mailman-Approved-At: Tue, 18 Jul 2023 10:13:56 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RKM3F3KDLGFJNT2PFL63EC73ZNWX5REN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

xe is a new driver for intel GPU's that shares the sound related code
with i915.

Don't allow it to be modprobed though; the module is not upstream yet
and we should exclusively use the EPROBE_DEFER mechanism.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 sound/hda/hdac_i915.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 12f93008ad361..c88f251388e80 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -108,7 +108,8 @@ static int i915_component_master_match(struct device *dev, int subcomponent,
 	hdac_pci = to_pci_dev(bus->dev);
 	i915_pci = to_pci_dev(dev);
 
-	if (!strcmp(dev->driver->name, "i915") &&
+	if ((!strcmp(dev->driver->name, "i915") ||
+		 !strcmp(dev->driver->name, "xe")) &&
 	    subcomponent == I915_COMPONENT_AUDIO &&
 	    connectivity_check(i915_pci, hdac_pci))
 		return 1;
-- 
2.39.2

