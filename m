Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DCFC43327
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:18:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E607E60258;
	Wed,  1 Jul 2026 15:18:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E607E60258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782911919;
	bh=oS3CBo1q1lmJJDf+N/At33hQ2EF0fdx9bJ33RnNU7EM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=UAHJu7CW+N/dVVx3NE9BVfqY5n41WR93ltbiyVisHqCKOdHtC0FiTPVun3RIz6XHx
	 75EZ0SJ1ntM8xa1AZ9en2Zzk7blxM8mT+Nbe9AT9YiABT2REBueWJGoFm3PmLtUzN0
	 U9eRDKOia4ffP99HG0BZ+iJuE9KzYqlwfRf+laTI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9A26F805F2; Wed,  1 Jul 2026 15:18:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 62C0DF80601;
	Wed,  1 Jul 2026 15:18:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2990EF804D6; Wed,  1 Jul 2026 15:17:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782911875;
	b=S2HGmp8kydppJ/aMikFOiv0QcOKzQauCv7KJBTPtnrZQIEz7sR08NgPNVSl9Ckxkb6b2
	 9m02GS6keAShySRPygnFPb8C6NyW/EuUzihfIo6oI/iuoN5PUIpakpG9iujUqXJvFa+bT
	 2mMuVfqZbKsfFBJD/JWOgzRl3396XRg3FdpRrOLaUPp+AksqN3tx2VXouObPSNJPueKjL
	 /hNgKmdL3W0v1wRBSk7S/b3FaB/WKRsIDIUejg3/0Ey2i6WKNHcE6RlY+qiNUm1Pt9pSK
	 Pfn8ONMZQUyKhXA8RXzz1xOXfvXsQtSnjZJDuL6QEmzu9+jl5C5k6Y4vjav0K1G8XiQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782911875;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-Id:
	 MIME-Version;
	bh=oS3CBo1q1lmJJDf+N/At33hQ2EF0fdx9bJ33RnNU7EM=;
	b=Kz0AXhmPGqM6A9VohtZf6nrOCatAVBlsJ3YokRpDgCte4ocsqavK7SbA46V1wZ6NN6sW
	 ckJtD/3wXcIb4HfF3b7DG6vv+yEVV2wlftpC5s0gdbQl8Lvh2B1R6YqWr45HyicfG23xY
	 QD3MakTQ2BzTiT3xqTDcsomwTnyqRCP2YtmQx6XcUWH61NaLA1RfRcBkHtg91t3lrJ2c7
	 /9zUiNPWrDJ2Un2LyxvaJak/0KPWW6+B94pmJZ7rbZflXjWDg8E9ZzTipPhzuJfRDShbo
	 SI9xxvsHcnWuHmDx5oElxGA63pvA8CYIbaBckExly5eo/WILUFzd5GYOs/tsUI0fiZw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ae8E8GKB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YjCDdaRv;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 943E0F8016D
	for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2026 15:17:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 943E0F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ae8E8GKB;
	dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YjCDdaRv
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A8iah683268
	for <alsa-devel@alsa-project.org>; Wed, 1 Jul 2026 13:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6zWJR/XvOS2g99/3fxQtqx
	gY2PDjdlFCf+hyY8K1DZo=; b=ae8E8GKBKOHu0YsoB733x/HRCNGsG3gOA99e/w
	p57n38MqKVrpD2uXpG9+ZJfknRcah1kDnCxAlw5SavYXeMBuQve6iTuSiDe3nTZd
	6wPgvOKuqQ0fPo1EOKTxwIcPXa2UEELml09ZGnd+LNswXehixKunBD8QfDvo2pGM
	+NRlsDbuoX7dxNdetnqKrgAAEFLpNyPfaHjdiP2GT2C3xAdqeQ8H60Jv39jzMJPr
	PeoH94V/7fT74VGb0ho5JHPPQLWsen1wr5PE1ju6oW9mshhG0V6LrGWdGS9uzid0
	2OV07B3eMYu59tnjiRnBajPM0ehTccUKGqjwLp1RMrGH/uUg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqmed8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Wed, 01 Jul 2026 13:17:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c9a700dc0eso6004445ad.1
        for <alsa-devel@alsa-project.org>;
 Wed, 01 Jul 2026 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782911871; x=1783516671;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6zWJR/XvOS2g99/3fxQtqxgY2PDjdlFCf+hyY8K1DZo=;
        b=YjCDdaRvy822aLj8v/lsrMNpRGF2ZE8PDnx8EAO7aDTEtYCB82FoZE2NSiMbhM16L0
         EFwbuipNTnUJAlTovj18NHiAQoAZgU4que4uQHnO2APCoFeR4+P63Zf/U3N35m8jvAtz
         7X3VFllCNj6OKGzFRV1+rHnR+3QsLza+c5JLG4P7V/FSDBo3Pt1LPm7P9RW2Tfh9N+9Q
         jHg+LI4H8ahstycNbhtTYtG1tfOeysyTC9yymlWHES7iELnDUlkFi5ss007RPZ+ykVA5
         mgPABK1OnO+l7F0tRa4/mutg+28JH7y0hLqIIbKUd0MSUcctOfaEWjwhk7yHXeTh/xKL
         jZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782911871; x=1783516671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zWJR/XvOS2g99/3fxQtqxgY2PDjdlFCf+hyY8K1DZo=;
        b=gFvgE5DluYYJTknhWlG9jDJ+N2RthKtu6SEachF11HegzZSh490+BR6kjIrbyzR28Y
         yl+M0u4PMOZ5fxX9SK+MJSJ6pn7aeCQ/0dPqEBd+cV9VbA+jZsGSvS6cd41R/9R4R4/U
         B819ET6L/72TEZPX4YoVl6+a9jb6fmCTKQ1bCzwSFDF3cJ9l9aZIuWnYdPMfjdMo2jBD
         CHXdH3gw2Bxdqyn4IxqFzuuc6T6toIFXgvCBwogkBqUy6Dnx5kx8AYBLQMtEQtsOPkf1
         aWNs68Xcc2zR62aetOnNAS4ygjgnErVNS6Q+XnVBVS6dk/Su2XnA+RUB6vM9rE82IvOF
         Vfbw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqB14kQHgb2NDqT4nO/jp3UhMXhFD/l8ci+JGEMutMLa+bdkJA0DV580Uowv/6hbBGw6P6pHqSVNp4w@alsa-project.org
