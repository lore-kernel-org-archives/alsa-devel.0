Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32028C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Dec 2021 01:09:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8794D170C;
	Tue, 21 Dec 2021 02:08:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8794D170C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640048979;
	bh=i1tXTJcSPCIs8vQRFdGhVbKgBpGRpBUkhbABw4TMExA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NXXWphjI/5Brm65XTH5aYAmipeGCxlURIS0SJQiU9S4LVW9lljSaXbSe3N4iAQaHb
	 7Bp1T9nEJUgSTujKK99DPRBEU1aM3lhdMdAqE+Dcz8FJHUjYkaVHIK8wnqoq+5wqhF
	 4Ndfb9Y035ipJdQU3SXmnoOv1JIuaUBoc+QFkRl4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DBDEF8012A;
	Tue, 21 Dec 2021 02:08:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8A936F80125; Tue, 21 Dec 2021 02:08:40 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B0B8F80125
 for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2021 02:08:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B0B8F80125
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="237838426"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; d="scan'208";a="237838426"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Dec 2021 17:08:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; d="scan'208";a="684478610"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Dec 2021 17:08:25 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org
Subject: [PATCH 0/2] ALSA: hda: intel-sdw-acpi: go through HDAS ACPI at max
 depth of 2
Date: Tue, 21 Dec 2021 09:08:15 +0800
Message-Id: <20211221010817.23636-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: libin.yang@intel.com, vkoul@kernel.org,
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
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

In the HDAS ACPI scope, the SoundWire may not be the direct child of HDAS.
It needs to go through the ACPI table at max depth of 2 to find the
SoundWire device from HDAS.

Libin Yang (2):
  ALSA: hda: intel-sdw-acpi: harden detection of controller
  ALSA: hda: intel-sdw-acpi: go through HDAS ACPI at max depth of 2

 sound/hda/intel-sdw-acpi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

-- 
2.17.1

