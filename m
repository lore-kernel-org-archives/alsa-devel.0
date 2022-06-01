Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD42CC433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jun 2022 19:48:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2EE8A16FA;
	Wed,  1 Jun 2022 21:47:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2EE8A16FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654112911;
	bh=ib5pzAGnPK+jTLf7OnMaQjZFhvd6esBlNJlscVhq9ek=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MSYtd84Zd60ieq5bKyTbRw5Iaab8578Ah/2PRvd95a2Leu6DzwSEpbCxd52BWf8QY
	 lqlvNapCu+EQc4VNyUWNxtkP3/sguhi9FIJzplqKLhsne34cX5zRXYNiRtsgfS4VEF
	 B4IWFWTt6YzgH2fzF3yO/XA0E8pg4MgTHJO5UeGA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA5F5F80149;
	Wed,  1 Jun 2022 21:47:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5223BF8025A; Wed,  1 Jun 2022 21:47:39 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5CEA9F800BD
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2022 21:47:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5CEA9F800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="MbT4qBeU"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251GD6D0018026;
 Wed, 1 Jun 2022 14:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=ymwJqyNipN5Q/+6v3BPxPTrBW4cB2OAjXCqHfLwe68c=;
 b=MbT4qBeULVD+J9bwqSYtLc0QwOoRutYl1WcTy9r1taCyCO4fk4HfWJ/E5FJeoD+9KYqJ
 Xtrqs6v2PSy10+rZ0aoKxEgrJcORlfA4/jH7IoI4tAFDM1eGquvO86KHrowfnLKtWe/r
 tt2NSNdRx1RkFyFKR3tzp/8GruDFebCZ5dkC4dDaWoK3IkutBnf4Hhr6pVNbGzbVyyZw
 EqpivHqalIlalNfvhdfUJT+2oyzgvrz2TiDhanJLkXFG60bwIYFQ6JgYIJ98g37LwKBO
 E6hJYUlJmhbjY5mbsMkEhNLz7RF7S1V7NEapNkjSmpWWZUwvUNaVt5a765jZHqLWmABW MA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gbg5nmqv9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 01 Jun 2022 14:47:31 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 1 Jun
 2022 20:47:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Wed, 1 Jun 2022 20:47:30 +0100
Received: from [141.131.206.39] (david-linux.ad.cirrus.com [141.131.206.39])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E23CA459;
 Wed,  1 Jun 2022 19:47:28 +0000 (UTC)
Message-ID: <1cd55249-d793-9bb9-e01d-b994676f0253@cirrus.com>
Date: Wed, 1 Jun 2022 14:47:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Semantics for _SX controls
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Tan_Nay=c4=b1r?=
 <tannayir@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@codeaurora.org>, Richard Fitzgerald
 <rf@opensource.cirrus.com>, Lucas Tanure <tanureal@opensource.cirrus.com>,
 James Schulman <james.schulman@cirrus.com>, Charles Keepax
 <ckeepax@opensource.cirrus.com>
References: <YpeElAslQxfajbdq@sirena.org.uk>
From: David Rhodes <david.rhodes@cirrus.com>
In-Reply-To: <YpeElAslQxfajbdq@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MppotlWYpQ9YYDYyZ7-0YsQa1zEgp3sn
X-Proofpoint-GUID: MppotlWYpQ9YYDYyZ7-0YsQa1zEgp3sn
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org
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

On 6/1/22 10:24, Mark Brown wrote:
> For the Cirrus case 34198710f55b5f ("ASoC: Add info callback for
> SX_TLV controls") says that the intended semantic is
> 
>      Currently every CODEC implementing these controls specifies the minimum
>      as the non-zero value for the minimum and the maximum as the number of
>      gain settings available.
> 
> which was from Charles at Cirrus so hopefully that's the semantic
> used by Cirrus drivers.

The Cirrus parts have volume fields with a signed value. Typically this 
is a large negative attenuation and a smaller amount of gain (-102dB / 
+12dB for example). The goal for the control is to map this to a 
continuous range and in a way that understands the signed bit field.

 From my review, all of the Cirrus drivers are providing the minimum and 
number of gain settings to SOC_SINGLE_SX_TLV as Charles described, with 
the exception of cs53l30. The cs53l30 driver uses the minimum (negative) 
and maximum (positive) values of the bit field.

At the very least, cs53l30 should be patched. For the other drivers, 
using a macro that is more explicit about the signed bit field and 
removes the max/#-steps confusion would be an improvement. Something 
similar to SOC_DOUBLE_R_S_TLV could work.

Thanks,
David