X-Gm-Message-State: AOJu0Yxj0iKr0MRPQ8GLqpFSKl1LR9g9Jf3yKph5PiTNA33lito650WY
	ybALCcLI+mcMxOeP0GYywoxYfehaye+ON73v1IBTglIbyddahKhMkODCCPwVKD9C6zDEnSMvlJC
	kCjmDQ/by6Olgj3bf51WAh5DX7qOeWWvZMP7c3Qo6bbWET5st+ZGH3kwP8sfQycYRJw==
X-Gm-Gg: AfdE7ckPYhYiMGWb6PSU1q8PY2K7RP4ZPEkO+ButIxY3dgqfygqQja20GluFh67+Pq1
	A8+zCdKLSH54TuMSrNXawfMyeFNnxyK58dC4y5PCI7J2NPRSXMIR8JwWo5qObuHCjg5OIZnhfK4
	jJPHpDdhAzGxdIvu/XBMUi/gXnMU7GGGsC0ONuaSWLVgnFxeMh0NnEjHZvvh0A6y5k9qksDQZmm
	8zxVDDpWK2Cu53EElJr9CiSxke73V45KwL1gwZwJSUfDQDhF+xPmPOQ2MfGCy2BwA6uzj+372le
	ygd3WhVQHZ871sfvP0vOXtMSldgSZhv2zw0PuUrfQDnhYHWioJ84QYNHmyDsZGx557VH+G0GKPO
	RWHdDC56t3byBHXKMlJMqyf4LIVIt4UK/se0XShM=
X-Received: by 2002:a17:903:26c8:b0:2c0:b932:866e with SMTP id
 d9443c01a7336-2ca7e8c38b5mr17166655ad.27.1782911870458;
        Wed, 01 Jul 2026 06:17:50 -0700 (PDT)
X-Received: by 2002:a17:903:26c8:b0:2c0:b932:866e with SMTP id
 d9443c01a7336-2ca7e8c38b5mr17166075ad.27.1782911869694;
        Wed, 01 Jul 2026 06:17:49 -0700 (PDT)
