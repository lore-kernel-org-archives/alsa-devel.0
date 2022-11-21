Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5A1C433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Nov 2022 09:37:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C84882A;
	Mon, 21 Nov 2022 10:36:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C84882A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669023456;
	bh=bLIGByXePKoPtMWF2qoUk2tXIaCGVkpMLOdG3CUfGTc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TlDiDsW0JkXBTZorYEpYLZjcnM1XjgVxU/4seAs4m/Z8yj8MGHQ6O9rK73sX02SU5
	 Yc31A/Il7q0Nv1IMWj/S5sq5yTdfmdKMUPHAGbGtjQSzAhu2XGjs2siaiukZpoiOi1
	 tYmHh62MiipBCxR53xgEOCHl3ofZy5Ref9z+VaVA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08F15F80149;
	Mon, 21 Nov 2022 10:36:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0479F8028D; Mon, 21 Nov 2022 10:36:43 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EEA0EF80115
 for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2022 10:36:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EEA0EF80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="oeZVoSkI"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AL6EGQP024298; Mon, 21 Nov 2022 03:36:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=vJtrEG1tZuP8PfCKCkZyOu+TqHYtGdDJLaES+hazCrM=;
 b=oeZVoSkI4z4PdW2BCSL17gikaTAfwzlOzfl2eaw6irCAJzAxxvSodcqEBF/oh2Ivp9z+
 24CT6Aedng6eb5VcGJ+Fo0OSzhxNPLRhVBADPBryFqo7b3Ddn01TY4QrVKLWUETgaRii
 738giS8BrwRpM1OqPHZ1AeM+IPPyOZN4wwqfFUxJh9Xm5hpKc4b6NgUIvSrjCqwo8ifw
 SClIJISPlmnaQBmfkChQhLDhzVvQbJ/TTe03nML5wCQFmTg+t6MpH9YcD6UrHKyQXOwe
 X4hNIuyuD+TtVdpz5HafnUQ7y2byJcKwF9Tfn1xafBxJG/or4cR7yi6LPA2RufnsUrfy aw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kxwe6sy24-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Nov 2022 03:36:34 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Mon, 21 Nov
 2022 03:36:32 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Mon, 21 Nov 2022 03:36:32 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0D1C0468;
 Mon, 21 Nov 2022 09:36:32 +0000 (UTC)
Date: Mon, 21 Nov 2022 09:36:32 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH 437/606] mfd: madera-i2c: Convert to i2c's .probe_new()
Message-ID: <20221121093632.GP10437@ediswmail.ad.cirrus.com>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-438-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118224540.619276-438-uwe@kleine-koenig.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: m-N3Pl3_ce8S7612jcAzYa7QHZk8qmjP
X-Proofpoint-GUID: m-N3Pl3_ce8S7612jcAzYa7QHZk8qmjP
X-Proofpoint-Spam-Reason: safe
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 Lee Jones <lee@kernel.org>, Richard Fitzgerald <rf@opensource.cirrus.com>,
 linux-kernel@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
 Angel Iglesias <ang.iglesiasg@gmail.com>, linux-i2c@vger.kernel.org,
 kernel@pengutronix.de,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 Grant Likely <grant.likely@linaro.org>, Lee Jones <lee.jones@linaro.org>
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

On Fri, Nov 18, 2022 at 11:42:51PM +0100, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> .probe_new() doesn't get the i2c_device_id * parameter, so determine
> that explicitly in the probe function.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
