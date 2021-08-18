Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2D1C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 07:56:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8F16103A
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 07:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD8F16103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FBE8166E;
	Wed, 18 Aug 2021 09:55:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FBE8166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629273356;
	bh=cqNAJ82qQwiXIEPOj/KVW6bu7Edi9/3eK+C7RJGdWOQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=A5oQeZtn/15ZrReUf6io6WBaQg8hnzjCRtdky3eIleidS0iImrWJud7jAK7d9M5QS
	 /2daaI5uSH4w3jcnxy2etpqOU3sL0dC6viU8sNYJSABA4X3EwSJJxSUE80TV/NzTSd
	 /0OIswcFsM7pvaTYi6vj2TTmTKYoxfbMhw9HW8pY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EB94F80259;
	Wed, 18 Aug 2021 09:55:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 229EAF80249; Wed, 18 Aug 2021 09:55:04 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25648F80163
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 09:55:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25648F80163
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="195855473"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="195855473"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2021 00:54:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="676974662"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2021 00:54:53 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 00/11] ASoC: Intel: Skylake: Fix and support complex
Date: Wed, 18 Aug 2021 09:57:31 +0200
Message-Id: <20210818075742.1515155-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, jairaj.arava@intel.com,
 upstream@semihalf.com, harshapriya.n@intel.com, cujomalainey@google.com,
 tiwai@suse.com, pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
 broonie@kernel.org, jenny.tc@intel.com, lma@semihalf.com,
 vamshi.krishna.gopal@intel.com
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

Existing skylake-driver supports very basic scenarios with limited range
of modules and their control. Attached changes first fix code as several
advanced configurations are 'mentioned' throughout the files but are not
actually functional. Follow up are changes adding missing support for
said configurations.

Cezary Rojewski (5):
  ASoC: Intel: kbl_da7219_max98927: Fix format selection for max98373
  ASoC: Intel: Skylake: Leave data as is when invoking TLV IPCs
  ASoC: Intel: Skylake: Fix module resource and format selection
  ASoC: Intel: Skylake: Fix module configuration for KPB and MIXER
  ASoC: Intel: Skylake: Select first entry for singular pipe config
    arrays

Gustaw Lewandowski (2):
  ASoC: Intel: Skylake: Fix passing loadable flag for module
  ASoC: Intel: Skylake: Simplify m_state for loadable modules

Kareem Shaik (1):
  ASoC: Intel: Skylake: Support multiple format configs

Pawel Harlozinski (1):
  ASoC: Intel: Skylake: Properly configure modules with generic
    extension

Piotr Maziarz (1):
  ASoC: Intel: Skylake: Select proper format for NHLT blob

Szymon Mielczarek (1):
  ASoC: Intel: Skylake: Support modules with generic extension

 include/uapi/sound/snd_sst_tokens.h          |   6 +-
 sound/soc/intel/boards/kbl_da7219_max98927.c |  55 +------
 sound/soc/intel/skylake/skl-messages.c       | 155 ++++++++++++-------
 sound/soc/intel/skylake/skl-pcm.c            |  25 ++-
 sound/soc/intel/skylake/skl-topology.c       | 155 +++++++++++--------
 sound/soc/intel/skylake/skl-topology.h       |  26 +++-
 6 files changed, 231 insertions(+), 191 deletions(-)

-- 
2.25.1

