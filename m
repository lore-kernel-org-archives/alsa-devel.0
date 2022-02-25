Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16489C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Feb 2022 13:22:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5912F1AA7;
	Fri, 25 Feb 2022 14:22:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5912F1AA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645795372;
	bh=QeTqIQ3wQitzIsSCOXLCDNHXab6GX+uIIin2r2eyh44=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MsVvGs6YDh2H2dOvk45lwgQs/I4oAWZh4hY6I04tISunJHjAWOvWWaoZyC8C9STxS
	 xDkL5QxQzJHlsxDMBiSlSLsGgbLYZ2HcsBYfNI3W6puPqYihAPQVdeWe57vfPakU65
	 ZmvR2ctDpMS9QP8JYVCqTjxzC6xMgZKSRdmfW0LM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90639F8060A;
	Fri, 25 Feb 2022 14:11:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9C6D5F80132; Fri, 25 Feb 2022 11:40:12 +0100 (CET)
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com
 [199.106.114.39])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D419F80118
 for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2022 11:40:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D419F80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="FD07+CAD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1645785610; x=1677321610;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=mudAdqXMqc4msOewE4p+yyZWAmcOkujoS1WyKCFB/IE=;
 b=FD07+CADg9ingyy2g/dAeE6Babvl++QmwTCsGZHNnAvrJxJZg1PvIK7z
 GFqqIBgUQjY/YlNaYaQOH5YwRcHYhSUuy5iEIoZcTFGZeGqBaSrKNVT8U
 0kDf4TSsKlxBlKgsBcakzUkYkn7bNtlw61vdQBg0RHzmuCOcxplrAzOoC A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Feb 2022 02:40:04 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2022 02:40:03 -0800
Received: from hu-rbankapu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 02:39:59 -0800
From: Raghu Bankapur <quic_rbankapu@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, ierre-Louis Bossart
 <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, "Kai
 Vehmanen" <kai.vehmanen@linux.intel.com>, Ranjani Sridharan
 <ranjani.sridharan@linux.intel.com>, Takashi Sakamoto
 <o-takashi@sakamocchi.jp>, Raghu Bankapur <quic_rbankapu@quicinc.com>,
 <alsa-devel@alsa-project.org>, Zubin Mithra <zsm@chromium.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH V0 0/1] ALSA: pcm: fix blocking while loop in 
Date: Fri, 25 Feb 2022 16:09:31 +0530
Message-ID: <cover.1645784757.git.quic_rbankapu@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Mailman-Approved-At: Fri, 25 Feb 2022 14:11:19 +0100
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

When period interrupts are disabled, while loop in snd_pcm_update_hw_ptr0()
results in the machine locking up if runtime->hw_ptr_buffer_jiffies is 0.
Validate runtime->hw_ptr_buffer_jiffies value before while loop to avoid
delta check.


when runtime->hw_ptr_buffer_jiffies is 0 then update of while condition 
hdelta > xrun_threshold will be always true because hdelta will not
change. This will lead to infinite loop causing lock-up

This issue found during stability test, below log explains CPU lock-up on CPU1

[ 922.249028] sched: RT throttling activated for rt_rq ffffffc0f9970778 (cpu 1)
[ 922.249028] potential CPU hogs:
[ 922.249028] **FastCapture (11426)
[ 922.249105] ------------[ cut here ]---------

To fix this lock-up issue, added new condition to check if runtime->
hw_ptr_buffer_jiffies is ZERO or negative.

Raghu Bankapur (1):
  ALSA: pcm: fix blocking while loop in snd_pcm_update_hw_ptr0()

 sound/core/pcm_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.17.1