Received: from hu-nandam-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca382bb30dsm31928075ad.68.2026.07.01.06.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:17:48 -0700 (PDT)
From: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
To: linux-kernel@vger.kernel.org, Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        spatakok@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, ravi.hothi@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com
Subject: [DISCUSSION] fw_devlink: incorrect ancestor fallback for intermediate
 bus topologies breaks audio dependency resolution
Date: Wed,  1 Jul 2026 18:47:33 +0530
Message-Id: <20260701131733.870079-1-ajay.nandam@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5NfBLTgHoD5IKk_aNgGIJ02u6aTu_5hz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDEzOCBTYWx0ZWRfX256G9yw9UpQr
 EGJBQHnF0TipyO+iEm8L7kdc2PVsxZT11OSdb3/rwxiSb800aJ3/JxQJvkTPacR3irKri+SAMWq
 rBiYcoTIFddxF9QPjxWsnjzlIsLeKFPyE3VehhnRBmVPLYV0BYWdjyJ1Itll3EhKG4UyHSz2nxX
 iv9oUY3VnKnIAHVUPSEvnFBN+IAvJh2OPQl9aywAv6DKw9K3gUkOn59t+BhNt8m45TlkNqAYSvy
 5S3ExfBEcs+IjB1sZE+M82yWzhQ2OmJZcVu0bovKXw1I1/ITBgz8Hru3nuCml+/pdkDcMKGmPbA
 eekjyQdaBecUuoImfvgrrbZ74jWI9vbD5QdCnKu6YrVU/bUgLe9BicBX4bxPymxVDe+xI6+sac5
 UGSZ1s42EupoyF2b2QlMYQvNMmTB0uHHQ/uAiyETJhyHsPXjSA1xQguDdSd1Cn8A5+zdUy6CBvy
 EP31WFvV5X/HZnnnBZQ==
X-Proofpoint-GUID: 5NfBLTgHoD5IKk_aNgGIJ02u6aTu_5hz
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a45137f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=P-IC7800AAAA:8 a=HdUZe8yIVH1zskT_ylQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDEzOCBTYWx0ZWRfX6cj7hAYqe8yP
 F0JNjtD8SY8SyiuYxKxUriVXSmRCVU7FUw1fXcT+NzWgZGobjJoeDkdfsAo+iYz9uJaQiLI++9O
 FWbsVVBwuAqCvPp6dKT5y7FyfKuG7YU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010138
Message-ID-Hash: NURQK6YYGDQ2QFA3W44UU4JI4MPBJKHF
X-Message-ID-Hash: NURQK6YYGDQ2QFA3W44UU4JI4MPBJKHF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NURQK6YYGDQ2QFA3W44UU4JI4MPBJKHF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Saravana Kannan,

I am Ajay from Qualcomm, and I am working together with Ravi on ADSP
Subsystem Restart (SSR) support for Qualcomm LPASS audio. During our
SSR work Ravi observed that restart does not behave as expected — when
the ADSP restarts, all child nodes of the remoteproc should detach and
re-attach cleanly once the remoteproc is up. While investigating
this, Ravi identified an incorrect assumption in fw_devlink's dependency
resolution logic that causes wrong device links to be created when a
supplier device lives behind intermediate bus nodes that are populated
asynchronously. We observed this on a Qualcomm qcs6490-rb3gen2 board
with LPASS audio drivers, but the assumption is generic and can affect
any similar topology.

Problem Summary:

fw_devlink appears to incorrectly collapse pending dependencies to
an ancestor device when supplier devices exist behind asynchronously
created intermediate bus nodes.

In our topology, q6prmcc is instantiated as a descendant of the ADSP
remoteproc through asynchronously created glink/gpr bus devices.
When the remoteproc device binds earlier, fw_devlink appears to assume
that these intermediate nodes will never become devices, collapses the
dependency to the remoteproc ancestor, and deletes the pending links.
As a result, the intended dependency:
    lpass_va_macro -> q6prmcc
is replaced by:
    lpass_va_macro -> remoteproc

This results in incorrect teardown ordering during ADSP SSR because
codec drivers are no longer linked to their actual clock supplier.

Could you please suggest how we can resolve this issue? Is there
a specific reason for this assumption, as it looks incorrect in our case?


-------------------------------------------
1. AUDIO SYSTEM TOPOLOGY ON qcs6490-rb3gen2

