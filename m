Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A46FECAAD3
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Sep 2022 17:41:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 632321632;
	Thu,  1 Sep 2022 19:40:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 632321632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662054089;
	bh=3QvqwoKmEMN+x9/aOyZ4aYdsCNDJDt7LdBDTdqRDPL8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kBD20A4MKXeA17wyAVtw3TAuZb6/udMUvdPprbU1wAbMY8gVUFqZapiIWn6jCjgFT
	 bF+Erm0ZmDUybdpCk6BWAm27Ier6S4WmQpBnz2e15jAELs/KLYHeI8RQ7SdV6n1GAb
	 L5IkD+ZOHDJYMQQgL29EUwfBB0i+IJCCtnyYx84k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1F78F804A9;
	Thu,  1 Sep 2022 19:40:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5CEAFF804A9; Thu,  1 Sep 2022 19:40:37 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CDBE9F80236
 for <alsa-devel@alsa-project.org>; Thu,  1 Sep 2022 19:40:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDBE9F80236
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="ayGD7zNg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1662054035; x=1693590035;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3QvqwoKmEMN+x9/aOyZ4aYdsCNDJDt7LdBDTdqRDPL8=;
 b=ayGD7zNg3aM4nO1Ni4t+OR9pgdYaaX0qS9PHdSui727ZSOI/CKd5Oolw
 CwY6391k18AlSXor25LKa3Osy2PimMToFNQVE100cb6JGp7ZhLgM7PF5g
 v8V57jAj60J7UXEEucFbSTnGTr8rwwqV3OdMQoQxqDtGAkXEYX6PYP51u
 Py81G4B2wIEcn47G70OdjIyLOqcXncd8wX9+6S2+r581n+wI5PWAoEO1W
 BfmOREPrtz7DRRN6e7KGYj13DdrclofdQ+F6N8xhkxeXqkNY3CXSoscv8
 joLJ7e1pf+QXSSg5qepQsHdwdEGsUTvKtkUGgu2yaPwU3dp1zW2aZ6V2Q w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="295792322"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; d="scan'208";a="295792322"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2022 10:40:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; d="scan'208";a="680960348"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2022 10:40:26 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH v3 0/2] lib/string_helpers: Introduce tokenize_user_input()
Date: Thu,  1 Sep 2022 19:50:20 +0200
Message-Id: <20220901175022.334824-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: andy@kernel.org, Cezary Rojewski <cezary.rojewski@intel.com>,
 kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com, willy@infradead.org, lgirdwood@gmail.com,
 hdegoede@redhat.com, ranjani.sridharan@linux.intel.com,
 amadeuszx.slawinski@linux.intel.com, peter.ujfalusi@linux.intel.com,
 linux-kernel@vger.kernel.org
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

Continuation of recent upstream discussion [1] regarding user string
tokenization.

First, tokenize_user_input() is introduced to allow for splitting
specified user string into a sequence of integers. Makes use of
get_options() internally so the parsing logic is not duplicated.

With that done, redundant parts of the sound driver are removed.

Originally similar functionality was added for the SOF sound driver. As
more users are on the horizon, it is desirable to update existing
string_helpers code and provide a unified solution.


Changes in v3:
- relocated tokenize_user_input() implementation to string_helpers as
  requested by Matthew

Changes in v2:
- reused get_options() so no parsing logic is duplicated
- simplified __user variant with help of memdup_user_nul()
  Both suggested by Andy, thanks for thourough review


[1]: https://lore.kernel.org/alsa-devel/20220707091301.1282291-1-cezary.rojewski@intel.com/


Cezary Rojewski (2):
  lib/string_helpers: Introduce tokenize_user_input()
  ASoC: SOF: Remove strsplit_u32() and tokenize_input()

 include/linux/string_helpers.h    |  2 +
 lib/string_helpers.c              | 45 +++++++++++++++
 sound/soc/sof/sof-client-probes.c | 93 ++++---------------------------
 3 files changed, 59 insertions(+), 81 deletions(-)

-- 
2.25.1

