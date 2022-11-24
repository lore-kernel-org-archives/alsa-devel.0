Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAE3C433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Nov 2022 11:08:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C41416E6;
	Thu, 24 Nov 2022 12:08:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C41416E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669288130;
	bh=xG7a/jFIg82EsQ9mAYo5vxtEJ6PLCRZWWld4TCDkHds=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qhYh/HWeDye6mHZ5bJSJtvrH4VTpxXdZ4lMPUpFEqGczHJlCSwOtpAUVAierf1k96
	 kA9d44AGcdMc3tJN4LwyURUs9PxnXMJc9TDS09regDimXhV83+Maem0CDOtaJt6iuf
	 LV+mW4VyWgR/+MDuDQKM0nH5LhP/BOCD/J3OOJp4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EFB3F8047D;
	Thu, 24 Nov 2022 12:07:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0A6BF8014E; Thu, 24 Nov 2022 12:07:35 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6CA46F8014E
 for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2022 12:07:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6CA46F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="bgeqD+L5"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AO7sBmh004512; Thu, 24 Nov 2022 05:07:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=HBrqoakNDPs3AB2EWn6R+jG1ozJq4nshKcy70uojhuc=;
 b=bgeqD+L5GhyLZ8VKJyOE6bD3tqBBKAVh64rH+jw3MukhmXnWpZVccafR6ACs4Bc1Mc66
 9hStJsdtgI7jjyaTgt8WgMH2j7uZOJf54hJozmIFN2girYSecLBZUOWmQqlL41nVpRVV
 qdEAe37+TR9/gQpfaTPV2xQvcU9X8xDLUagbrwAMl4MQR6J/616kMc0Hsydp+4p70526
 z67MfQnV/eHV5tLwtCVZlN2heJ/2AI5n9xgVFJ1aEUE2JFTz+e3yiLOytNbHJo0BVqBW
 qiL4VTsNOvw9H0Jr/vnEzUluJRCanaOsQshSV+YeDCaVS5BFU4LdNFKaNfym3TNpkuxp Hg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kxwe6x2dt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Nov 2022 05:07:24 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 24 Nov
 2022 05:07:22 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via
 Frontend Transport; Thu, 24 Nov 2022 05:07:22 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 496182BA;
 Thu, 24 Nov 2022 11:07:22 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Hans
 de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 0/2] Use ACPI_COMPANION macro to obtain acpi_device in
 cs35l41_hda
Date: Thu, 24 Nov 2022 11:07:16 +0000
Message-ID: <20221124110718.3925934-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: icymHGFSQCP9vNta4tdh6ta5bAP9P2DX
X-Proofpoint-GUID: icymHGFSQCP9vNta4tdh6ta5bAP9P2DX
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Stefan Binding <sbinding@opensource.cirrus.com>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
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

Currently, in cs35l41_hda driver, we use acpi_dev_get_first_match_dev to obtain
the acpi_device used to obtain the properties and gpios.

It is better to use the ACPI_COMPANION macro to do this, since it guarentees
that we get the correct acpi_device for the device.

However, the cs35l41_hda driver uses the serial-multi-instantiate driver to
enumerate, and whilst the ACPI_CONPANION macro works with spi, it does not work
with i2c. This is fixed by setting the fwnode for i2c.

Stefan Binding (2):
  platform/x86: serial-multi-instantiate: Set fwnode for i2c
  ALSA: hda: cs35l41: Use ACPI_COMPANION to read acpi properties

 .../platform/x86/serial-multi-instantiate.c   |  1 +
 sound/pci/hda/cs35l41_hda.c                   | 50 ++++++++-----------
 2 files changed, 22 insertions(+), 29 deletions(-)

-- 
2.34.1

