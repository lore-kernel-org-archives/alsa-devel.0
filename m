Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E21C54F54
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:26:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D110A601F7;
	Fri, 31 Jul 2026 09:26:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D110A601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785482806;
	bh=mo7dw6vB6ggaGv3tG31AMRQAwPc45eB7mu19dYsk22E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=URiv6JrMxalEvlLpY12DMv0V+tCq+vA02OK+9vs2SDKaXOrDUt2rbRdgE2H4GBW77
	 s5lgJzRj1pd2yhI87he8pvjLRS0HDA2i2UnmghFlti62eEJ/s04+3LVhEsvDFGCj8r
	 nwdw3z3o2Rh/Z/bH3X56HIZgRSf2J2NbXxKNatBU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B67B9F805F6; Fri, 31 Jul 2026 09:26:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 39758F80601;
	Fri, 31 Jul 2026 09:26:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 74EFDF80571; Wed, 29 Jul 2026 14:57:14 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785329831;
	b=TNPjkwDJNfTnsQzypsebXqeRUpacATofyL1BXw7hkxju6Uqw8DEW8ZQgAilB6f4HCyaF
	 DptgVq8d3n8e7SmHUob092Yx3MZQYwYK2NMCRhGPn1YzeXJ0aBKf9R/0DUUjYGRhOar09
	 jgc648f0mDfDyTMtAQnda675HfFJ1imjFlGKajNl1fcwUXYsMV4B+toDwYppWgtJeJsj5
	 VfnwTkjMw3h9Mpz2aio8M/4atHjR75C7QnBsEgn2KNSj3TlilSlTk0A3Br5c7KZphI2Ss
	 ujjsPJHoyDEEFVy+hOjjo6mXrLSL42JLtTLyFpavxt9K0dq25F53RSVTlAuX9EsThow==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785329831;
	h=DKIM-Signature:DKIM-Signature:Date:From:To:Subject:Message-ID:
	 MIME-Version;
	bh=mo7dw6vB6ggaGv3tG31AMRQAwPc45eB7mu19dYsk22E=;
	b=m1g862WBYt/+wrkaTaeanVti81rXVheWTd/k8Hi7AgTjrcqnFo7Pn0A/YBKgy3VqrH9O
	 dGzdvfq1XNNB1qa1Yft6z9ibCjoSyE24rwzE5EIVOE1QapYrZsoWyqgVvTa7RP76+azWG
	 1SJrY7rjJCtR7/7OR/TNWAi13x84XwjM+MP5AnqaJlVciBAND8r9Qbkvx6Y/H+asdsvpq
	 q2jeM6LYxldRWEjg8VTk4L5mCMqJfs+n1dxzpOb9ITBm3K2b8ET/N0awz27ahddiD5xI3
	 iABik8iJ276IJN7PunKLyQRGvw1wOk/IW1LvHM/pAxszuMV+OMNhX+4v8Bmt3sF84yQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=WnG7mCtO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=h7rEXJM8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 509B6F8025A
	for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2026 14:57:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 509B6F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=WnG7mCtO;
	dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=h7rEXJM8
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TBWiSZ1910530
	for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2026 12:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ermkCfz6no91BoabcO2VpBECJ7Kl0yCB6REaLfSQZWk=; b=WnG7mCtOH9Nv9NcM
	/6sUgodwUdr8GGfG9MJGFvKXDluZWv4niLQsKnJTYPXCXsuiyfksx0tgHDRI3YBh
	MHAA6Bv/dQvA2DL9lPkaLhhV3M8oi7FEMRp6zFj96ajhtPS/Fye2+QkjO8ngRb+L
	Gy2NlCYxoORKUtscEfMZjFeblKrK2HShyluC7tyxjhFETulxhfZzc06X3FTveMRN
	h1wwb+txYP8sDvPc4o325B8+F5PwJD4xMBWFEmkVCKMCOK2Rbt5JcQMPIjaySMC/
	KdpyJj/HaMHic+WYuqhFsct2wjTQoNSx3JAy8RMRcZTkTq07E2I3v6vZyJ2llE14
	PSIkEw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgr68asx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2026 12:57:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e25e4b41cso1106270a91.0
        for <alsa-devel@alsa-project.org>;
 Wed, 29 Jul 2026 05:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785329826; x=1785934626;
 darn=alsa-project.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ermkCfz6no91BoabcO2VpBECJ7Kl0yCB6REaLfSQZWk=;
        b=h7rEXJM8EE41LYEABX7wtzJJA/EIgrLAFjDUeKTOzGSlFpc6oEtBYkYBxL1do9kwp8
         MEwQpeuRREMvcKINoCAFv5lCu4N3y7LraDkN4rq1CbEOqPIv9WTHJVz6/SlDRCrsyXw6
         X2fc1sxMVMfdVb3Y056RmzTwMcW+AfdyEAnuBvhSE8Cn8cpeYgf9gvjk08FKWSJF3rd1
         F+NC0C3K8N7OWQWzoTlqofskqHz/SoJizAcweGBQd2euiBXe3klcs+Bfw0Nu8+qnIYkQ
         hZKJNYNN0xwLpeTzljmdptY0Qp6yRFy2UHzE65aNHrTVHTc4MgzCLsGyJz6ZJBNqUCo1
         A48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785329826; x=1785934626;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ermkCfz6no91BoabcO2VpBECJ7Kl0yCB6REaLfSQZWk=;
        b=o0Gcoc6gQzC2R2oGOoubK1GvAvxL8vZaIvo1BX0RbLapCfPWfuEXSHSe3H9G1wYui6
         6leTejPk4BoaoPIJ7INIHvNOl/3weKJGZBnEHx9Tipz1zYm2bPNi3MJe4gpJf6h56Jb6
         mrCnqcBAL/8KpBS5heEAEbcMX/QSg5o97HUJC6yTngx84HSoGzLozk1/AsYMV6r8WaJ+
         T0AuxxNmpOWKB7ZpW0DL23DB9wZaxKzTSvjPo7RtnbQxZSyO5Oq1nfvhPpVdXv02TZg+
         T0AuQ31aLt15wSkzepxY1Lvp3JbfFmUkiYlHrA710QIZtqIyaRsm8NhhZf7XLqjZjvLZ
         TR/w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrY/dFx3y6OiudAHHYxiTC9XX6fLxRQFkBcLyhvPcuIyWMIbOkxLTuf8SQ8JUF6W5L5ZAgKwl+QPcTu@alsa-project.org