On qcs6490-rb3gen2 the LPASS audio clock supply chain spans a
four-level device hierarchy rooted at the ADSP remoteproc. The
intermediate nodes (glink-edge, gpr) only get their struct devices
after the ADSP firmware has booted, which happens well after the
remoteproc driver's own probe() returns.

The Device Tree hierarchy (from qcs6490-audioreach.dtsi / kodiak.dtsi):
https://elixir.bootlin.com/linux/v7.1/source/arch/arm64/boot/dts/qcom/qcs6490-audioreach.dtsi#L113

  remoteproc_adsp                         (ADSP remoteproc)
      └── remoteproc_adsp_glink           (GLink transport edge)
              └── gpr                     (GPR bus, compatible="qcom,gpr")
                      └── service@2       (PRM service, compatible="qcom,q6prm")
                              └── clock-controller  (q6prmcc)
                                      compatible = "qcom,q6prm-lpass-clocks"

The LPASS codec drivers (VA macro, WSA macro, RX macro, TX macro) are
platform devices under soc@0 that reference q6prmcc as their clock
supplier via DT phandles:

  From qcs6490-audioreach.dtsi:
  ------------------------------
  &lpass_va_macro {
      clocks = <&q6prmcc LPASS_CLK_ID_VA_CORE_MCLK ...>,
               <&q6prmcc LPASS_HW_MACRO_VOTE ...>,
               <&q6prmcc LPASS_HW_DCODEC_VOTE ...>;
      clock-names = "mclk", "macro", "dcodec";
  };

  &lpass_wsa_macro {
      clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK ...>,
               ...;
  };

  (similarly for lpass_rx_macro and lpass_tx_macro)

The intended fw_devlink dependency is therefore:

  lpass_va_macro  (consumer)  ──►  q6prmcc / clock-controller (supplier)
  lpass_wsa_macro (consumer)  ──►  q6prmcc / clock-controller (supplier)

This dependency is critical for correct ADSP SSR (Subsystem Restart)
teardown: all codec drivers must be torn down BEFORE q6prmcc is
removed, so that no driver calls into a clock controller that no longer
exists.

-----------------------------------------
2. THE INCORRECT ASSUMPTION IN fw_devlink

fw_devlink correctly identifies the intended supplier at boot time via
fwnode links. However, the links are never converted to device links.
Instead, fallback device links to the remoteproc device are created.

The sequence of events:

  1. At boot (~t=0.085s), fw_devlink resolves the DT clock phandles
     and creates fwnode links:
       lpass_va_macro  ──fwnode──►  gpr/service@2/clock-controller
       lpass_wsa_macro ──fwnode──►  gpr/service@2/clock-controller
     q6prmcc does not exist yet → EAGAIN → fwnode links kept pending.
     This is correct.

  2. At ~t=7.597s, remoteproc_adsp probe() completes. This triggers
     device_links_driver_bound() which calls
     fw_devlink_pickup_dangling_consumers(remoteproc_dev).

  3. fw_devlink_pickup_dangling_consumers() walks remoteproc's child
     fwnodes. It finds the gpr fwnode with no struct device attached.

  4. Here is the incorrect assumption:
     __fw_devlink_pickup_dangling_consumers() concludes that because
     gpr has no struct device at this moment, it will never get one.
     It marks gpr as FWNODE_FLAG_NOT_DEVICE and moves all of gpr's
     consumers (including the codec → q6prmcc fwnode links) up to
     remoteproc.

  5. The correct fwnode links (codec → q6prmcc) are permanently
     deleted. Wrong device links (codec → remoteproc) are created.

  6. At ~t=8.364s, the GPR bus probes and q6prmcc eventually appears.
     But there are no pending fwnode links left for it — the correct
     dependency is lost forever.

The assumption that is wrong:

  "If a child fwnode has no struct device when its ancestor device
   binds, it will never get one."

This assumption does not hold when intermediate bus nodes (glink-edge,
gpr) are populated asynchronously after their parent device boots remote
firmware. At the time remoteproc binds, glink-edge and gpr have no
struct device not because they will never exist, but because they are
waiting for the ADSP firmware to load — which only happens after
remoteproc's own probe() returns.

https://elixir.bootlin.com/linux/v7.1/source/drivers/base/core.c#L1300

------------------------
3. EVIDENCE — DEBUG LOGS

