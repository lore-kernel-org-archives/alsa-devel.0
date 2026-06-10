Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16153CD98C7
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:32:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1F2760243;
	Thu, 11 Jun 2026 21:32:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1F2760243
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781206372;
	bh=x9d1nGjclVZUKeV7iRM5DOu+kaZFIGubeAbIfc3DEcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mgZu33/yPh8soUyDUAUXyz+1IhVYzz7oTP9pNsQ2i1zn9j80iYxwwMqig0O5EmG87
	 qTveYG9hFrHMwq0ue+2LViS+UnZH7tLV1Jaj7DXX/rK0OD83HZsStUAH+PGZcN+Utd
	 pqT/EKZIMhv1UFU3xjLOr/2eYig+nC3SKTPBBs1A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BABCFF805FE; Thu, 11 Jun 2026 21:31:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E509F806A6;
	Thu, 11 Jun 2026 21:31:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 609EFF8058C; Wed, 10 Jun 2026 15:52:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781099577;
	b=hDtOPBc1rB6+fLIIhAAg+0pe8s3rdZ9PN28StME3ZJjUNwYanUzf11i+kevgRehoeTkx
	 pT0T2euL5ajzOtVsSiLbWiP/hxerknf+sfoQBt3oUNDRoJICuFwtF2sgrDrTHULcYAFuJ
	 6pXr2Jrsg/oN2CcwXYJRWM8PjmhS/FGwOnyk1/KMuBtf997QOCsx+q6Q4UeuyFN+gsdPY
	 GKuqSr6bzHw5PZ6DMcYn0rkPT2vwfHQ3XSI5wKHX9Lkvu6WOQrRG4hFth9Eb3+joOB7Mf
	 XjnUn6e+3giRqwf+vBrBEAcyqtP26gD/mFCFyXHT0raIxLPzxdKFFjZrEFU1O3BiYRQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781099577;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:
	 To:From;
	bh=x9d1nGjclVZUKeV7iRM5DOu+kaZFIGubeAbIfc3DEcg=;
	b=DTqtbMuV7xMf6GpCtJKNmHBvuz9VZhGA5OLngu3M9Fr0k0WP3/yEHSveh5FPz4IWP/SW
	 hUf/fyVhcWpGyDIhwK9jTvPLQY9t38ZqlWz9eCvpe4efjWgvNno2VZohc2XLBe2Ty+LTX
	 0DmdfU3yPfltYlplzOPfdSBSLWe2YIcLP7IrZZBC+qyaDH/IhY+jjowZNyoxzLlA9mCjn
	 XG765qJkZZX5GHMr2ioN1AtQMkgq3wSirv1Duo+XmhmLadAIaTS8kO4oHCv+exzWyHWEa
	 dAuBBHLyykDN8JIcJd/MPFneI2zeJfTmYLv8XEQUXJiKvjxtitiD3xL0oz4JXOWvdyQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ZB5tGBGq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=b+XTYnPN;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7570BF801F5
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 15:52:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7570BF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ZB5tGBGq;
	dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=b+XTYnPN
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ACBdUO3763309
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 13:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2TlsIu3n7nbKaDJh1P/LwzPM/IJp0Dwz/y8o4GX5Z10=; b=ZB5tGBGqrmruZC5I
	UyQg/xhANWbk14wUoQLI4FTI9GBI8bmOFSlkvEyAEcbC3YS8XCMcS7qTMY0rBY9P
	PdZE+Zukbh6E6AJs5DBEhfzznsol2xrtGhVjF0QG2g1v5vQfIhKieXMWfMBjHpEb
	JnUEMIGvEPHJS5dPFIEMfpvAhEwTun1wa/eQNf87jaxvNthPebbnoRqliRgR13q9
	gYEEuXDKZOmCZ3/n0oX+ZuLjlhPwPphm5GeKibXMqss9b52ZILStRZZLuEYwHxll
	gHdKQjaB6GPDVzsdJaqpSphsYUqQogi7xV5Z0+FN7x9KEkDuBLpy+lmexKyaDbfm
	Dfthaw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnetr49-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 13:52:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5177b12d7bbso12196701cf.1
        for <alsa-devel@alsa-project.org>;
 Wed, 10 Jun 2026 06:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781099572; x=1781704372;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TlsIu3n7nbKaDJh1P/LwzPM/IJp0Dwz/y8o4GX5Z10=;
        b=b+XTYnPN1fK4aPrb9mX/QrLbFJDjEPzGRAAX4K07h8L+CW4OiK8etLxPRH8cAjpVfQ
         l16tU1qf2X3NRKz8moaa3c3/4r9x+M9L+PU8x0sJQi26M6aU/+q4ZfnzSVdwjOLjqjfS
         BYfluaFMB1EW18gMzR5hjgqHfpifW+nBogy5N17flEAULa0zcKm+7jIyZy1TNjT+T5qf
         BGdiIeKfCsLtbQ7ikUKjkP4D4FfkqGISVS1AlF53wVTasiS3BlvWspJRG0biXUwwSXkH
         rCcEtc9ggRFpSunMjuhz83KWhRXyOkEmLtnb5pryv5qUNyem+PDY6+enuNqZxixz93+S
         p1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781099572; x=1781704372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TlsIu3n7nbKaDJh1P/LwzPM/IJp0Dwz/y8o4GX5Z10=;
        b=XDfAmaiXwG2Glef2bvzD3HO241xrA7v2KqvMVoKtofx3Wclq2LyI7Mksd7Yxcvuo0C
         JorAqyMsBtC3PrkJOjZlMEXL/E4KfdgI6w7WNQ840XwCW6vBKGe9optgy3QzjGAhujeF
         n1F580whBRIG7zH6818X8Ua/PUZ/X5kM3338b8O0t0BRd9tOtEQzDzRh8e0mCHGtJj58
         t7gK3Diib8TeaTQY5NTNF/U8fdP4BxU21NPHPrbZP7YiNwvcTrR/y8XpXx3MSFZBR60c
         z+ZIBGrxpD25d+xirWrKrbehypTdNQtsjEFcVkez6RYMvRaIdtWNhLFF2bHVlTJJTC7M
         or7A==