X-Gm-Message-State: AOJu0YzG5xUvR0hehQ61R7I1qJKebwKi49Ca7MXJ7edv+fZyqytCuBDd
	y5FsJnPZNuwUWYR6r0GjoFDJIMZf9pNZVkheKkwKKFH5Z7HzLOnu39WfZdV/Hlmxd70yQDS2AaO
	oMlLWEB/fFDpm7Mm0xCUabPnlOXgxZsadUtjZyfHv7u1aTjEUmwxZcEo37/7X8z6XTQ==
X-Gm-Gg: AR+sD10kcPYZf6YjsvE3gNsQmJzelNIYEbT7uIqQwnvQ6lvkFgYOQgD6bIbf2DZJUJg
	swKWMRgHuqlK4euI7/akcdttdzRqkFZU6WDQQLbyritnT4BXaTIWVBKLWXjXtYUQU2YtvCvTREn
	ZeD/QEIkqetZdtoPbs15vwhsCYYJZ2HotaZogmSWKyx6kPntfh8Ll+EcD1AtHV2K7wIgrc3Y2FP
	L6hRoEVLXloQl9XTejXAJTeurUOdSR4RPwgQUX38ZQc9HNP9LR8z9pcjjyzDXrsv16sCqmYIdya
	MikR6uUc1oYiTTOj3Wfyi8WE+z1eU7mEBGeG65vRsxDg9UiowRehy2Zgmx1JAT7GDTMI1sDtMAT
	yiFQoSOFE4fwTMbSbJNo1qynu4uo=
