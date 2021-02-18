Return-Path: <SRS0=3Kie=HU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17884C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Feb 2021 12:32:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2BA64E2F
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Feb 2021 12:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2BA64E2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AEF9E15E2;
	Thu, 18 Feb 2021 13:32:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AEF9E15E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613651572;
	bh=V/qm4Zb2vbdEXZOBrpqD87DeDWga9JvS4Z9uy2dBmM4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pHnn3dfdNAprcJM6NrlgQ0PXurteoAwata5bmeui4n5TI6CN2DJWjgaW8OpNJephV
	 otDlU9J0F3zFLuOqRMJf3wszfeAmkBL6Yx5GV7DxVXwdcrjvXQAQt2J58kJwvIo6ZZ
	 MTIUwnPphHkfEl116vA/3tkTvKEfkmJ5VFkzQv0M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 058CDF800E5;
	Thu, 18 Feb 2021 13:32:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 17473F801DB; Thu, 18 Feb 2021 13:32:00 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9BF55F800E5
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2021 13:31:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9BF55F800E5
IronPort-SDR: ra66LMwBHLZixjPrNUkNYenRtKf49bEiruHAvXuggHsxmAppYgunQqloSHOiD2GutX/oG5fv7a
 azWNQyROFE5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="163264979"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; d="scan'208";a="163264979"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2021 04:31:48 -0800
IronPort-SDR: i1C8D31gVPih8GPcw9H4uvhFZ7PSGL39P7JBltc70lRqjGEjKXf0q9sbc4gVHlus8zMgxHXEl9
 3fZOda8Ply6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; d="scan'208";a="364821582"
Received: from snappy-s2600wt2r.iind.intel.com ([10.223.163.26])
 by orsmga006.jf.intel.com with ESMTP; 18 Feb 2021 04:31:46 -0800
From: vamshi.krishna.gopal@intel.com
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] dmic fix to  allow userspace to choose ch count
Date: Thu, 18 Feb 2021 18:01:23 +0530
Message-Id: <20210218123125.15438-1-vamshi.krishna.gopal@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: harshapriya.n@intel.com, naveen.m@intel.com, biernacki@google.com,
 sathya.prakash.m.r@intel.com
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

From: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.corp-partner.google.com>

hello,
git.kernel.org/pub/scm/linux/kernel/git/vkoul/sound.git/commit/?h=intel2&id=c5e7e00788229ab8491676a424fb42778038ad29
git.kernel.org/pub/scm/linux/kernel/git/vkoul/sound.git/commit/?h=intel2&id=d87fa3f7a365bcccb396146ada03e03a4574159d
These patch series is about removing channel count selection based on mach/pdata 
and assign min and max channel only based on hw params. This allows
userspcae to choose channel count.
This patch series was Acked by Vinod and taken into his tree. 
But seems its missed to be posted. 
hence i've rebased the same commits and re sending.

Naveen Manohar (2):
  ASoC: Intel: kbl: Remove option of choosing CH count based on pdata
  ASoC: Intel: kbl: update dmic fixup params

 sound/soc/intel/boards/kbl_rt5663_max98927.c | 44 +++++++-------------
 1 file changed, 14 insertions(+), 30 deletions(-)

-- 
2.17.1

