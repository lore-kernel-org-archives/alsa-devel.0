Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15269C4452E
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:13:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57B5160201;
	Mon, 20 Jul 2026 13:13:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57B5160201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784546001;
	bh=4ujc+TdKbIFwSE4bM0CmdZ3/+rAlKA0JVdqPl3F3aN8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rB8Hh9iUCzDcCzQw1UlSseq6/dzZKnKtBvhPHH2XBsFcTpZAHw2moxmFYOZg494lS
	 vBktM+bEPG0DA2wwU9bMyrGRh1X/rZraT5qxLzJ8vNxH8qap9GrVV2/RgiRTR0AmP3
	 58ZZYmqrKNsOBxl1Vq1CeXsjDjezQT4CMB4uXEo4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EC8A2F80600; Mon, 20 Jul 2026 13:12:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DDF2F805F9;
	Mon, 20 Jul 2026 13:12:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7585AF80496; Mon, 20 Jul 2026 13:12:39 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784545955;
	b=CPU+AJpPyuTX/nv6q8LnwbIe2B+5RUoMb7e4YCRJub/D1idNClBctQ66e+mZoDs+uGP6
	 qnp21p4Mu+2qO1My/PacoM6biYVbPROZNKlO/A8RtWYp/ycSCHNFG+8SMhaugutYTES9F
	 sX/jHVfoG/g+40Re4fqQ1C69zjKZbu/wynrfhkT5qHfz+KHYweFL41xrajxyJ1L2OT/1X
	 A/sOhVwjfgmv/rSbOQ5krGoShJ/bkhMlJT+wIR5D9G+B71mFVc2ZO6QB6KvIkk8uaqXq8
	 SxPm+NdFYD1thdZyIqUlVWH3AhirC1c5XIUSHUIdnH2bhnlg/hHUJBwZ5xh6DBrkQzw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784545955;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:
	 To:From;
	bh=4ujc+TdKbIFwSE4bM0CmdZ3/+rAlKA0JVdqPl3F3aN8=;
	b=Fnf+NtX2S1ALfKIpGrwqzNFIfS20BOZOSYbrGG7xuWv/q0D7zccAzdGtGDKfGQseS982
	 QAA1ulAVWZWNkzIeMResn0L3sta/SrCWwXM1oplIDKjMo70qXFzO7zezgPR0nDvcOAAXe
	 QBddyAW7Z7zYnlDBN+nP3FqnjWh56LfC+R7dK1ijjO/IUctgtuDyXYj0jdJhE4Z7XpZvw
	 KIZhe2mIUECtPlS2Rf4LAL1BkUO4ASkZb2nA93uwIvYE3EYCesMOxtBbGy8bzbx4Zi/Fl
	 Rt0pS6PH2OauIZ6ohzdEjJAB+gmOcUF2CbITHgGqtCBx+jW25oaLf7DCkuVNhG1Qjjg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=e1p4mlr9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eZY7C0KK;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 01D4BF8010B
	for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2026 13:12:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01D4BF8010B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=e1p4mlr9;
	dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eZY7C0KK
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAvULF3434697
	for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2026 11:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k97eQvRWWvnJ5DA1QESATwZmv4rh/WBZGVqcLJGkXIs=; b=e1p4mlr98RD3I9Jb
	Im0v4+KFpplMkxXE+F2RPKTvynMxuMDKvAXSvBJa7mjSvu86Eh7y61g46plWAPWD
	g9yvzGTL/yUq3/9c2Sz+iOD0/UmYyvace1my0JvtAj9pZKbizERg32XGE3J2y6mS
	xWU2MwH7VCOgxTm257utz0H2YBfQ050aW+mvlI1DlUV65vvzlbYDkdgnjLzjnyNX
	ZxS7T8xoKaqOzdhhy2OejydxRdWOfuxMDRjjECMCcgogRK5e/Rmj/+nRqug1zNt7
	ZbJL+HEzpzSHrVJyFnKBGDqYFtBIPjk8piP7WPuo3fx8Iu0GUrwJxnC2M9MTgDlR
	QOqyrA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfpg0xqu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2026 11:12:30 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cab048cdb3eso11144583a12.0
        for <alsa-devel@alsa-project.org>;
 Mon, 20 Jul 2026 04:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784545950; x=1785150750;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k97eQvRWWvnJ5DA1QESATwZmv4rh/WBZGVqcLJGkXIs=;
        b=eZY7C0KK4qjB3ZIwD5dAAuXdlEFzWu6Wlm99HcM0K7W89cA1Q2mSn4vw0KidiZr+4C
         smFCcoAWKWtoHXJCuGsVN/SrPBNpqcJUNeDYzmm7ZLK9ZQfcJ/WKSXVZe4F9uNINw18S
         DGT2LNXq/2+C4ISYpd0gEHT90HdmvYpTPGhqnjR1XfvwtLd1heMBpx5XNSHlilWczQu+
         5n/UcPSUqfoGx9WoblKpUR2kF4KljYYeDVFHUh9viZacXvdNYWlN+ypbt+8mJMOD7W5G
         sQLRDtVfxU/N6vaNoBThRlQetyfu841qS2MdlfLBzt2tA/0k2nctwZon6MmOWQwofhZ4
         OB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784545950; x=1785150750;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k97eQvRWWvnJ5DA1QESATwZmv4rh/WBZGVqcLJGkXIs=;
        b=ZU/FDjBAqDlnoR1VmM/Olskm8gY96UoJJFLesfYfWKFpW9SDdaizUgfYo4wxMI+PH7
         amMqEr7Q5VEzbfgft7YL9ytsh7Q5UY2AshP27rTBKEAViKIpv927tEa474QjvXF7Pg/s
         JTqLgieGXg9pIdqPdvPjVxbRzASBEXTGoHTUO2QM2+9ekzIqSG4P+gVAyhnhDKX/MXWu
         lma+n/MXn15uXdjf9aI3dsEY91CiquWPvQqfRSNMJguN7euFqF2IWxE1B3xQwce/QZ8O
         y9Xbr4RXmB4eTOCDa/9gg3qA5vIKbiHbeg28EctNYDR15vmicybE+pt7BbAX0fklryrB
         f6ig==
