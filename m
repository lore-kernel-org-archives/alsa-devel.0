Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FDBC6FA82
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Sep 2022 10:04:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 596291F2;
	Thu, 22 Sep 2022 12:03:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 596291F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663841053;
	bh=Yqsf0f3a0jpvxbd2FLrnTIgZVuZrHsBJdUUIhVBRCEQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fhXSHWli+BeQJQgmugWqTTRSeaRwgpkJM+xv4FiMtOI1pLNOj91DghB2lPE2m1nhb
	 qz+tWcsnkAV4i1pge8JGMUX8jG8EULBohX15gR0BagGDaxU92/M4x4NYRPNkms09al
	 CweIhYZGpaOb7x0ypdytM69S28A2NEdPMa4Ue0YY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EBE28F80107;
	Thu, 22 Sep 2022 12:03:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9766AF80107; Thu, 22 Sep 2022 12:03:21 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 742D1F80107
 for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2022 12:03:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 742D1F80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="hQrkuO5N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663840999; x=1695376999;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Yqsf0f3a0jpvxbd2FLrnTIgZVuZrHsBJdUUIhVBRCEQ=;
 b=hQrkuO5NPzU+n85DPLGxvXWSmi2ixu2TUBL95sfN11edBxbn/fjXwZVz
 Z76embqbR3wCr+d3fqF8YC6upInJ/OUhUtAc/Wj0r3j41tUHs0Uoivo1s
 BWqK5AIYtNHAGzqdcvyY1dsBnKl3B9d829iK+cCo0snYHSoQZP05OD45S
 4iQy0zE3+FBG32RFS9eYYcV4Z7yBBZzMrXXwhneEUI+qYLASgd3dYJZON
 XuzlcusSmhq0tyJJUkP30UoutpXcxqlomHWbYompCAnMASgSNsLhL6rKK
 goFS1Qca7z+aYDP6gN7B6xFRjrXf1V5ox0RQ1/BRDantvsTByJrFSLtGn w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="300241272"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; d="scan'208";a="300241272"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2022 03:03:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; d="scan'208";a="622036193"
Received: from icostanz-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.home)
 ([10.251.210.149])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2022 03:03:08 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ASoC: SOF: Intel: add missing PCI IDs
Date: Thu, 22 Sep 2022 12:02:52 +0200
Message-Id: <20220922100254.27159-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Two missing PCI IDs already added to hda_intel.c and missed in SOF.

Pierre-Louis Bossart (2):
  ASoC: SOF: Intel: pci-tgl: reorder PCI IDs
  ASoC: SOF: pci-tgl: add missing PCI IDs for RPL

 sound/soc/sof/intel/pci-tgl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.34.1

