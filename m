Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872FCC433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Mar 2022 10:11:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 211EB1758;
	Mon, 28 Mar 2022 12:10:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 211EB1758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648462292;
	bh=GfziH5euoTiG32o7TeMJeesuxOzB3ocLRxMTx0bUmA4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=moIoRr4sc1j7vxsIzvd4RCeBM77+szkHa6/QgaIfYad4BbxyJoltAUq/muViWkNpk
	 yJhWJ129ZUelVuCfcgMC3A6WhNxR+fsEHd+qcSqUT+ph1w5iF58Yhc/Ykno4KfOqtG
	 8qDXZeBH5yvw35Ure02UhRk4ciIt8I06Pfto3v9E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95A85F80128;
	Mon, 28 Mar 2022 12:10:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A1F81F8024C; Mon, 28 Mar 2022 12:10:39 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44189F800FA
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2022 12:10:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44189F800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="cjtdQSQf"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22S8Awi9030875;
 Mon, 28 Mar 2022 05:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=3Yj5wc1CGFrOvGDoDuyTtaG0DrAsWSA5baIPoF+vTbQ=;
 b=cjtdQSQfKzKmkb98VEJ8a9A4MRQ2tEQDOb8tcB4Fmi2dWJZgCwZ77tihC0mMHLhqaEmB
 ma0ABIYxPcvuoVJgSixsfNnAGX/uEEZ+GXVcShzXdjhJ/3i+k5eby0e+6yTDtcOsrMrv
 swDKj1bgsM/QBFaBk1GxtzhEzRd9PECBldePQSlAHV5DxfPUov0Y7i7VW2v9QjdhkfzT
 bx0o2AJLl4bXlaCw+jc8yeUgd1ATEz4n5BlmURY4oQ3O5YjFg5Q/Rb0nvMsnhOHn/IXq
 a6/uagB1zo+Wvh7KyZv5OZQB3jSJAO0P9YKxvRMmyjhe+Mew9ZG6LQ4OyYxZbq0jTgXt SQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f2081ah0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 28 Mar 2022 05:10:31 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 11:10:29 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via
 Frontend Transport; Mon, 28 Mar 2022 11:10:29 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E8D44B16;
 Mon, 28 Mar 2022 10:10:28 +0000 (UTC)
Date: Mon, 28 Mar 2022 10:10:28 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 5/7] ASoC: wm8731: Factor out the I2C and SPI bus code
 into separate modules
Message-ID: <20220328101028.GD38351@ediswmail.ad.cirrus.com>
References: <20220325153121.1598494-1-broonie@kernel.org>
 <20220325153121.1598494-6-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220325153121.1598494-6-broonie@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: o6QMduhp7viwv4D6yovhD2cJLvhFMeRz
X-Proofpoint-GUID: o6QMduhp7viwv4D6yovhD2cJLvhFMeRz
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>
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

On Fri, Mar 25, 2022 at 03:31:19PM +0000, Mark Brown wrote:
> Placing both the I2C and SPI code in the same module causes problems with
> mixes of modular and non-modular builds of the buses so it's generally bad
> practice. As with other drivers split the bus code out of the WM8731 driver
> into separate modules.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