X-Gm-Message-State: AOJu0YyCabo0IBSWRR5ua9dKyhnM0nQgZdN1q9Xr9gK4svDoFMLiaK28
	t6fKpXALSmWwWIIKbGKiPptdSIq2g3wrIyTGQKChrRz8laejkDFHu/M6j6Gx2c6yJkMoEbORbye
	lAyEeXM1Kr6lYTxLVQPhOvTRunSTsWyayRUfXBVfZ6zng34jYzXhcMGogWdIK15ScEQ==
X-Gm-Gg: Acq92OGC+qM01F6aeU4O2M99dp+JrfX9ExbkYkIDEVqfm7MPGXxwz//q7p6J5Zn8QGs
	AwAExet+SJ49H45G+e9uozV03k067r1k0jZJaEO1hjHAOhDiFjuk8wHo1/vOTFYJS4HaS0Fi8Tc
	LHm6mq2Uc5ngxEwa/I+jMd3TwD8rNEueF+lwmv5liAWSoOentGUhPAnhT0LGHnLvtFA/3oDpkvT
	uU3GHFhb80Op7bu5uPcvPzjQD3ziR6z65iZtNCGk5aDM/qkZu6lG8k7J68kY4fZkH5uzA9kHWOL
	ibcWJ7biXRs8gVzSBLPal3TY6OpX+0eVpCrtCz/4REReLAQK9C6Qmfa7DkSXKjATklkBG8Rwd6m
	/5WnjAbipOW3z5O5+GQHuP6I5+l0b46o7PYeEZ0EOI5whonmP6GkpxUV6
X-Received: by 2002:ac8:5f50:0:b0:50b:5286:f757 with SMTP id
 d75a77b69052e-51795c1b7ffmr228568901cf.4.1781099572086;
        Wed, 10 Jun 2026 06:52:52 -0700 (PDT)
X-Received: by 2002:ac8:5f50:0:b0:50b:5286:f757 with SMTP id
 d75a77b69052e-51795c1b7ffmr228568501cf.4.1781099571590;
        Wed, 10 Jun 2026 06:52:51 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf052097992sm1227220566b.26.2026.06.10.06.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 06:52:50 -0700 (PDT)
