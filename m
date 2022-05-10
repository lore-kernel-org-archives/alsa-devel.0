Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884FBC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 10 May 2022 08:55:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12F9F17A0;
	Tue, 10 May 2022 10:54:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12F9F17A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652172906;
	bh=VCIZVp0E/w2ivGu5KAp0ntv0ctCA2zRE8+GGQKtAJgg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GWhmPRGQz/HXt+cjQIRPBakbnbGE3pTL+se2fBOuL2VK3Ix25JXNZ4amc+aC49AZX
	 A7EVnjIRAYsIymUGpFxegeTvjYXXiRRAr3j9j/KPEDlFOeqFk28AylFgW04xRZSb6m
	 AC0G6R1t+NOouT4QNZv2+n7JGaPJ/dzH3tt3Y034=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1683F8011C;
	Tue, 10 May 2022 10:54:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33FD9F804BB; Tue, 10 May 2022 10:54:14 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5FE1F8011C
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2022 10:54:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5FE1F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="E5isWg4x"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24A6NhvH002472;
 Tue, 10 May 2022 03:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=0YkFFAz887Qm36gFThwOEYzoNDPgmPh1ObjkpzKkRGE=;
 b=E5isWg4x8DGylbBvtUyN+Aw2MVPaBnNcVwmHjp0eR/QgV9m0+S6n1SVzyvO2j0F95eSG
 fPO5K3f8QaQ9C53DNn5KM7hKW3qhPUYV/pwBduSZUQmoVms2EbBQY5mpJ4SJcLAcn/iC
 vWEQkbaFtoCDmxIVEFpu/tD2kJNf/BXBuCqswC63J6cAja/err6oy9y2b251Hut0FRog
 VEbwKT85X6zt88BXWUTtPx+RbvhgoMluokZJ/3/aH7frHVKOe1T9zqTEa1oFZazzU3p7
 XxveFnbI+wiKAwDnnZcX4oQeEI1HMsSOiqMl9XY3BUbyAmKGtW/dWNVoIXXHnr6pynIj Uw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fwp6146ug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 10 May 2022 03:54:03 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 09:54:01 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via
 Frontend Transport; Tue, 10 May 2022 09:54:01 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 44880475;
 Tue, 10 May 2022 08:54:01 +0000 (UTC)
Date: Tue, 10 May 2022 08:54:01 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: Re: [PATCH v2 19/26] ASoC: cs35l41: Do not print error when waking
 from hibernation
Message-ID: <20220510085401.GB38351@ediswmail.ad.cirrus.com>
References: <20220509214703.4482-1-vitalyr@opensource.cirrus.com>
 <20220509214703.4482-20-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220509214703.4482-20-vitalyr@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: mxY978Zt_bkbu9WweFSSDiwAbC-m8WZp
X-Proofpoint-ORIG-GUID: mxY978Zt_bkbu9WweFSSDiwAbC-m8WZp
X-Proofpoint-Spam-Reason: safe
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Stefan Binding <sbinding@opensource.cirrus.com>,
 Mark Brown <broonie@kernel.org>
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

On Mon, May 09, 2022 at 10:46:56PM +0100, Vitaly Rodionov wrote:
> From: Stefan Binding <sbinding@opensource.cirrus.com>
> 
> When waking from hibernation, it is possible for the function
> which sends the wake command to fail initially, but after a
> retry it will succeed. There is no need to print an error if
> the initial attempts fail.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