We added debug instrumentation to fw_devlink's key decision points
(filtered to audio devices only) to capture the exact sequence.

--- t=0.085s: Correct fwnode links identified, q6prmcc absent ---

  [0.085060] debug: fw_devlink_create_devlink:2356 audio supplier
    /soc@0/remoteproc@3700000/glink-edge/gpr/service@2/clock-controller
    not yet a device, deferring link from consumer=3240000.codec (EAGAIN)

  [0.086178] debug: fw_devlink_create_devlink:2356 audio supplier
    /soc@0/remoteproc@3700000/glink-edge/gpr/service@2/clock-controller
    not yet a device, deferring link from consumer=3370000.codec (EAGAIN)

  Both codecs correctly identify q6prmcc as their supplier. q6prmcc
  does not exist yet → EAGAIN → fwnode links kept pending. Correct.

--- t=7.597s: remoteproc probe completes ---

  [7.555169] qcom_q6v5_pas 3700000.remoteproc: debug: qcom_pas_probe:745
    qcom_pas: probe start, parent=soc@0
  [7.597126] qcom_q6v5_pas 3700000.remoteproc: debug: qcom_pas_probe:865
    qcom_pas: probe complete, parent=soc@0

--- t=7.597s: POINT OF NO RETURN ---

  device_links_driver_bound() fires for remoteproc. It calls
  fw_devlink_pickup_dangling_consumers() which finds gpr with no
  struct device and moves ALL of gpr's consumers to remoteproc:

  [7.597160] debug: __fw_devlink_pickup_dangling_consumers:276
    audio dangling consumers: moving consumers of
    /soc@0/remoteproc@3700000/glink-edge/gpr
    to ancestor /soc@0/remoteproc@3700000 (no device yet)

--- t=7.597s: Correct fwnode links permanently deleted ---

  [7.597205] debug: __fwnode_link_del:155 audio fwnode link deleted:
    consumer=/soc@0/codec@3370000
    supplier=/soc@0/remoteproc@3700000/glink-edge/gpr/service@2/clock-controller

  [7.609265] debug: __fwnode_link_del:155 audio fwnode link deleted:
    consumer=/soc@0/codec@3240000
    supplier=/soc@0/remoteproc@3700000/glink-edge/gpr/service@2/clock-controller

--- t=7.637s: Wrong device links created ---

  [7.637952] debug: fw_devlink_create_devlink:2331 audio device link created:
    consumer=3240000.codec supplier=3700000.remoteproc flags=0x124
    (consumer_fwnode=/soc@0/codec@3240000)

  [7.674145] debug: fw_devlink_create_devlink:2331 audio device link created:
    consumer=3370000.codec supplier=3700000.remoteproc flags=0x124
    (consumer_fwnode=/soc@0/codec@3370000)

--- t=8.364s: GPR bus probes — 770ms too late ---

  [8.364221] qcom,apr ...: debug: apr_probe:597
    apr/gpr: probe start, parent=3700000.remoteproc:glink-edge
  [8.364446] qcom,apr ...: debug: apr_probe:648
    apr/gpr: probe complete, parent=3700000.remoteproc:glink-edge

  GPR bus probes 770ms after the fwnode links were deleted. q6prmcc's
  consumers have already been stolen. No pending links remain.

--- t=15.409s: VA macro binds — wrong supplier confirmed ---

  [15.389975] va_macro 3370000.codec: debug: va_macro_probe:1538
    va_macro: probe start, parent=soc@0
  [15.399678] va_macro 3370000.codec: debug: va_macro_probe:1683
    va_macro: probe complete, parent=soc@0

  [15.409155] debug: device_links_driver_bound:1420
    ENTRY dev=3370000.codec (struct parent=soc@0)
  [15.418101] debug: device_links_driver_bound:1426
    ENTRY supplier link: dev=3370000.codec
    supplier=3700000.remoteproc (fwnode=/soc@0/remoteproc@3700000)
    flags=0x164 status=2
  [15.434076] debug: device_links_driver_bound:1426
    ENTRY supplier link: dev=3370000.codec
    supplier=33c0000.pinctrl (fwnode=/soc@0/pinctrl@33c0000)
    flags=0x164 status=2

  q6prmcc is completely absent from the supplier list. The device link
  to remoteproc is wrong. The correct dependency is permanently lost.