X-Forwarded-Encrypted: i=1;
 AHgh+RpElALbmO+ePwPSl2YDxA7PI/4JbjgmcTmMZi44zirH7+S6Xdof/X/2ft6KKpyddp2zx3ZW3gKmnkDZ@alsa-project.org
X-Gm-Message-State: AOJu0YyURELALb3aG7RocY+znzEBNITB3ckl4DJcEXQ+rUMbp/MqeI6Q
	4tTHBK8iRqqsaxIATbHA4q++iYWEsk0cgfZcSyilbmnVNhiX45nzjLawNqAoGGR7bsj/6pqOfSI
	+TFk0s4XYdWvlxUcE/YfVxRfevW/eynOBhyvHOaloDDVeccN7tzFwdFzWb1xBMlF74w==
X-Gm-Gg: AfdE7ckVU6InddWigwp0sbOEeLQCyMxuflG2V6lDT4cKGrwMmclOl0XmgActVZPzCFJ
	9Tdrls6Jsm27PV2f1oCkRSrBnaKPpVEQLe7LYcYQqg6EdHlDVpHhiHJQub2LzWJssn8Q/8mpEYA
	XVnLLiCoriYgOh6HbLHubffS7UR8zEkuilOMUAbISd8l1Xvhoecg3u9Ffeau/HQGAGfbmk575TJ
	vIHdccuZHa2WA8ezyL21iwT73FvDmg9hmvEprEqSGkpxTqxOvC+5pqai9bFejfbK8uzbkYnepl/
	XYqr19DDqFz4VK3Ietgo0BtdXtYXaOWGv8jpmaH2d/gd1kxJMUfz/Z656rRmKp4YqAGZL2v9Q63
	TsJ43wZzDXmLXjNWjb5bMDA9r+MFb
