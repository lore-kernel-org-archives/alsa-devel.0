Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD0CC05027
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Feb 2023 11:29:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 362D51E1;
	Wed,  1 Feb 2023 12:28:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 362D51E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675250986;
	bh=K40Lt57OPAP1h+2SzTXpQNiv7apJHAs07JXKz58s6u4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=ZLyDHglxlhKDobtvHXQMD+4krm0Ta0XGF/Mbcy0POwafEtpJB3kYnrXtSJOFmLbF4
	 MH1pVuwZrit1l/HeXpVs6AlknCzvhrrYAptcOuyBczV/idko8Wl0/ckyEFHPx6Iu/J
	 atPdLKt1KUaBSKZqqMLOXHLFTcE1ce2yaQTYK1qI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AA281F8032B;
	Wed,  1 Feb 2023 12:28:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93DA3F8047D; Wed,  1 Feb 2023 12:28:49 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8D2AF80169
 for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2023 12:28:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8D2AF80169
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EZrWWMIw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1675250923; x=1706786923;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=K40Lt57OPAP1h+2SzTXpQNiv7apJHAs07JXKz58s6u4=;
 b=EZrWWMIwUFXhqWJhsaq+1orh3iTooe1EXayW+FJcVRHLIDdTdTz/+Or0
 jH52gSvP4AXTVvYqofKSQiNb2p/HZfxNpOC6ZpTVF+QOqbtQ8+ZAG0wG6
 HsKhavRn3qNL315slCjp9SZ4EPCg/jwEuCX1TOUNAPghQ5yia/4eCqbxm
 R0Fu+DNBxrWbljHzMpZ4X+wnmPB7zVWBXoaB36A9n2VbHIGRufyUd7D3O
 wIG7uJRo0jHJzeQROYp1t2bc8Z7ZQeayD0sG/azP1YQ+l8elqeou1q7GS
 Mxud2WD4Zx+YYCpIfDPuFW1KgqnmDxJiEdh/KSepZUcU6doRHzEy0DzA8 g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="329409365"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; d="scan'208";a="329409365"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2023 03:28:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="642374164"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; d="scan'208";a="642374164"
Received: from jehdildi-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.31.67])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2023 03:28:36 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org, kuninori.morimoto.gx@renesas.com,
 amadeuszx.slawinski@linux.intel.com
Subject: [PATCH 0/2] ASoC: (SOF) topology: Regression fixes for next
Date: Wed,  1 Feb 2023 13:28:44 +0200
Message-Id: <20230201112846.27707-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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
Cc: pierre-louis.bossart@linux.intel.com, cezary.rojewski@intel.com,
 kai.vehmanen@linux.intel.com, alsa-devel@alsa-project.org, tiwai@suse.com,
 ranjani.sridharan@linux.intel.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

Today I came across two regressions in next with SOF:

The topology would not load with a failure of creating playback DAI
the first patch is fixing this which was caused by a missing 'else' in the patch

After fixing the topology loading, the module unloading caused kernel panic.
The second patch is correcting that which is I likely caused by copy-paste to
set wrong unload callback for the graph element.

With these patches applied SOF is working on next and modules can be unloaded

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: SOF: topology: Add missed "else" in sof_connect_dai_widget
  ASoC: topology: Set correct unload callback for graph type

 sound/soc/soc-topology.c | 2 +-
 sound/soc/sof/topology.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.39.1

