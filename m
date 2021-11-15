Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA9FC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 12:43:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24C661A4E
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 12:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F24C661A4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3B311616;
	Mon, 15 Nov 2021 13:42:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3B311616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636980222;
	bh=KcAaUhd3vsorFwttU/WfSwRyEQwy21iqgIsPl680jtI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IGGfcXr+jIkzYwZStj6muMuX6Zy9q/+VEMcPZu9KbYVzF9J29FgqLeohlC+7waaNA
	 zQuquXMztOXa+UjoSxDxLdUOondc36LQnaTMNcSGvlGxZmp09usy0dymHiWpffndIt
	 0xZclro89f+ph+/ORn8uTuwCMBM5Iyss7dSlgGPA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D72CF80163;
	Mon, 15 Nov 2021 13:42:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6902BF801D5; Mon, 15 Nov 2021 13:42:51 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6008AF80134
 for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2021 13:42:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6008AF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="CrmwxIug"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AF7YtLX004622;
 Mon, 15 Nov 2021 06:42:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=klCpXSSZcIP5qBOiDyPDjx6ZzQvL5Ruf69JbD5uSlcw=;
 b=CrmwxIugYy3JUdEJryW5OK094USS//eBpgLXWFVRa8SU+qDZ0s/wllTZG8DSQRbXAJsW
 5wu+b3w5p3io6keKqo2gfDJhOA+dKGSydntwrMA+pbC9ooR9UqbOz/HrXtAOSxxw2J4L
 jqm++FqwTEP6vTtDzBAfcAKBSRTJw5rOrxHSYOPNeYG2EpYVuMx/aq5yZ6vNtS7l/2qY
 kxplvsOgQF9nPrtxpbt7T2EaL6aIidzE6v5Q9xcRteKW9CN6VwS2DPUNSGSrbGmJf5rs
 04wzKBtBQqr3kptsoFcLV7fE8KeHhPrmfCgkn8ZdNFFFb40SXOJU/7rqLcYwwCY1YlHY gg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cbjn009at-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 15 Nov 2021 06:42:42 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 15 Nov
 2021 12:42:40 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Mon, 15 Nov 2021 12:42:40 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 14F1FB2F;
 Mon, 15 Nov 2021 12:42:39 +0000 (UTC)
Date: Mon, 15 Nov 2021 12:42:39 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Simon Trimmer <simont@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: wm_adsp_control_add() error:
 uninitialized symbol 'ret'
Message-ID: <20211115124239.GA18506@ediswmail.ad.cirrus.com>
References: <20211115120154.56782-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211115120154.56782-1-simont@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: UE8Ucr8CbSSxKgU-vQvkbjP9uMiZu-Qn
X-Proofpoint-ORIG-GUID: UE8Ucr8CbSSxKgU-vQvkbjP9uMiZu-Qn
X-Proofpoint-Spam-Reason: safe
Cc: alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 broonie@kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
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

On Mon, Nov 15, 2021 at 12:01:54PM +0000, Simon Trimmer wrote:
> This patch fixes the static analysis warning as it is correctly
> indicating a possible code path, it cannot know that for the affected
> firmware versions subname would always be NULL.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