X-Received: by 2002:a05:6a00:2302:b0:848:89ee:9de6 with SMTP id
 d2e1a72fcca58-84c29501a3amr13732112b3a.58.1784545949493;
        Mon, 20 Jul 2026 04:12:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:2302:b0:848:89ee:9de6 with SMTP id
 d2e1a72fcca58-84c29501a3amr13732035b3a.58.1784545948530;
        Mon, 20 Jul 2026 04:12:28 -0700 (PDT)
Received: from [10.218.18.193] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84c2ad8b766sm5507311b3a.4.2026.07.20.04.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 04:12:27 -0700 (PDT)
Message-ID: <d224b1e5-99a0-4794-b043-d6335f98753c@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:42:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] fw_devlink: incorrect ancestor fallback for
 intermediate bus topologies breaks audio dependency resolution
To: linux-kernel@vger.kernel.org, Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        spatakok@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, ravi.hothi@oss.qualcomm.com,
        dakr@kernel.org, andriy.shevchenko@linux.intel.com
References: <20260701131733.870079-1-ajay.nandam@oss.qualcomm.com>
Content-Language: en-US
From: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
In-Reply-To: <20260701131733.870079-1-ajay.nandam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyNSBTYWx0ZWRfX6qjWme0doUt/
 Hspo65oQiK0fvrhhVoKpRdX/DuIrc9WoonH6v5VewDFerJh1nH7J3XxqlP3iQYwxf41KpRvu+/G
 h2yNbcXFqXQ/FHzfabRgPUNmNHpVfWU=
X-Proofpoint-GUID: CdmgVeqI3QYLegoqaJ34qLS7_OTju9mX
X-Proofpoint-ORIG-GUID: CdmgVeqI3QYLegoqaJ34qLS7_OTju9mX
X-Authority-Analysis: v=2.4 cv=c+6bhx9l c=1 sm=1 tr=0 ts=6a5e029e cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=P-IC7800AAAA:8 a=70CVnfZDNZvQOOoLNW8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyNSBTYWx0ZWRfX9rBMDH+mW4XT
 0EnSE7nIw6hoJNMl0PxSbcfvDvZiWWt9IDiUr7Z3zdTxodPn6lLrzW3YvYTeiAkfqy+zXGQRN27
 C2gAooL2J0kcfEtbUXCSEwOHUhKyO7AiQk2U/URYSWTIn0dbOyFrqhYVi1UQ7A1zqcVLxjXvsOp
 HjuRoOo/plIsC/BxFQOGvsS4ijr3Pfi9Mq/MuqZVm+0pdQqZEmDb7evM7BIajfrgAQV9RdY8iQF
 xYUn5SLvzm/Ifqmi+K1rHeVd1LwbdCruP/N9eWyjb9AxR44ubbg2ZTiLBVUCMhL1p/dHq+bk1Ro
 GZgv4pfvWHkZsK2kYw5ua50KpMiWAj063WP8zlSk42An1e8qgleAFZ63zmEhIJcmsuhXUYzlDoK
 sx7NNHi7iu/hqySeidDlmkRtnlatblnOp1frSmQbFhYLwF7jjwvhzT+DYo5+80WaHEJJ2pGTZu1
 4Z4Hrc/hG0a5+9yCGdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200125
Message-ID-Hash: T7FTHDGZDLC2FLCXCB6FWWWKPDWJAVFF
X-Message-ID-Hash: T7FTHDGZDLC2FLCXCB6FWWWKPDWJAVFF
X-MailFrom: ajay.nandam@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T7FTHDGZDLC2FLCXCB6FWWWKPDWJAVFF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi All,

Gentle Ping on this discussion.

CC'ing Danilo Krummrich and Andy Shevchenko

Thanks & Regards
Ajay Kumar Nandam

