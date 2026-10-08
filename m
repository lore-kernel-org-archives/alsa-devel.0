Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436A1CA9EC0
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Oct 2026 19:42:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E9C686024D;
	Sat, 10 Oct 2026 21:42:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E9C686024D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791661344;
	bh=BvLG/Sqj/xDDjCJpnlp2ylGcaCRNdXP18h9H5v3PNSg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=anksaw3ESAoAPyim/y6UbNXzEP0ymb2iZfFv9bBjhNcnkCeKJxJjnYF9eI/lHwrRX
	 SUe07H/syFwVbKHzCSyzMyVjvPAMB7IXOuw52UKhjAatLVrsTGUexO2XfXAzkOhWki
	 4PSzhGI3SSQjJ1EWlECXHqhMlmjEiievEAo2sr+Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 77F12F80686; Sat, 10 Oct 2026 21:41:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ED8BBF8068C;
	Sat, 10 Oct 2026 21:41:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08F00F80571; Thu,  8 Oct 2026 14:47:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791463624;
	b=byMzbF10DT1cOgLQfspO3TLS0WxrxFef/lnyFpV/BfBazO+lSLQQdqDMsGRdGE3+EnVY
	 jTU10TPkoihxaRVW3KZRGGlyYXwBeb1MuUBvkA/zH7hoKsers6qrbVYt519ZNw+e/LQ1T
	 cMHCqcYlbkYYAmFYaiQmQfHLGRAlsaFZnGSPtb/FXbOUnmVR9H2fLCc3he80n40xqy3i2
	 mVt/w0lQBqduSKTBQSqgfq+91I6aNf0/91QmekGuDPmWJhOXo7pa5orACynVTtuPTbiFy
	 OGs46UYsOc7qs1qbGotw+PNFb9Z+v1UqPxbeRItHKn8W89q4IV0AbO60EwMJwrBcXYw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791463624;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:
	 To:From;
	bh=BvLG/Sqj/xDDjCJpnlp2ylGcaCRNdXP18h9H5v3PNSg=;
	b=bL1H8w7sFwsQ6q8uZRbWzHx9BIIq8qRi2x4BwFxcmFBX/8MaCoO+e+kp1zZwjVSsFq85
	 9yuKMUxZYj+xqJ4EMHR3sWHlW5bDvv1QSxoPD7HzqhykU4/3Dj53YNqoFTqtMHHaQbBZR
	 iRr8brpp8EOG72Xt+zORbvtUNE6b0n0rW7j4sA/YFfrVT+wbbgev9Iuub/m54GTkoYoGI
	 o4+2HECTbQdKDsum5fQB0PUmk8XGWJf+DXI+cyM8w3R9K7PLPGTcualGmuKfnbvvakpHQ
	 kox9c/RqlH6+oF+t+jS1gj0IXP++lEaiHenuGoqnRyCbmdXCccEU4Om9kdO9HU5UUww==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Eum4qv4G;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="g/qq4JB4";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 36A54F8007E
	for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2026 14:47:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36A54F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Eum4qv4G;
	dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=g/qq4JB4
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698BK7Mf2383952
	for <alsa-devel@alsa-project.org>; Thu, 8 Oct 2026 12:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6/0JMiE5zxmyIy8hgrC4A+8ABRxBbiN2qZjcEtxUs8Y=; b=Eum4qv4GzCYivSWc
	moqokcmj/zMIpcetIIxc5bxQIt35youHg8jzj3JH79Qv07TgHvTbnYqoVhHVFeK0
	YmdwSESAcR9/RvjxoSm+n+LI9yKdN2vHMqeYZ9fXtO0RGDhiZOfXC1UUeLnkrMJz
	VgvxPPWv9E6+f3ZdH/jQL4nGWb0fdStzuz/g3CDgnn7UCFD6R2SFGBdmmv77M7Qh
	MkObH20DKCZ0UXzrz0hBEUUR9sO8VXNf9n5g5GokjtbzhQc7RvRK9axDsx18efkr
	3zGeuE3Emg56qAsNp+NTEj9fXJrVqw/YnOVHZsKpxrZSY1M0tNd/clMQAnCQmMID
	wzaiNg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3k0k4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Thu, 08 Oct 2026 12:47:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a082c014aso260500085a.0
        for <alsa-devel@alsa-project.org>;
 Thu, 08 Oct 2026 05:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791463620; x=1792068420;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6/0JMiE5zxmyIy8hgrC4A+8ABRxBbiN2qZjcEtxUs8Y=;
        b=g/qq4JB4UsfceYk5tntOPxouiU86GKpp+EvKr8VUBnESCcUgn3XzKIseqqOhrFim6v
         D3qFO2B3RJoRJRHd6T6tsUAizYGampF+6+PQZr46Mdxc/FT4Blj6l9GJz8zNITEV/3TR
         0TVD6TNhcv7IRudZs89/KeClmHiLYw6hQIK+GbuS6OZRGhDUNhMFIkpZZeDRqWO4uoCO
         qhqAXW2G/2II1n8UoiSM9P242L8QS6x6KlQ9e/rtjYttckxT/4tuLhs9aAd3cGhHQZDL
         sK6G/yHHGk/mhIaoM5FTbvpuL+kPg6jwPyrFf+6i/H1AIh+TL2dhD5Xgw0l1QfCywOIm
         s3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791463620; x=1792068420;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6/0JMiE5zxmyIy8hgrC4A+8ABRxBbiN2qZjcEtxUs8Y=;
        b=KwgjJa9iTi44LPBgCCk/UEWeubS47/SjLRxo+NV5IzerbJDQU31FMtcBCv5GhOdFfc
         s2JLvtxrv2fVLxT3y4WX+91u6na/ID0y5vFjx371vuFuXl20bsykv1EZqu8EGON6v02j
         LLsRXotsLsUZFmitJdQxbPEWHh6B0/o8lQBkbqEiAJI+H4qJpTX0mm7aKx3365uRPIh9
         c0Z83I/07WYdBSkqwFqSKb9Jd1oub/wE09DdCyIUmDFkY6IMW9uE9cgWcUBnnDICpXWS
         2TvC4SROr8YMkmReKSRwtFDvfZ+Fu4XpqOmQgyhf6U/e9LYNl1CeDD4vYCoSJdj2DP4D
         NnXw==
