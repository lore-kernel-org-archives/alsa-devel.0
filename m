Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F6FC433EF
	for <alsa-devel@archiver.kernel.org>; Sun, 29 May 2022 08:51:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 060431916;
	Sun, 29 May 2022 10:50:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 060431916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653814297;
	bh=/GRZb915GdZ8I9hHxRfAyM2eyC3PvUS6S5dOqXW/CMA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rHFKeQxPiIR/hYssqSSL5pygXDkJ+P+sSJtiAVeRBNO+yNUEvQKEvA7yLVmi3dDAp
	 tAkWbWySE6c0yRHuZl1ReXuFpPRrforRVLZL27gzVkrKSTkOyU/jBtjVMpG+2hLIY1
	 kxndjxteBCSX+ahLRHGfqQtY5y9ws8CAwBIJ4jHI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57A6CF804A9;
	Sun, 29 May 2022 10:50:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5571F8026A; Sun, 29 May 2022 10:50:39 +0200 (CEST)
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2FDDBF8026A
 for <alsa-devel@alsa-project.org>; Sun, 29 May 2022 10:50:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FDDBF8026A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="NzWSoqR4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1653814238; x=1685350238;
 h=from:to:cc:subject:date:message-id;
 bh=TVvfrb426JQRLdfpmF2aegH10RqSqA1HLV5cXGROE2A=;
 b=NzWSoqR48gi28R6T1EN8HVVrMxOlpvmMIO1DytkvjNNTtUo+xLdw/MGM
 inkd9+GVPIEb6+ulSE9C8E2nOSKk8foyyANzo2kON5ABEKUMywHelV6X1
 cnEHyPXmd9STchyV2IEpTABZgLT1o0TKaHRTBXZqswNTS2KqAEdaEtJvU E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
 by alexa-out.qualcomm.com with ESMTP; 29 May 2022 01:50:34 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
 by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA;
 29 May 2022 01:50:33 -0700
X-QCInternal: smtphost
Received: from hu-rbankapu-blr.qualcomm.com (HELO
 hu-ub18template-blr.qualcomm.com) ([10.131.39.233])
 by ironmsg02-blr.qualcomm.com with ESMTP; 29 May 2022 14:20:22 +0530
Received: by hu-ub18template-blr.qualcomm.com (Postfix, from userid 4079802)
 id 40055800995; Sun, 29 May 2022 14:20:21 +0530 (+0530)
From: Raghu Bankapur <quic_rbankapu@quicinc.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Raghu Bankapur <quic_rbankapu@quicinc.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH V0 0/1] asoc: msm: use hashtable to check kcontrol
Date: Sun, 29 May 2022 14:20:08 +0530
Message-Id: <cover.1653813866.git.quic_rbankapu@quicinc.com>
X-Mailer: git-send-email 2.17.1
Cc: Krishna Jha <quic_kkishorj@quicinc.com>
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

use hashtabe instead of linear list to check kcontrol before
adding them for improving early audio KPI.

With this changes we see 600ms improvement in start of audio

Raghu Bankapur (1):
  asoc: msm: use hashtable to check kcontrol

 include/sound/control.h |  4 ++
 include/sound/core.h    | 12 +++++-
 sound/core/control.c    | 92 +++++++++++++++++++++++++++++++++--------
 sound/core/init.c       |  3 ++
 sound/soc/Kconfig       |  9 ++++
 5 files changed, 101 insertions(+), 19 deletions(-)

-- 
2.17.1

