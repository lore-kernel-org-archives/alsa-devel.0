Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD4FC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 12:44:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C734661A38
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 12:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C734661A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2979716AC;
	Mon, 15 Nov 2021 13:43:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2979716AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636980267;
	bh=xBU9M5zvSzPvUWKsbscg+uN4oQE7vFN7ga2bHvEGUUs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KYhlFgLAYvUgIqN0ljRsadvAuX9ixz2XjFNhwm/8TqtKDQr6g9hSKZhaj2rm+0wLj
	 8iIkW8qH/qfweuExA35uuqYKnse5fDH3PBOk8GkT02oOTbvwItieXpYLe+/Rhp3PZv
	 mqgnrcc3+5ZQl6PQ1thRowEDl2tIxM3BqtKnZQNk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B5AAF8028B;
	Mon, 15 Nov 2021 13:43:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D78EF802A0; Mon, 15 Nov 2021 13:43:05 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0142AF80134
 for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2021 13:42:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0142AF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="hUq6LzPo"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AFBu7JO030566;
 Mon, 15 Nov 2021 06:42:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=TbN+T5UbW/pTZkZG+D5XfPYWd0dn7t2lMCwb7Cp5rjk=;
 b=hUq6LzPoRIb7mIw5aTUt6/FzmVTc6U1ltCNPAdXwz1D/TQz9QytVAfADDHtgCirwHmAW
 qTFBGWazzZbQSXNYDXvKFXxzZ/fMuLXEzdL3gquzvEidoW+A2MjD029Za78f9OsNxTih
 ErscuKc8st63gdnFxHKPZVLUHF8j9+O4L5/YTr6lS7c+eOFhqlA2sgN0bEUeV+Ae7LsT
 3SSREYkNV/htiMLu+air3tOpBjXqT3pthve0wOEn4S0tDJcjKeQ4cfIJUiJvz9lo7sNc
 XNL87Iw1go2D+rkLq2J4nGLHKzii4S3dpqdoQg5MsZvnofd6WInSa8gX+QfxF3On4DpN Lw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cbdjgrgk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 15 Nov 2021 06:42:54 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 15 Nov
 2021 12:42:53 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Mon, 15 Nov 2021 12:42:53 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E7F7811DC;
 Mon, 15 Nov 2021 12:42:52 +0000 (UTC)
Date: Mon, 15 Nov 2021 12:42:52 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Simon Trimmer <simont@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cs_dsp: tidy includes in cs_dsp.c and cs_dsp.h
Message-ID: <20211115124252.GB18506@ediswmail.ad.cirrus.com>
References: <20211115120215.56824-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211115120215.56824-1-simont@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: hmLB5-5mIBc3XMAvWS7Suut0HITb8a46
X-Proofpoint-GUID: hmLB5-5mIBc3XMAvWS7Suut0HITb8a46
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 broonie@kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Nov 15, 2021 at 12:02:15PM +0000, Simon Trimmer wrote:
> This patch removes unused included header files and moves others into
> cs_dsp.h to ensure that types referenced in the header file are properly
> described to prevent compiler warnings.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