X-Gm-Message-State: AFuF++lBgE+uoYV4NqsMiKqA/RL4hlrciQAmbtvY3RkNRHP5KtS4dnPs
	YBTE3svhXzqtee2cmM/CpGzCyjjF7BFE2EUo/r+04TwQ2lpphoLQJ4YObUDkCswk1/llj337JR5
	NDWt+BCM9Rj/TSmaGLkizpNiLE+5dE3rHyuJzDMgV2zzaMCsMWZpWknKlodaD95qDKQ==
X-Gm-Gg: AYBFou2uKUA62s1MuW6JdpduzIj67QbKiNpNqjLac17V/IgybUjj45nBks2s0TjForB
	4LQkNwmhlksKtDuVoLHmt9wsfvjh3Rwl0A6Re14LWkdPgXNusN+4FyxUA9r2Y2XEUuqR1fa2y3T
	YNA8gJk3zEg/HLg75X+Q2+VecJYdBhab3iVojprEVrsQIggU+MOy0K1aJrSdnhfKyFhQrqxSvRW
	pKqz9PDZmf+eKjrsE7vjnfbm4l99FM0iDdV9IrAp6Bz7ghtwiX501o/PphgAyUbMc01tnpwc172
	8o7U0XIg3c9thFOgiLp+TOfhAwRb5PjCes7uEnf65VUKu17vN8P6+brIBBh1gd7PMh9U993+Qv/
	30BarpV24EQMqDTfMn4MNZG3aHU2s9QwU0fdFABmDFUln5h86
X-Received: by 2002:a05:620a:4413:b0:93e:64ac:5dfd with SMTP id
 af79cd13be357-93eaacd6540mr407615185a.3.1791463619720;
        Thu, 08 Oct 2026 05:46:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4413:b0:93e:64ac:5dfd with SMTP id
 af79cd13be357-93eaacd6540mr407610185a.3.1791463619033;
        Thu, 08 Oct 2026 05:46:59 -0700 (PDT)
Received: from [192.168.137.143] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c317c32af4fsm214517966b.63.2026.10.08.05.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 05:46:58 -0700 (PDT)
Message-ID: <7678c37d-9f42-4e3e-b054-762688cd8077@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 13:46:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux-audio BoF at Linux Plumbers Conference?
To: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org
References: <871pbsnce8.wl-tiwai@suse.de>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <871pbsnce8.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1MCBTYWx0ZWRfXx8WblCcztXMC
 hfhMZ+K0Qs+BsAqL4AATdM+W8g4cNx/JCCargbzFsntd1qsJWxTVHUbCOzxdJ8mljXvC3Tluxxq
 g2MOPScOAYMoJuPE79mbCo79wodHP7w=