On 7/1/2026 6:47 PM, Ajay Kumar Nandam wrote:
> Hi Saravana Kannan,
> 
> I am Ajay from Qualcomm, and I am working together with Ravi on ADSP
> Subsystem Restart (SSR) support for Qualcomm LPASS audio. During our
> SSR work Ravi observed that restart does not behave as expected — when
> the ADSP restarts, all child nodes of the remoteproc should detach and
> re-attach cleanly once the remoteproc is up. While investigating
> this, Ravi identified an incorrect assumption in fw_devlink's dependency
> resolution logic that causes wrong device links to be created when a
> supplier device lives behind intermediate bus nodes that are populated
> asynchronously. We observed this on a Qualcomm qcs6490-rb3gen2 board
> with LPASS audio drivers, but the assumption is generic and can affect
> any similar topology.
> 
> Problem Summary:
> 
> fw_devlink appears to incorrectly collapse pending dependencies to
> an ancestor device when supplier devices exist behind asynchronously
> created intermediate bus nodes.
> 
> In our topology, q6prmcc is instantiated as a descendant of the ADSP
> remoteproc through asynchronously created glink/gpr bus devices.
> When the remoteproc device binds earlier, fw_devlink appears to assume
> that these intermediate nodes will never become devices, collapses the
> dependency to the remoteproc ancestor, and deletes the pending links.
> As a result, the intended dependency:
>      lpass_va_macro -> q6prmcc
> is replaced by:
>      lpass_va_macro -> remoteproc
> 
> This results in incorrect teardown ordering during ADSP SSR because
> codec drivers are no longer linked to their actual clock supplier.
> 
> Could you please suggest how we can resolve this issue? Is there
> a specific reason for this assumption, as it looks incorrect in our case?
> 
> 
> -------------------------------------------
> 1. AUDIO SYSTEM TOPOLOGY ON qcs6490-rb3gen2
> 
> On qcs6490-rb3gen2 the LPASS audio clock supply chain spans a
> four-level device hierarchy rooted at the ADSP remoteproc. The
> intermediate nodes (glink-edge, gpr) only get their struct devices
> after the ADSP firmware has booted, which happens well after the
> remoteproc driver's own probe() returns.
> 
> The Device Tree hierarchy (from qcs6490-audioreach.dtsi / kodiak.dtsi):
> https://elixir.bootlin.com/linux/v7.1/source/arch/arm64/boot/dts/qcom/qcs6490-audioreach.dtsi#L113
> 
>    remoteproc_adsp                         (ADSP remoteproc)
>        └── remoteproc_adsp_glink           (GLink transport edge)
>                └── gpr                     (GPR bus, compatible="qcom,gpr")
>                        └── service@2       (PRM service, compatible="qcom,q6prm")
>                                └── clock-controller  (q6prmcc)
>                                        compatible = "qcom,q6prm-lpass-clocks"
> 
> The LPASS codec drivers (VA macro, WSA macro, RX macro, TX macro) are
> platform devices under soc@0 that reference q6prmcc as their clock
> supplier via DT phandles:
> 
>    From qcs6490-audioreach.dtsi:
>    ------------------------------
>    &lpass_va_macro {
>        clocks = <&q6prmcc LPASS_CLK_ID_VA_CORE_MCLK ...>,
>                 <&q6prmcc LPASS_HW_MACRO_VOTE ...>,
>                 <&q6prmcc LPASS_HW_DCODEC_VOTE ...>;
>        clock-names = "mclk", "macro", "dcodec";
>    };
> 
>    &lpass_wsa_macro {
>        clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK ...>,
>                 ...;
>    };
> 
>    (similarly for lpass_rx_macro and lpass_tx_macro)
> 
> The intended fw_devlink dependency is therefore:
> 
>    lpass_va_macro  (consumer)  ──►  q6prmcc / clock-controller (supplier)
>    lpass_wsa_macro (consumer)  ──►  q6prmcc / clock-controller (supplier)
> 
> This dependency is critical for correct ADSP SSR (Subsystem Restart)
> teardown: all codec drivers must be torn down BEFORE q6prmcc is
> removed, so that no driver calls into a clock controller that no longer
> exists.
> 
> -----------------------------------------
> 2. THE INCORRECT ASSUMPTION IN fw_devlink
> 
> fw_devlink correctly identifies the intended supplier at boot time via
> fwnode links. However, the links are never converted to device links.
> Instead, fallback device links to the remoteproc device are created.
> 
> The sequence of events:
> 
>    1. At boot (~t=0.085s), fw_devlink resolves the DT clock phandles
>       and creates fwnode links:
>         lpass_va_macro  ──fwnode──►  gpr/service@2/clock-controller
>         lpass_wsa_macro ──fwnode──►  gpr/service@2/clock-controller
>       q6prmcc does not exist yet → EAGAIN → fwnode links kept pending.
>       This is correct.
> 
>    2. At ~t=7.597s, remoteproc_adsp probe() completes. This triggers
>       device_links_driver_bound() which calls
>       fw_devlink_pickup_dangling_consumers(remoteproc_dev).
> 
>    3. fw_devlink_pickup_dangling_consumers() walks remoteproc's child
>       fwnodes. It finds the gpr fwnode with no struct device attached.
> 
>    4. Here is the incorrect assumption:
>       __fw_devlink_pickup_dangling_consumers() concludes that because
>       gpr has no struct device at this moment, it will never get one.
>       It marks gpr as FWNODE_FLAG_NOT_DEVICE and moves all of gpr's
>       consumers (including the codec → q6prmcc fwnode links) up to
>       remoteproc.
> 
>    5. The correct fwnode links (codec → q6prmcc) are permanently
>       deleted. Wrong device links (codec → remoteproc) are created.
> 
>    6. At ~t=8.364s, the GPR bus probes and q6prmcc eventually appears.
>       But there are no pending fwnode links left for it — the correct
>       dependency is lost forever.
> 
> The assumption that is wrong:
> 
>    "If a child fwnode has no struct device when its ancestor device
>     binds, it will never get one."
> 
> This assumption does not hold when intermediate bus nodes (glink-edge,
> gpr) are populated asynchronously after their parent device boots remote
> firmware. At the time remoteproc binds, glink-edge and gpr have no
> struct device not because they will never exist, but because they are
> waiting for the ADSP firmware to load — which only happens after
> remoteproc's own probe() returns.
> 
> https://elixir.bootlin.com/linux/v7.1/source/drivers/base/core.c#L1300
> 
> ------------------------
> 3. EVIDENCE — DEBUG LOGS
> 
> We added debug instrumentation to fw_devlink's key decision points
> (filtered to audio devices only) to capture the exact sequence.
> 
> --- t=0.085s: Correct fwnode links identified, q6prmcc absent ---
> 
>    [0.085060] debug: fw_devlink_create_devlink:2356 audio supplier
>      /soc@0/remoteproc@3700000/glink-edge/gpr/service@2/clock-controller
>      not yet a device, deferring link from consumer=3240000.codec (EAGAIN)
> 
>    [0.086178] debug: fw_devlink_create_devlink:2356 audio supplier
>      /soc@0/remoteproc@3700000/glink-edge/gpr/service@2/clock-controller
>      not yet a device, deferring link from consumer=3370000.codec (EAGAIN)
> 
>    Both codecs correctly identify q6prmcc as their supplier. q6prmcc
>    does not exist yet → EAGAIN → fwnode links kept pending. Correct.
> 
> --- t=7.597s: remoteproc probe completes ---
> 
>    [7.555169] qcom_q6v5_pas 3700000.remoteproc: debug: qcom_pas_probe:745
>      qcom_pas: probe start, parent=soc@0
>    [7.597126] qcom_q6v5_pas 3700000.remoteproc: debug: qcom_pas_probe:865
>      qcom_pas: probe complete, parent=soc@0
> 
> --- t=7.597s: POINT OF NO RETURN ---
> 
>    device_links_driver_bound() fires for remoteproc. It calls
>    fw_devlink_pickup_dangling_consumers() which finds gpr with no
>    struct device and moves ALL of gpr's consumers to remoteproc:
> 
>    [7.597160] debug: __fw_devlink_pickup_dangling_consumers:276
>      audio dangling consumers: moving consumers of
>      /soc@0/remoteproc@3700000/glink-edge/gpr
>      to ancestor /soc@0/remoteproc@3700000 (no device yet)
> 
> --- t=7.597s: Correct fwnode links permanently deleted ---
> 
>    [7.597205] debug: __fwnode_link_del:155 audio fwnode link deleted:
>      consumer=/soc@0/codec@3370000
>      supplier=/soc@0/remoteproc@3700000/glink-edge/gpr/service@2/clock-controller
> 
>    [7.609265] debug: __fwnode_link_del:155 audio fwnode link deleted:
>      consumer=/soc@0/codec@3240000
>      supplier=/soc@0/remoteproc@3700000/glink-edge/gpr/service@2/clock-controller
> 
> --- t=7.637s: Wrong device links created ---
> 
>    [7.637952] debug: fw_devlink_create_devlink:2331 audio device link created:
>      consumer=3240000.codec supplier=3700000.remoteproc flags=0x124
>      (consumer_fwnode=/soc@0/codec@3240000)
> 
>    [7.674145] debug: fw_devlink_create_devlink:2331 audio device link created:
>      consumer=3370000.codec supplier=3700000.remoteproc flags=0x124
>      (consumer_fwnode=/soc@0/codec@3370000)
> 
> --- t=8.364s: GPR bus probes — 770ms too late ---
> 
>    [8.364221] qcom,apr ...: debug: apr_probe:597
>      apr/gpr: probe start, parent=3700000.remoteproc:glink-edge
>    [8.364446] qcom,apr ...: debug: apr_probe:648
>      apr/gpr: probe complete, parent=3700000.remoteproc:glink-edge
> 
>    GPR bus probes 770ms after the fwnode links were deleted. q6prmcc's
>    consumers have already been stolen. No pending links remain.
> 
> --- t=15.409s: VA macro binds — wrong supplier confirmed ---
> 
>    [15.389975] va_macro 3370000.codec: debug: va_macro_probe:1538
>      va_macro: probe start, parent=soc@0
>    [15.399678] va_macro 3370000.codec: debug: va_macro_probe:1683
>      va_macro: probe complete, parent=soc@0
> 
>    [15.409155] debug: device_links_driver_bound:1420
>      ENTRY dev=3370000.codec (struct parent=soc@0)
>    [15.418101] debug: device_links_driver_bound:1426
>      ENTRY supplier link: dev=3370000.codec
>      supplier=3700000.remoteproc (fwnode=/soc@0/remoteproc@3700000)
>      flags=0x164 status=2
>    [15.434076] debug: device_links_driver_bound:1426
>      ENTRY supplier link: dev=3370000.codec
>      supplier=33c0000.pinctrl (fwnode=/soc@0/pinctrl@33c0000)
>      flags=0x164 status=2
> 
>    q6prmcc is completely absent from the supplier list. The device link
>    to remoteproc is wrong. The correct dependency is permanently lost.
> 
> ------------------------------------
> 4. IMPACT — ADSP SSR TEARDOWN BROKEN
> 
> With the wrong device link in place (codec → remoteproc instead of
> codec → q6prmcc), the teardown order during ADSP stop is incorrect.
> q6prmcc is removed while codec drivers still depend on it, causing
> them to call into a clock controller that no longer exists. Audio
> drivers are left in an invalid state and proper cleanup does not happen.
> 
> ----------------------------------------------------------
> 5. WORKAROUND — MANUAL DEVICE LINK IN q6dsp-lpass-clocks.c
> 
> To confirm the hypothesis and restore correct teardown ordering, we
> manually created the device link from q6prmcc to lpass_va_macro inside
> q6dsp_clock_dev_probe() in sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c.
> 
> With this workaround in place:
>    - The correct device link (lpass_va_macro → q6prmcc) is established
>      when q6prmcc probes.
>    - On ADSP stop, lpass_va_macro is torn down before q6prmcc.
>    - Audio driver cleanup happens correctly and completely.
>    - No dangling state is observed after ADSP SSR.
> 
> This confirms that the dependency model itself is correct — the problem
> is purely that fw_devlink fails to establish it automatically due to
> the incorrect assumption described above.
> 
> The workaround patch is included below for reference.
> 
> --- Workaround patch (reference only, not proposed for merge) ---
> 
> diff --git a/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c b/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
> index 03838582aead..3884d3e96e33 100644
> --- a/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
> +++ b/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
> @@ -8,6 +8,7 @@
> #include <linux/device.h>
> #include <linux/platform_device.h>
> #include <linux/of.h>
> +#include <linux/of_platform.h>
> #include <linux/slab.h>
> #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
> #include "q6dsp-lpass-clocks.h"
> @@ -126,6 +127,52 @@ static struct clk_hw *q6dsp_of_clk_hw_get(struct of_phandle_args *clkspec,
>   return ERR_PTR(-ENOENT);
> }
> 
> +/*
> + * va_macro_compat - compatible string for the va macro codec device.
> + *
> + * Used to locate the consumer device for the manual device link.
> + */
> +#define LPASS_VA_MACRO_COMPAT  "qcom,sc7280-lpass-va-macro"
> +
> +/**
> + * q6dsp_clock_link_va_macro - create a manual device link from va_macro
> + *                              to this clock-controller (q6prmcc).
> + *
> + * fw_devlink cannot establish this link automatically because q6prmcc is
> + * a dynamically created device (child of remoteproc/glink/gpr) and its
> + * fwnode link is purged by __fw_devlink_pickup_dangling_consumers() when
> + * the remoteproc parent binds. This manual link ensures va_macro is torn
> + * down before q6prmcc on ADSP SSR.
> + */
> +static int q6dsp_clock_link_va_macro(struct device *clk_dev)
> +{
> +  struct device_node *va_np;
> +  struct platform_device *va_pdev;
> +  struct device_link *link;
> +
> +  va_np = of_find_compatible_node(NULL, NULL, LPASS_VA_MACRO_COMPAT);
> +  if (!va_np) {
> +    dev_dbg(clk_dev, "va_macro node not found, skip devlink\n");
> +    return 0;
> +  }
> +
> +  va_pdev = of_find_device_by_node(va_np);
> +  of_node_put(va_np);
> +  if (!va_pdev) {
> +    dev_dbg(clk_dev, "va_macro device not yet registered\n");
> +    return 0;
> +  }
> +
> +  link = device_link_add(&va_pdev->dev, clk_dev,
> +             DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOPROBE_CONSUMER);
> +  put_device(&va_pdev->dev);
> +  if (!link) {
> +    dev_err(clk_dev, "failed to add device link to va_macro\n");
> +    return -EINVAL;
> +  }
> +
> +  return 0;
> +}
> +
> int q6dsp_clock_dev_probe(struct platform_device *pdev)
> {
>   struct q6dsp_cc *cc;
> @@ -180,6 +227,10 @@ int q6dsp_clock_dev_probe(struct platform_device *pdev)
> 
>   dev_set_drvdata(dev, cc);
> 
> +  ret = q6dsp_clock_link_va_macro(dev);
> +  if (ret)
> +    dev_err(dev, "Failed to create devlink between prmcc and va macro\n");
> +
>   return 0;
> }
> EXPORT_SYMBOL_GPL(q6dsp_clock_dev_probe);
> 
> --- End of workaround patch ---
> 
> Tested on: Qualcomm qcs6490-rb3gen2, Qualcomm sm8750-mtp
> 
> Thanks,
> Ajay Kumar Nandam

