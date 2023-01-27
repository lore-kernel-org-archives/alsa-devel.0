Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA539C38142
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Jan 2023 16:52:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5787AAE9;
	Fri, 27 Jan 2023 17:52:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5787AAE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674838375;
	bh=93e8yg6Y8YTnh7X9R4f7Mpp20YHgB4FJLQ7q6VzMpsM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=qs7N9PH9gGM1+cwM86wFQo8bz/2Acsvb8QhgLGoFJA791AlfpXBhGp/D3lNP+s67v
	 MTmhu5+ORPdmJ6ah4O2+fIx9MLxJX+j5UEC5/9LIUApuu7C2KnAERrR9UMjyVJktEk
	 BMaQKVQZwvlJitRbynIzM99MDnxeJc0d2e2mF2fA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E7D3F8007C;
	Fri, 27 Jan 2023 17:51:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC176F804F3; Fri, 27 Jan 2023 17:51:35 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75D6BF801F7
 for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2023 17:51:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75D6BF801F7
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=nmP4VnrK
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 30R9k8LN030633; Fri, 27 Jan 2023 10:51:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=lY5UIsZ69hx/4gHdwcW0N1VKa4Qb9oFZA+396K23HMk=;
 b=nmP4VnrKi5tWiANdAKVn1dx+iUsTW94X+9EQP7+jCs0ZnPc5pbfgDj4KBx+HSgiG6OTu
 j7gN1EUfjSUYOVNMneCE5FtUWiKL+HHxGdEzED8akj50hwNHCy2h9euxBrXskiItQyIH
 PqdKasikiZp76e6CkR+O84zZw+vKPS7sRFAuC414Si5LIHW3nXzVet3OdtgAgbe+333G
 2+v0Gu6zOHNu9ekEwqipaOgZjYsk2f8rV6sKq7vek08ORq58gYHqIs4Qjz7Tg73Ktd3O
 tOyLwS8JTkUIsL8n6yL6+WGQOrdtNbk5wy0tTm3NiAQN5OXU7RjO5wuiMAhd92cCfGRn 5A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n8dbsvrd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jan 2023 10:51:29 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 27 Jan
 2023 10:51:28 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.7 via Frontend Transport; Fri, 27 Jan 2023 10:51:28 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 34237475;
 Fri, 27 Jan 2023 16:51:28 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 0/8] ASoC: cs42l42: Add SoundWire support
Date: Fri, 27 Jan 2023 16:51:03 +0000
Message-ID: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ld2F_qA2ieOHzm2HVUV8Vbzu6z-BGsLr
X-Proofpoint-GUID: ld2F_qA2ieOHzm2HVUV8Vbzu6z-BGsLr
X-Proofpoint-Spam-Reason: safe
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Stefan Binding <sbinding@opensource.cirrus.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The CS42L42 has a SoundWire interface for control and audio. This
chain of patches adds support for this.

Patches #1 .. #5 split out various changes to the existing code that
are needed for adding Soundwire. These are mostly around clocking and
supporting the separate probe and enumeration stages in SoundWire.

Patches #6 .. #8 actually adds the SoundWire handling.

Changes since v1:
- fixes for various review comments from v1
- add support for wakeup from clock stop using hardware interrupts
- use port_prep callback to prepare/deprepare codec

Changes since v2:
- fix various comments
- enable pm_runtime during probe

Richard Fitzgerald (6):
  ASoC: cs42l42: Add SOFT_RESET_REBOOT register
  ASoC: cs42l42: Ensure MCLKint is a multiple of the sample rate
  ASoC: cs42l42: Separate ASP config from PLL config
  ASoC: cs42l42: Export some functions for SoundWire
  ASoC: cs42l42: Add SoundWire support
  ASoC: cs42l42: Don't set idle_bias_on

Stefan Binding (2):
  soundwire: stream: Add specific prep/deprep commands to port_prep
    callback
  ASoC: cs42l42: Wait for debounce interval after resume

 drivers/soundwire/stream.c     |   4 +-
 include/linux/soundwire/sdw.h  |   8 +-
 include/sound/cs42l42.h        |   5 +
 sound/soc/codecs/Kconfig       |   8 +
 sound/soc/codecs/Makefile      |   2 +
 sound/soc/codecs/cs42l42-sdw.c | 610 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs42l42.c     | 133 ++++---
 sound/soc/codecs/cs42l42.h     |   9 +-
 8 files changed, 729 insertions(+), 50 deletions(-)
 create mode 100644 sound/soc/codecs/cs42l42-sdw.c

-- 
2.34.1