X-Proofpoint-ORIG-GUID: hEbDbGs3muE39Ux_ziA9G2gZ9oX5fICn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1MCBTYWx0ZWRfXxS8qq7SP625I
 IpM5nVEitzyTJ1rQFNZPG/7p2nozZT50Gb3YB4XLaX/2OVReWPYTTiOmvZw82dpdCPyP1b4Jaqn
 g5R9RGz5pjrVYMOr1IIxcMYRC2nkZ8GkUOFNgvOqap8ujO5L7B+rcJTl6MLVCbVHZsx2V+QdBAP
 +p5ak+HPlC7u6YT04Sb5ETsKG2OKWczFRNtmGf7bIOkDE6y3x14/SRC4mxl3w8Xc6DWsScA3GfO
 jXS7RBp99LURWEg8U5I62HD1FF9eC4xsisoGe8u7njUHZ3q9CAaB/6ebneXmLPzn8tg2TcroOjH
 QSWmZb7zSKtIhkjFFcTRokv3ixdpJ//quaaOP6+pDbMrC6yqWEm/tZqgUFF+OHcA8M1t2HMJ6DW
 SHwWpihYrpjNNH2Ij3J2DdarxgdLn+lcA/zFsz3hCQTG1wM25GwXGiAr2+SmCWy1Iz3NWz61ilO
 j6W3fNFvNhAoqOhzaCQ==
X-Authority-Analysis: v=2.4 cv=IIuXmQvG c=1 sm=1 tr=0 ts=6ac790c4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=zRh97aRZNhiOMYVz81Er1w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=lxOuNqB-r1SHsHFSKiAA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: hEbDbGs3muE39Ux_ziA9G2gZ9oX5fICn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080050
X-MailFrom: srinivas.kandagatla@oss.qualcomm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: A3WJLHMYLLSGRGQBW5LLDDE3SWSWBEGP
X-Message-ID-Hash: A3WJLHMYLLSGRGQBW5LLDDE3SWSWBEGP
X-Mailman-Approved-At: Sat, 10 Oct 2026 19:41:03 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/A3WJLHMYLLSGRGQBW5LLDDE3SWSWBEGP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 8/20/26 2:34 PM, Takashi Iwai wrote:
> Hi,
> 
> a few people including Mark and me have talked about holding a small
> meeting for the Linux audio stuff (finally again!) during the next
> Linux Plumbers Conference (on Oct 5-7 at Prague).
> 
> Has anyone already planned to attend there and is interested to join?
> If we have enough people, we can try an official BoF session.
> Otherwise, we can just have an unofficial session at lunch time or
> such, too.  Just let us know.
> 

Thankyou Takashi and Mark for setting up this meeting,

Here is some Meeting Notes, please add if I missed anything.

-SDCA
Discussed gaps in the MIPI SDCA specification for platforms that don't
use ACPI.
Action item: @Srini to engage more actively with MIPI to help shape
future versions of the spec.

-Compressed Offload and End-to-End Testing
Concern raised that compressed audio support gets little or no testing,
since it can currently only be exercised from the command line.
Proposals:
Integrate tinycompress into alsa-lib.
Explore options for supporting compress offload in UCM.
Action item: @vinod or @Jaroslav for merge
	@Jaroslav to look at offload UCM.
	@Srini to look into player support for e2e testing

-Speaker Protection
Brief discussion on whether a standard framework or user-space utilities
exist for performing speaker calibration or applying calibration data.
Action Item:

-ASoC Componentization
Discussed the current status of ASoC componentization.
The work could move faster with extra help; volunteers for development
and testing are welcome.

-Sashiko Reviews
Takashi proposed enabling Sashiko reviews on the sound mailing list.
Everyone agreed, with some changes to the default configuration (e.g.,
cool-off period for responses).

-Quarterly Meetings
Takashi proposed holding a virtual meeting every quarter.
Action item: @Takashi to send invite.

-Next LPC
Agreed that a dedicated Audio BoF at LPC would be beneficial.
Action item: @Srini and @Vinod to set this up.


Thanks,
Srini


> 
> Thanks!
> 
> Takashi
> 

