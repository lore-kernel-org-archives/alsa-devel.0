Return-Path: <SRS0=P760=IL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B9FC433E0
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Mar 2021 11:36:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2917064ECB
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Mar 2021 11:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2917064ECB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28822186B;
	Sat, 13 Mar 2021 12:35:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28822186B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615635366;
	bh=5IEfWpDox5/sxM9POThTh/jy/jtxdogjwfElKoxWlOU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UDmMEjzlu0mo60SgOqvofSQVuISkEdOZb4UJaDChko16VJjNyKabGyswFMgAO78ER
	 Ow92gLxc706ySRdG163WkQFNoU17Bex4/1s3F5W2aZJWyGsp0czS6HmPkRW40Qlk8q
	 KaaZkdkzf5YW7vkjkUlLvrduzg+Tr372Z4WNZzIY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1101DF802E2;
	Sat, 13 Mar 2021 12:34:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5480AF8028B; Sat, 13 Mar 2021 12:34:22 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BBEFEF80227
 for <alsa-devel@alsa-project.org>; Sat, 13 Mar 2021 12:34:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBEFEF80227
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="hidrVS7F"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12DBXKDj024838; Sat, 13 Mar 2021 05:34:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=7hx+MtkVI3AK3n86Hd9S0sFsoKCZzlL3dcqAqyanKP0=;
 b=hidrVS7Fvc8F+f66gYNO0JDozGgi6XlBzv+8YnfnCEfYifSGaEd9v6HZERbkeRkHN17x
 iRMah7GZogcnv0ftFq+bEG1Aw80LgIM9EJFKeR4Wtf0KQVCzLTqngAu/iiAa7POuzzkf
 FgaQXrA00YkzrEnP8Yuoqhw56UowM+9OsQfhdArZ4dA9Y+CuIS1yL3IZAV0poNNLSzDL
 tXJUJme5eix+oIpWiZNl2fkE62D5VDE3LwrwDITl5gPCzNoxJts4q9F6oI2nJV5yPUKf
 EMNZCGZvBv9soM9a/0UNS+zUoPzfXnyAty9Y/JbiTcyNAU5QmztbYrqGWQyuu7aRD3sa rA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 378up782ka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Sat, 13 Mar 2021 05:34:12 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 13 Mar
 2021 11:34:10 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sat, 13 Mar 2021 11:34:10 +0000
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.45])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3ABDB11D6;
 Sat, 13 Mar 2021 11:34:10 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 0/4] ALSA: hda/cirrus: Make CS8409 driver more generic by
 using fixups
Date: Sat, 13 Mar 2021 11:34:06 +0000
Message-ID: <20210313113410.90088-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxlogscore=498 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103130084
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
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

This series of patches will address comments by Pierre-Louis Bossart,
cleans up patch_cirrus.c source, reducing checkpatch.pl warnings from 19 to 0,
fixing an issue reported by Canonical: BugLink: https://bugs.launchpad.net/bugs/1918378,
and makes the CS8409 patch more generic by using fixups.

Stefan Binding (4):
  ALSA: hda/cirrus: Add error handling into CS8409 I2C functions
  ALSA: hda/cirrus: Cleanup patch_cirrus.c code.
  ALSA: hda/cirrus: Fix CS42L42 Headset Mic volume control name
  ALSA: hda/cirrus: Make CS8409 driver more generic by using fixups.

 sound/pci/hda/patch_cirrus.c | 506 ++++++++++++++++-------------------
 1 file changed, 228 insertions(+), 278 deletions(-)

-- 
2.25.1

