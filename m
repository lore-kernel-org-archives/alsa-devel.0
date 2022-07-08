Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3152CC433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jul 2022 20:40:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD8173E7;
	Fri,  8 Jul 2022 22:39:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD8173E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657312811;
	bh=pv7k0syKpA3o72/+lz7oTMrJ6l0PA+zNrb+uUrBEvdU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h9S+rXVl0B3H7BN2emPnlKVt/KZjHXBERmaXZGaXr9m3UC+KnwICDUoiCg0hPd78M
	 oaqtHWnpxieoK1VGzG20E2HSeIzYU2sgGBjm610BC6Nmjs+qgXIRI+IWh4csSuUUbf
	 fn9l46gQbLHQV8aHSHnDFri/lsBj+qZ9D/koRIws=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29C95F80539;
	Fri,  8 Jul 2022 22:39:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0CAF0F80166; Fri,  8 Jul 2022 22:39:18 +0200 (CEST)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC002F8028B
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2022 22:39:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC002F8028B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="SjktdJP5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657312756; x=1688848756;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pv7k0syKpA3o72/+lz7oTMrJ6l0PA+zNrb+uUrBEvdU=;
 b=SjktdJP5MLz/h1Ppbc/A7m/jBRLY4FHH7AVESY4TBu6CYTqpA1Fh4Vzu
 uBRUXe03Iq8bKcEEnRzWHLfTzT+XNI6WHH6c2Ku98G7J2kZrhIpe2f+JR
 vfP1qpO+hR5JeHUwccZMlX33+cewgAldF++tbZvDV+a00lsKXQXFu3JCD
 zgNpaYQVBPSmZTKUN6EthVZ9nNfG6OBfVkl334dBJW0vl6mXGKR9/D0Eu
 fP460K068/OEYICRbgIAMJQqb6BdDN6788KAhRTaxvIyCpVMfvPZ0E3No
 2T50v3P/oLegnSK3aRTFHcRyA1HQmdfRWNJnScBRAcPFIPlP6eADB3FW2 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="346047671"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; d="scan'208";a="346047671"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2022 13:39:10 -0700
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; d="scan'208";a="621354527"
Received: from gcisnero-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.87.49])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2022 13:39:09 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ASoC: SOF: mediatek: fix boot sequences
Date: Fri,  8 Jul 2022 15:39:02 -0500
Message-Id: <20220708203904.29214-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Changes to DSP_RESET_SW need extra care.

YC Hung (2):
  ASoC: SOF: mediatek: Revise mt8195 boot flow
  ASoC: SOF: mediatek: fix mt8195 StatvectorSel wrong setting

 sound/soc/sof/mediatek/mt8195/mt8195-loader.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.34.1

