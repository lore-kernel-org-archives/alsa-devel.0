Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B392ECAAD3
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Sep 2022 10:51:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 764AE166A;
	Fri,  9 Sep 2022 12:50:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 764AE166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662720692;
	bh=lUmDMhiF8lwwv2lKAciOsvwyDyYY7c9q5moMPEB33mg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vgzq8JtaiEbkZDCC3XT5Nsb1qy3wbo9w6i2JQx55u1NTS5tcHge9ynDMUc1989Aj7
	 3pjxQBKt4sv8f3KBpxmQzw2azaez1jF5Z6oK6YmgPqm1VW9ZTV/lqood0mNbmkYghZ
	 FCLiMgk+EDxdW2SPI67xi5qM5m6mie0976QJeR3g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 078D5F8016D;
	Fri,  9 Sep 2022 12:50:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0D07F8023A; Fri,  9 Sep 2022 12:50:39 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2ADDBF8016C
 for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2022 12:50:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2ADDBF8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="YvwYAveu"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2896qFBf009110;
 Fri, 9 Sep 2022 05:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=wwd6UnFJ7T4llYdZ8VQvB3ojTi24MgDoWfc6lbC7Jk0=;
 b=YvwYAveuvw93cgOueUwhcOA8wUNKNrMWlx5a5iQ9aizi7kXdLYN98tNXu76E5WSjDNxO
 WxM1tHxkN1jCgaM1b1MfCXI5lScxHSnY9xY0w40FZ3DBJVBIWQUn0nIZqlCdleAqsWPH
 sDLudUQ58ze+B/Wt38B0pZgGIWC8JQccAZlj0SX1/G/fm71yd89PrGY60tGPzk8s5zsJ
 4x3EUvfRkG3oTnsCPTmKYXVgBGQbeMNTysOcCEoBZGxvf0LxMo4sm1oU5H5tMukFMJN5
 UULtgm7hWaEIcFYH0qPoOKTgCx+Lj+noRb6ElvY85WyxVg8vIP6drdYAh4t4zA/UZGzX TQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3jc3bq0uus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Sep 2022 05:50:30 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Fri, 9 Sep
 2022 05:50:29 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Fri, 9 Sep 2022 05:50:29 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 62BB9B16;
 Fri,  9 Sep 2022 10:50:29 +0000 (UTC)
Date: Fri, 9 Sep 2022 10:50:29 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: hdmi-codec.c: use devm_kzalloc() for DMA data
Message-ID: <20220909105029.GQ92394@ediswmail.ad.cirrus.com>
References: <874jxhmjgw.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <874jxhmjgw.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: Q3OjWEcahQeOw2TRMc2dWnONKeAJMuR1
X-Proofpoint-ORIG-GUID: Q3OjWEcahQeOw2TRMc2dWnONKeAJMuR1
X-Proofpoint-Spam-Reason: safe
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Chao Song <chao.song@intel.com>,
 Dmitry Osipenko <digetx@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

On Fri, Sep 09, 2022 at 01:20:48AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> hdmi-codec.c is using kzalloc(), but we can replace it to
> devm_kzalloc() and then, we can remove .remove callback.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
