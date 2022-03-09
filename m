Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB53DC433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Mar 2022 14:24:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F5AA1752;
	Wed,  9 Mar 2022 15:23:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F5AA1752
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646835839;
	bh=rmyqebZUa3J70FKF8z6zd8Rwo9FPJICDdx+bQr+j3Bw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jnPqiSH5XFWR5Qc+jLZVSXK7FIbjJ9oeRhxdJW9Qn65vacldETg7Yg2xEJU8haQ/v
	 NUP0dR1GkiiWthJpTkOspv2rLa4rksiMX1MrP13w39PkQUqEkq43vIZLExHRrHmbru
	 Zb7mLrnvSXvcadvWDCezpKz9DhNOIzl02AgqCCzk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C234FF80158;
	Wed,  9 Mar 2022 15:23:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 95C89F8016C; Wed,  9 Mar 2022 15:23:07 +0100 (CET)
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com
 [199.106.114.39])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6D08F800D2
 for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2022 15:23:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6D08F800D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="gAhPaHep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1646835785; x=1678371785;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=L/BoiUwHfGKaBdopgfMfhmCSFdJfogltxoiz1XVAUlg=;
 b=gAhPaHeplXXUfxBpgTaWFs6P6hX1E2ez44BxO2sljTC0bKa602wrD3k3
 ioithA46XWkv2SAqvr/VyExXGqwTQcjuXKuB6E3ed9n+/8ak9lWmURP4A
 pTBG6qSmugrBHPs2l3C6IHJJv2UaqYwbGUHJKRqolG+wn4DqM55INkqQh w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Mar 2022 06:22:57 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2022 06:22:57 -0800
Received: from hu-rbankapu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Mar 2022 06:22:55 -0800
From: Raghu Bankapur <quic_rbankapu@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, Raghu Bankapur <quic_rbankapu@quicinc.com>,
 <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V0 0/1] ASoC: msm: fix integer overflow for long duration
 compress offload playback
Date: Wed, 9 Mar 2022 19:52:27 +0530
Message-ID: <cover.1646835508.git.quic_rbankapu@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
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

32 bit variable is used for storing number of bytes copied to DSP,
which can overflow when playback duration goes beyond 24 hours.
Change data type for this variable to uint64_t to prevent overflow
and related playback anomaly.

below are the steps used to reproduce
Steps:-
1. play all clips from music app with Repeat All Songs enabled
2. one of clip is 1hr duration - 5.1_16bit_192khz_1hr.m4a
3. ACTUAL BEHAVIOUR:- there is no audio playback & progress bar was at 
end of stream, but time stamp continues to update till 31hrs for 1hr clip

Raghu Bankapur (1):
  ASoC: msm: fix integer overflow for long duration offload playback

 include/uapi/sound/compress_offload.h | 2 +-
 sound/core/compress_offload.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