------------------------------------
4. IMPACT — ADSP SSR TEARDOWN BROKEN

With the wrong device link in place (codec → remoteproc instead of
codec → q6prmcc), the teardown order during ADSP stop is incorrect.
q6prmcc is removed while codec drivers still depend on it, causing
them to call into a clock controller that no longer exists. Audio
drivers are left in an invalid state and proper cleanup does not happen.

----------------------------------------------------------
5. WORKAROUND — MANUAL DEVICE LINK IN q6dsp-lpass-clocks.c

To confirm the hypothesis and restore correct teardown ordering, we
manually created the device link from q6prmcc to lpass_va_macro inside
q6dsp_clock_dev_probe() in sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c.

With this workaround in place:
  - The correct device link (lpass_va_macro → q6prmcc) is established
    when q6prmcc probes.
  - On ADSP stop, lpass_va_macro is torn down before q6prmcc.
  - Audio driver cleanup happens correctly and completely.
  - No dangling state is observed after ADSP SSR.

This confirms that the dependency model itself is correct — the problem
is purely that fw_devlink fails to establish it automatically due to
the incorrect assumption described above.

The workaround patch is included below for reference.

--- Workaround patch (reference only, not proposed for merge) ---

diff --git a/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c b/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
index 03838582aead..3884d3e96e33 100644
--- a/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
+++ b/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
@@ -8,6 +8,7 @@
#include <linux/device.h>
#include <linux/platform_device.h>
#include <linux/of.h>
+#include <linux/of_platform.h>
#include <linux/slab.h>
#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
#include "q6dsp-lpass-clocks.h"
@@ -126,6 +127,52 @@ static struct clk_hw *q6dsp_of_clk_hw_get(struct of_phandle_args *clkspec,
  return ERR_PTR(-ENOENT);
}

+/*
+ * va_macro_compat - compatible string for the va macro codec device.
+ *
+ * Used to locate the consumer device for the manual device link.
+ */
+#define LPASS_VA_MACRO_COMPAT  "qcom,sc7280-lpass-va-macro"
+
+/**
+ * q6dsp_clock_link_va_macro - create a manual device link from va_macro
+ *                              to this clock-controller (q6prmcc).
+ *
+ * fw_devlink cannot establish this link automatically because q6prmcc is
+ * a dynamically created device (child of remoteproc/glink/gpr) and its
+ * fwnode link is purged by __fw_devlink_pickup_dangling_consumers() when
+ * the remoteproc parent binds. This manual link ensures va_macro is torn
+ * down before q6prmcc on ADSP SSR.
+ */
+static int q6dsp_clock_link_va_macro(struct device *clk_dev)
+{
+  struct device_node *va_np;
+  struct platform_device *va_pdev;
+  struct device_link *link;
+
+  va_np = of_find_compatible_node(NULL, NULL, LPASS_VA_MACRO_COMPAT);
+  if (!va_np) {
+    dev_dbg(clk_dev, "va_macro node not found, skip devlink\n");
+    return 0;
+  }
+
+  va_pdev = of_find_device_by_node(va_np);
+  of_node_put(va_np);
+  if (!va_pdev) {
+    dev_dbg(clk_dev, "va_macro device not yet registered\n");
+    return 0;
+  }
+
+  link = device_link_add(&va_pdev->dev, clk_dev,
+             DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOPROBE_CONSUMER);
+  put_device(&va_pdev->dev);
+  if (!link) {
+    dev_err(clk_dev, "failed to add device link to va_macro\n");
+    return -EINVAL;
+  }
+
+  return 0;
+}
+
int q6dsp_clock_dev_probe(struct platform_device *pdev)
{
  struct q6dsp_cc *cc;
@@ -180,6 +227,10 @@ int q6dsp_clock_dev_probe(struct platform_device *pdev)

  dev_set_drvdata(dev, cc);

+  ret = q6dsp_clock_link_va_macro(dev);
+  if (ret)
+    dev_err(dev, "Failed to create devlink between prmcc and va macro\n");
+
  return 0;
}
EXPORT_SYMBOL_GPL(q6dsp_clock_dev_probe);

--- End of workaround patch ---

Tested on: Qualcomm qcs6490-rb3gen2, Qualcomm sm8750-mtp

Thanks,
Ajay Kumar Nandam