X-Received: by 2002:a17:90b:47:b0:38f:5828:857e with SMTP id
 98e67ed59e1d1-38f6a33f520mr7120404a91.16.1785329826013;
        Wed, 29 Jul 2026 05:57:06 -0700 (PDT)
X-Received: by 2002:a17:90b:47:b0:38f:5828:857e with SMTP id
 98e67ed59e1d1-38f6a33f520mr7120354a91.16.1785329825298;
        Wed, 29 Jul 2026 05:57:05 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7275973dsm8809912c88.15.2026.07.29.05.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:57:04 -0700 (PDT)
Date: Wed, 29 Jul 2026 18:26:57 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        spatakok@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, ravi.hothi@oss.qualcomm.com
Subject: Re: [DISCUSSION] fw_devlink: incorrect ancestor fallback for
 intermediate bus topologies breaks audio dependency resolution
Message-ID: <20260729125657.phrqwyigwuljezoc@hu-mojha-hyd.qualcomm.com>
References: <20260701131733.870079-1-ajay.nandam@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701131733.870079-1-ajay.nandam@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwNyBTYWx0ZWRfX/Lx8dfI2SmTL
 ViCNsjCTUGn7LM6ax7Lqkffw0hu2gaARbPalfKeLPZMztZvZgpXafGj0dzmi4kUnjGOavur0VMt
 xY7P1XM0lIWTOmy4EMck+KzGz5lcNriqzRTiCPORVb5xCecv4HuCe2MSiGR6Vacald540Z/KfiY
 mE7NfCM2498087piOx8tkog5Bdj4qmSON1NLkEPSLI0m8IYTFeDl2An4jsSVJQw4/yYKNMRPk1z
 V1p5Cf9HM9x2hQkBeDFLRspblEHhV/fJTW7FUEk2rUqWikfHphkG4Aq4E7qNlTiua72KUgQEW7w
 fMExvzAJmdwbkd5Hwy4ld7eidBRyTTaSTgXDKfemU3/FSkD9s0VV/7gpjdpnUaZb9pLU4Hnuyo0
 ty+jA5fqrU2ijJvGBi/B70A1kx74SFLP8ZlVT7IrP2GNouxnCUUh7DyCOcTPfGwyRr506qgBw/A
 uespYq9bVAtCp000ftA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwNyBTYWx0ZWRfX7qgr84QixOvO
 MvTKbXaeMCcZb1RgK554kkxs1HR9iuGIR7X+Xn5zMRDo68APh4phgMSTsPzjNqlTI4qBavTtUWb
 KbC4KHKAItdJmaW436RDoTa9YOfmMCc=
