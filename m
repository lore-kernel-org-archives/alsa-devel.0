Return-Path: <SRS0=I3pN=QD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C56AC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 16:27:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D51961B62
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 16:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D51961B62
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC6F8169B;
	Tue, 16 Nov 2021 17:27:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC6F8169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637080075;
	bh=eyvU1La7rU7h064EKucefMzgBNXdEOy+VDfwD9s0ze8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oej8oGiAtlwNzIfo1eXVILd8sDoHbuW8Deqhi7415DnRlBLZTTxn94FcwWZb3gmMW
	 Oe0N2A17tq88jtFENg2TRe9UAAHfAzabOP59vddnBI2LdFYNwyMW9XD9iIVM+eeQew
	 OqE7pp0FA2i7RtabEL7hmfiAmafckEp9HZkJAfsQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1884CF804C1;
	Tue, 16 Nov 2021 17:27:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46430F804C1; Tue, 16 Nov 2021 17:27:03 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DEDAF80134
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 17:26:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DEDAF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="MEK3zZWV"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AG7FCkd005416;
 Tue, 16 Nov 2021 10:26:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=ODxpdqxltOMoYVFmvaxZez5QOWprLDG9j92jnhb+qXc=;
 b=MEK3zZWVax6o8sttcNnwHIW+/pS3QB3GJeX4AbtA6bp6FBGe1ocesL9NVrBmaCdzdNH/
 bcqeOWWB30nA7UNmbAX/mOqe91g2/JGn71umRCxb3ZlwXMiYmqlhD5TZsws/KfgYpnvA
 UPav/XPA6HTxIFEbxn3o+iKEI4WoTXaYlIovBATMR7M4wAFryKP4pvh5dUBwJJkjBW2u
 yo7+xR5RmoNf3+KizX1UmGzBrXbHlpFNaZckLdnF783gQjtqBC9quuxqs9KkQfmOS5z/
 EmNPsWE6uF3iIgHZA4+otUSs2stR88O8aJS2uZYJ74iAOY+nn0gdTCxX9jGmm0A2LttO 0A== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cbdjgt3be-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 16 Nov 2021 10:26:57 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 16:26:56 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Tue, 16 Nov 2021 16:26:56 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com
 [198.61.65.41])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4360B11DB;
 Tue, 16 Nov 2021 16:26:55 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 0/4] ASoC: cs42l42: Remove redundant code
Date: Tue, 16 Nov 2021 16:26:44 +0000
Message-ID: <20211116162652.45225-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4YKL-Z3b2k61w_ouTLLQ7mYiZSB_zG0V
X-Proofpoint-GUID: 4YKL-Z3b2k61w_ouTLLQ7mYiZSB_zG0V
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>, linux-kernel@vger.kernel.org
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

- Remove field writes in regmap_update_bits() calls where the code
  intends that the field value is not changed.

- Remove unnecessary complexity from reporting jack unplug event

- Remove a PLL config value member that was introduced in a bugfix
  but made redundant by a later bugfix.

Richard Fitzgerald (4):
  ASoC: cs42l42: Remove redundant writes to DETECT_MODE
  ASoC: cs42l42: Remove redundant writes to RS_PLUG/RS_UNPLUG masks
  ASoC: cs42l42: Simplify reporting of jack unplug
  ASoC: cs42l42: Remove redundant pll_divout member

 sound/soc/codecs/cs42l42.c | 42 +++++++-----------------------------------
 sound/soc/codecs/cs42l42.h |  1 -
 2 files changed, 7 insertions(+), 36 deletions(-)

-- 
2.11.0

