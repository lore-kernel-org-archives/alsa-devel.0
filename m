Return-Path: <SRS0=4l9v=GP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF8CC433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 17:16:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BFC12311C
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 17:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFC12311C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 769D316B3;
	Tue, 12 Jan 2021 18:15:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 769D316B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610471797;
	bh=F+2fyqM7rmEXS0apHMQgSzWtIt2aybNm6E6eh7ZvFDg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FcarE9N5afANjilMhzG5YmmaqYjhIyMcMtKI/Mt2FrLWVgcvBzRQfwTxWu+NHsqMo
	 vPyTeKeVeYQ64YP9f3eJFitQ8YjtG/5Dqx/2sTcxrGkgp4KCA0YL50kclh91LR0oV0
	 o5CXYGOuIpFNTAdISL5yL0YyA7uaNc2vzHclfd1Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02F25F80249;
	Tue, 12 Jan 2021 18:15:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A53D6F8025E; Tue, 12 Jan 2021 18:15:45 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8031F800B9
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 18:15:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8031F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com
 header.b="Rb6WUJoY"
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10CHCqt0007811
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 12:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=IuO+MqdxINFhV6RKwLi9ZG11Bhv9DITM4qJkav4smBk=;
 b=Rb6WUJoYnfPoHG54X9p3wyi/Af83PzlN8/VVAx2DbO4PhFBn6vCrwlsidVl8Eun71/7v
 lH8OANEWeau6yfrNfOSINxIHDoDSmBgthLIonGFuMNbVxFTJHH8YjYCzj7LUvRMsyTsI
 i3/eoD8WQI5N8g1Kgiiv61/jvqsI5BvB0YSqiR6c7xnrEp0O/GnB2fRs8r+BxdmVggRp
 2uVAhX/O45XhVKa37rCFs6foTiA+WJXViY721WcZEIFmWJP3RJ8wXTczAiu5uKgFlLte
 v+xH9haD84SghJTUgRmrLF89llJeH3F1dNoFy8Iw+SYKkL1Kz1oSUBe0vGpvOnSAJu3S 7g== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 361fyh00e4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 12:15:36 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10CHEvg8076546
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 12:15:35 -0500
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com
 [143.166.148.211])
 by mx0b-00154901.pphosted.com with ESMTP id 361fqr0cng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 12:15:35 -0500
X-LoopCount0: from 10.69.132.19
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.79,341,1602565200"; d="scan'208";a="585223467"
From: Perry Yuan <Perry.Yuan@dell.com>
To: oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
 hdegoede@redhat.com, mgross@linux.intel.com
Subject: [PATCH v3 0/3] Dell hardware privacy implementation for dell laptop
Date: Wed, 13 Jan 2021 01:15:02 +0800
Message-Id: <20210112171502.11452-1-Perry_Yuan@Dell.com>
X-Mailer: git-send-email 2.19.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-12_12:2021-01-12,
 2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120100
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120100
Cc: alsa-devel@alsa-project.org, Mario.Limonciello@dell.com,
 linux-kernel@vger.kernel.org, Perry.Yuan@dell.com, lgirdwood@gmail.com,
 platform-driver-x86@vger.kernel.org, broonie@kernel.org
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

From: Perry Yuan <perry_yuan@dell.com>

Hi All,
This patch set is a new driver for dell mobile platform ,which has the
hardware privacy feature.

For micmute led control, the hotkey is Fn + F4, it is a hardware based
mute state, and new privacy will prevent micphone void input from
hardware layer, any application cannot get voice data when micmute
activated. 

Camera mute use a new hardware design to control the camrea shutter.
When video is muted, no OS application should be functionally able to
capture images of the person/environment in front of the system

Older history:
[1]https://patchwork.kernel.org/project/platform-driver-x86/patch/20201228132855.17544-1-Perry_Yuan@Dell.com/
[2]https://patchwork.kernel.org/project/alsa-devel/patch/20201103125859.8759-1-Perry_Yuan@Dell.com/#23733605
[3]https://www.spinics.net/lists/alsa-devel/msg120537.html
[4]https://github.com/thesofproject/linux/pull/2660


Perry Yuan (3):
  platform/x86: dell-privacy: Add support for Dell hardware privacy
  x86/platform/dell-privacy-wmi: add document for dell privacy driver
  ASoC: rt715:add micmute led state control supports

 .../testing/sysfs-platform-dell-privacy-wmi   |  31 ++
 drivers/platform/x86/Kconfig                  |  17 +
 drivers/platform/x86/Makefile                 |   4 +-
 drivers/platform/x86/dell-laptop.c            |  25 +-
 drivers/platform/x86/dell-privacy-acpi.c      | 167 +++++++++
 drivers/platform/x86/dell-privacy-wmi.c       | 320 ++++++++++++++++++
 drivers/platform/x86/dell-privacy-wmi.h       |  33 ++
 drivers/platform/x86/dell-wmi.c               |  37 +-
 sound/soc/codecs/rt715-sdca.c                 |  16 +
 sound/soc/codecs/rt715-sdca.h                 |   1 +
 sound/soc/codecs/rt715.c                      |  14 +
 sound/soc/codecs/rt715.h                      |   1 +
 12 files changed, 650 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
 create mode 100644 drivers/platform/x86/dell-privacy-acpi.c
 create mode 100644 drivers/platform/x86/dell-privacy-wmi.c
 create mode 100644 drivers/platform/x86/dell-privacy-wmi.h

-- 
2.25.1

