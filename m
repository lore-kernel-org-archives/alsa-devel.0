Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80079C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Feb 2022 13:03:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D71FF1684;
	Mon, 21 Feb 2022 14:02:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D71FF1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645448628;
	bh=pp1RnX80CFNJtRZqQ4apT6ENk8EH8JwTfexSTSBTXK0=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cYJVhNnfUWOlgt8+pkp2JeaMBU7SNsjpE1TKgVCWI7iahTN5+/Qi/xKELp8/xguqS
	 lrXG/wAb0juapkMKWnsaYmks/iDHHtZ5EmXeekgeSry9Ls3Kt9a/q0/Io3DzyhLi7Y
	 t6lsQmdq/QI0SPjaIP8NwwKIceD0J5rmxyDmjVV8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C749F80139;
	Mon, 21 Feb 2022 14:02:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4824FF800FA; Mon, 21 Feb 2022 14:02:55 +0100 (CET)
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com
 [199.106.114.38])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F143AF800FA
 for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2022 14:02:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F143AF800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="GX/tCmpf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1645448573; x=1676984573;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KZx0AC6N1KetqJgjIGPHT+c6fRZkwXmMUhQ/6zLIsZ0=;
 b=GX/tCmpfM/SE7L5SY0scQ4HB0ew8HbsIvH3A5sa3HLsVE7wMgG4ff6C7
 uDhpwq/W0w6m+xOzmmsDDon+vcxWY4FK99PkRJ4pCUFu8TLjIF/EuoBB+
 MWamyCrNp4V4ggDrFi+98zaNgyGmbSVK3IKLux5am6JLMUFL8TEtFUzdY c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Feb 2022 05:02:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2022 05:02:47 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 21 Feb 2022 05:02:47 -0800
Received: from [10.216.15.213] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 21 Feb
 2022 05:02:44 -0800
Message-ID: <58726955-9682-15fc-56c7-cf504ef4d3e9@quicinc.com>
Date: Mon, 21 Feb 2022 18:32:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/3] soundwire: qcom: add pm runtime support
Content-Language: en-US
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 <robh+dt@kernel.org>, <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>
References: <20220221104127.15670-1-srinivas.kandagatla@linaro.org>
From: "Srinivasa Rao Mandadapu (Temp)" <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <20220221104127.15670-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org
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

Thanks Srini for Your patches!!!

I think runtime pm support in bolero codecs side still pending right?


On 2/21/2022 4:11 PM, Srinivas Kandagatla wrote:
> This patchset adds pm runtime support to Qualcomm SounWire Controller using
> SoundWire Clock Stop and Wake up using Headset events on supported instances and
> a bus reset on instances that require full reset.
>
>
> Tested it on SM8250 MTP and Dragon Board DB845c
>
> --srini
>
>
> Srinivas Kandagatla (3):
>    soundwire: qcom: add runtime pm support
>    dt-bindings: soundwire: qcom: document optional wake irq
>    soundwire: qcom: add wake up interrupt support
>
>   .../bindings/soundwire/qcom,sdw.txt           |   2 +-
>   drivers/soundwire/qcom.c                      | 215 +++++++++++++++++-
>   2 files changed, 215 insertions(+), 2 deletions(-)
>