X-Authority-Analysis: v=2.4 cv=Cv2PtH4D c=1 sm=1 tr=0 ts=6a69f8a3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=P-IC7800AAAA:8 a=jljjzdZnxhpnBLCvp84A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: QP8cV9SzcwWsl-8N7ZV0CJi-tJId5Qgb
X-Proofpoint-GUID: QP8cV9SzcwWsl-8N7ZV0CJi-tJId5Qgb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290107
X-MailFrom: mukesh.ojha@oss.qualcomm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: AE2V5WMMPJIQO6QZB4XI5NRUFJA4QPFJ
X-Message-ID-Hash: AE2V5WMMPJIQO6QZB4XI5NRUFJA4QPFJ
X-Mailman-Approved-At: Fri, 31 Jul 2026 07:26:05 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AE2V5WMMPJIQO6QZB4XI5NRUFJA4QPFJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Jul 01, 2026 at 06:47:33PM +0530, Ajay Kumar Nandam wrote:
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
>     lpass_va_macro -> q6prmcc
> is replaced by:
>     lpass_va_macro -> remoteproc
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
>   remoteproc_adsp                         (ADSP remoteproc)
>       └── remoteproc_adsp_glink           (GLink transport edge)
>               └── gpr                     (GPR bus, compatible="qcom,gpr")
>                       └── service@2       (PRM service, compatible="qcom,q6prm")
>                               └── clock-controller  (q6prmcc)
>                                       compatible = "qcom,q6prm-lpass-clocks"
> 
> The LPASS codec drivers (VA macro, WSA macro, RX macro, TX macro) are
> platform devices under soc@0 that reference q6prmcc as their clock
> supplier via DT phandles:
> 
>   From qcs6490-audioreach.dtsi:
>   ------------------------------
>   &lpass_va_macro {
>       clocks = <&q6prmcc LPASS_CLK_ID_VA_CORE_MCLK ...>,
>                <&q6prmcc LPASS_HW_MACRO_VOTE ...>,
>                <&q6prmcc LPASS_HW_DCODEC_VOTE ...>;
>       clock-names = "mclk", "macro", "dcodec";
>   };
> 
>   &lpass_wsa_macro {
>       clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK ...>,
>                ...;
>   };
> 
>   (similarly for lpass_rx_macro and lpass_tx_macro)
> 
> The intended fw_devlink dependency is therefore:
> 
>   lpass_va_macro  (consumer)  ──►  q6prmcc / clock-controller (supplier)
>   lpass_wsa_macro (consumer)  ──►  q6prmcc / clock-controller (supplier)
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
>   1. At boot (~t=0.085s), fw_devlink resolves the DT clock phandles
>      and creates fwnode links:
>        lpass_va_macro  ──fwnode──►  gpr/service@2/clock-controller
>        lpass_wsa_macro ──fwnode──►  gpr/service@2/clock-controller
>      q6prmcc does not exist yet → EAGAIN → fwnode links kept pending.
>      This is correct.
> 
>   2. At ~t=7.597s, remoteproc_adsp probe() completes. This triggers
>      device_links_driver_bound() which calls
>      fw_devlink_pickup_dangling_consumers(remoteproc_dev).
> 
>   3. fw_devlink_pickup_dangling_consumers() walks remoteproc's child
>      fwnodes. It finds the gpr fwnode with no struct device attached.
> 
>   4. Here is the incorrect assumption:
>      __fw_devlink_pickup_dangling_consumers() concludes that because
>      gpr has no struct device at this moment, it will never get one.
>      It marks gpr as FWNODE_FLAG_NOT_DEVICE and moves all of gpr's
>      consumers (including the codec → q6prmcc fwnode links) up to
>      remoteproc.
> 
>   5. The correct fwnode links (codec → q6prmcc) are permanently
>      deleted. Wrong device links (codec → remoteproc) are created.
> 
>   6. At ~t=8.364s, the GPR bus probes and q6prmcc eventually appears.
>      But there are no pending fwnode links left for it — the correct
>      dependency is lost forever.
> 
> The assumption that is wrong:
> 
>   "If a child fwnode has no struct device when its ancestor device
>    binds, it will never get one."
> 
> This assumption does not hold when intermediate bus nodes (glink-edge,
> gpr) are populated asynchronously after their parent device boots remote
> firmware. At the time remoteproc binds, glink-edge and gpr have no
> struct device not because they will never exist, but because they are
> waiting for the ADSP firmware to load — which only happens after
> remoteproc's own probe() returns.

The issue is in __fw_devlink_pickup_dangling_consumers(). When remoteproc
binds, it walks its child fwnodes and collapses any that have no struct
device at that moment, assuming they will never have one. That assumption
is wrong for nodes behind a remoteproc that are populated only after 
firmware boots

The fix is to skip collapsing a fwnode if it has pending supplier links,
since that is a direct signal from the DT that the node is intended to
become a device.

Could you test the patch ? Will send the format patch upon
getting ack from you.

--------------------------------0<---------------------------------------

diff --git a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -228,6 +228,9 @@ static void __fw_devlink_pickup_dangling_consumers(...)
        if (fwnode->dev && fwnode->dev->bus)
                return;

+       if (!list_empty(&fwnode->consumers))
+               return;
+
        fwnode_set_flag(fwnode, FWNODE_FLAG_NOT_DEVICE);
        __fwnode_links_move_consumers(fwnode, new_sup);


-- 
-Mukesh Ojha