Message-ID: <5dce26c1-71ae-4c98-8010-037ff2cbccd6@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 15:52:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [alsa-devel] [BUG] Lenovo ThinkBook 16 G7 QOY (Snapdragon X) - No
 soundcards detected
To: "thomas.kuang" <ks002278@163.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <5fc3ab80.a3e2.19ea717f09f.Coremail.ks002278@163.com>
 <3c28dd62-223c-4447-8cec-c7c527aa49e3@oss.qualcomm.com>
 <5c57153a.79.19eae7e2814.Coremail.ks002278@163.com>
 <0a578098-7003-4048-9c29-affb632c44c9@oss.qualcomm.com>
 <6aac2e60.9b61.19eb1bb6031.Coremail.ks002278@163.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6aac2e60.9b61.19eb1bb6031.Coremail.ks002278@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SKgWkkrqx487lK6p6OQCkbDKrnR61uk5
X-Authority-Analysis: v=2.4 cv=ebYNubEH c=1 sm=1 tr=0 ts=6a296c35 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=FtP5j2NBnik-WtIcMc8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: SKgWkkrqx487lK6p6OQCkbDKrnR61uk5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzMiBTYWx0ZWRfX6DY1PrTaFkNV
 cAm+q7O7926oDOHj/KVEF5tmPSp4s59LnyBL7Rl0LQ4ZGaQAPnvEGWF9DP4jTx9TnFsMnOwRy5P
 fhH9ztKdF2LtkePTqC+lbH9H70VIE3CY3b1K8biqi0VLA1MD40um9D4yD6mvwKUh2JPz3fHwWeB
 FX2SoUy0XKJErjdNsqwrjxvBYIyq6dvsJgEAXSTH8ESARvdi8Dftq2u/FZkaCWzk67PFhz76pc5
 XtjI1XPwl7bUDVNfFIj163MMZ77WsIsur3SL0cU90EbVC9Jb14etr7bpNwusBO3GfdXSCBBAep+
 KQvNB9EyZmAoPQibA+cIl/jzAhBSobgjrsbaCmAid0XoRo3hu0W4VhB74JV/PU2YMVulJg0lTNr
 kQsyHDgTI6XEjajF6g2qYgx9+fWkW+5GmFi3ZkQaHW/SWqVHq0YPm1J0vfKiVJAsdgg6XWahbbu
 AsPe0qdW/hrGgA5V3Yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100132
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: TT6PJGDXOS6AJ5C7EK6MNL2CNYTFDCEZ
X-Message-ID-Hash: TT6PJGDXOS6AJ5C7EK6MNL2CNYTFDCEZ
X-Mailman-Approved-At: Thu, 11 Jun 2026 19:31:20 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TT6PJGDXOS6AJ5C7EK6MNL2CNYTFDCEZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 6/10/26 3:31 PM, thomas.kuang wrote:
> 
> 
> when run 
> sudo sh -c 'echo "start" > /sys/class/remoteproc/remoteproc0/state'
> sudo sh -c 'echo "start" > /sys/class/remoteproc/remoteproc1/state'
> 
> 
> dmesg is following:
>   625.929265] remoteproc remoteproc0: powering up adsp
> [  625.929296] remoteproc remoteproc0: Direct firmware load for qcom/x1p42100/LENOVO/21NH/qcadsp8380.mbn failed with error -2
> [  625.929299] remoteproc remoteproc0: request_firmware failed: -2
> [  625.929302] remoteproc remoteproc0: Boot failed: -2
> [  625.936529] remoteproc remoteproc1: powering up cdsp
> [  625.936552] remoteproc remoteproc1: Direct firmware load for qcom/x1p42100/LENOVO/21NH/qccdsp8380.mbn failed with error -2
> [  625.936555] remoteproc remoteproc1: request_firmware failed: -2
> [  625.936557] remoteproc remoteproc1: Boot failed: -2

As the dmesg suggests, you're missing these firmware files and need
to supply them.

Konrad
