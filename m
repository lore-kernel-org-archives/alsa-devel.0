Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E124CD8C9D
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:32:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BC5460212;
	Thu, 11 Jun 2026 21:32:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BC5460212
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781206337;
	bh=wvlrq004J8XGxRTgYoOIMmtlpqVWK4U8EGi7tNg8gJU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UGjO8A0jlPHcATR61NgVBciF++3vo8A035HBFGsREHXyCfo4IgVBIuCgN26VJ5Lwj
	 vNrqm45KPJeoEg9W55uiNlQ4IbScLkhs2ARF+reeGxmhazudCkl3JFvjwqojDH9RAb
	 i84CA1NWSL0t8C2cBxWNshdf8/IJG32jEPvDwKmA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E82C4F805EA; Thu, 11 Jun 2026 21:31:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B2E38F8064C;
	Thu, 11 Jun 2026 21:31:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9B5C7F8058C; Wed, 10 Jun 2026 12:32:51 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781087570;
	b=V0uOUIQvQS47W2YwP0zPQ0hWcI+GYN0KSRrxWSxven0BXozFnJypACBpDmmZzH1T99Vh
	 1M+7Os7ShNfAbbLahK6ADzE3SDXIOv2EqwZYqFbYyHcnvP3UuE7Gsi/BcK/guN0mV3kPy
	 oIKRWJFJQ8o5cahYNd0HhbPvmVC2RneFrtPE+2RhAs04Xx2+4/C0NjGlZt+1xb64U0V8w
	 sxvNWJnS/+9o3ePYX1ZzXYWjVgyANONw7NQoqfNAIvJvfikJyJDkrCbtATYIbCjoY7onf
	 FrJthDaQOe3uJyl9JkPnMVbxq0hy83MCCEe6MDeYZqSSUxwQbjJufRJ2OK0WCqf4ekA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781087570;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:
	 To:From;
	bh=wvlrq004J8XGxRTgYoOIMmtlpqVWK4U8EGi7tNg8gJU=;
	b=cuUoYAV585e7hnFfNCUenwtI1CNqJbYC3kadIRwn7/bE01XuWX9bmlqeE5pJHVZ6PiXK
	 yfFIeH/3iKN/owmAm9b37RDzEuSXlijpjONWhWdi1IpxaHpvuL8dyFbUmkBZia5kL8WDK
	 V2Omr/G+07OfHz46sn4Z2i6jChBLaixKaUzL7U7qLbMUvCibP4dvtUreyGDC3v4gOsoz7
	 vK78MA2JWCKy7eazxhUIgUULPE8unWPVLGSlkao2PJCN2Yl9i9uP6Xbs5RtXnrHoUSMgz
	 pWAWJ7ULHTmCpAZnt8BSCFJozTdToOVuQAXma0nZ5+L3QXGI93andbUz/5tLzGLj/CA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="pR/iW+jS";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DGQFI5IE;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7F379F8011B
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 12:32:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F379F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=pR/iW+jS;
	dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DGQFI5IE
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65A7iUg2867590
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 10:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P1nO9gqkxcj5rweYoRc+yQuw1eVsJM6rSLrpMjihH/s=; b=pR/iW+jSYxIxDITG
	HIm+oeecOo3E1tCNzj2y9WMNcXOSzhzDpdpJd1ma4MM8xSCm0tSa+ApG6hGlZwP9
	7SRmpR5q0CscMkeZaK4IesngH+0m6hgnuwj/d1qiB7BAJMr9LKRi6ASj3LcTN1Gt
	7L9ltIFFTimg71VOq73Oxa0b1536UptgdJ9p+aygBHqoz1nlJShIqlpLNa4FogNk
	z926OGg0zpGWsmEObHnD7bEW3ElyAZvD6mlv+35DVXKpEj1JjILdcCFEqBm6e/l3
	4GRc8G7xxLHUAZzDhDpm8PjizufIDwrJRN/3+KWQ1Zcl2aLuGbVkhUP/5Ut6/+rd
	OaZThA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq0kd9d3d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 10:32:46 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9160006de85so4950385a.2
        for <alsa-devel@alsa-project.org>;
 Wed, 10 Jun 2026 03:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781087566; x=1781692366;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1nO9gqkxcj5rweYoRc+yQuw1eVsJM6rSLrpMjihH/s=;
        b=DGQFI5IEDTn7LmCBiX4zoW0bBnyZmD5pfGrluYYeBa1byU6xCbfSMuuo0wktuXPwn6
         sa9TamknqlRs981ftEnXM4TKPiZ/S9cU9STiT1SgBviALyb/mC7N9/HMQmNIQhhk0y2c
         L+9gXSUNEnXTFOVTMe+C6fUN3H7EIwGU5eb6dECLYlOQEeeApHqE5EOzr1D3K9UuWex7
         dnSD7zz424xEL4yUnX9zIqUCM+3TyS2u3Rea+n/LhLhOa8xOF7iPtdbrMtozxk/fCqE/
         iFudEzNYszA1WDzmcKTR/5/rOfR7xu/P4ZZhPmGIbXAUKWOY5FzstfW+ziA/ZDLU6A8M
         OcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781087566; x=1781692366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1nO9gqkxcj5rweYoRc+yQuw1eVsJM6rSLrpMjihH/s=;
        b=gitRNHJnlT0ZI7fXheKjSfhhn3tey+Ixd0Q5IWO4S0KFIGl/oWTqV7Jarz54FxU5h9
         GUwfeH3Wr3vVUGCR2bdncnkWx9w0EX2OQl+y/klkIsE0icdHhSYRV0wxYSHlUk5+i3Vz
         PNXJmXSvjOKkWDTW/ZjEdmr9VvAZtaw4NAG+B0PcR9eaX5uiOvcU8wxtEXdbRPfVRUkW
         5atISztkTgKjtkoJU2HmiArK2lPTFAbp0DAsaAiGV+XDsqkY66cIlSUx9C7SeGYGDRaZ
         jsyk27q7l8nf1a+c1ksT2TYABb9+lYUPCgdK1C03DsWOwwJCB82wH+9RfJ0eo1uqOOSJ
         FrsQ==
X-Gm-Message-State: AOJu0YyiptNgX2qPIqIeXlkSMHBi9G6zPLPL7/2E3tjqQoanhRabQk3C
	T4lEz4sU+tLobsyjwIV2b4Xzqxu3MG20MvEptyhxeWLfEVS7CljCiPRgqJjrJKZf1gbWkihsqqZ
	rqBCtZhqXojus08TiBZur4SVfIgMhoE88/wNWLs0Iv2pGQblSSTs8AbLkNBDrm0TGnQ==
X-Gm-Gg: Acq92OEOB/R4otIFd9l/N+K0qAvjqsWYxinRSdbiCyUeUFlGkxuj4hWMfaOUy6WV1Hi
	VevMtlqTv5cqA6FCEdZz3Chp3LK7CeQqybZ/9t5f8voNxbqK+j3Bzez0rwfCys39eKPqgiEwFyw
	Q5R9yMhAbrU9l39cW/7TYT8HxwXa+h7l4dzvupi3KhejpZu7zhX0y9qcXHftgXqAFqqO/se8HDW
	AEsap5UXspiKWy0Grvhg74Sr3FtalSQBQy9ewMDFXepf7L0GHj4w0BtNMMIx2wwlPVrcWZ3NM+k
	qF5muS9OmK3DcADXj5zltj9KaXFHluazxRIRKh5zZjZ35weyQsmgIHKClsqsSLKM03UFIvAjwAc
	w9YGUGWM3zNC5LVxpa67YYIDOrozGBpf/imoch1J5oQa7QFMO4vx60Jg3
X-Received: by 2002:a05:620a:6288:b0:915:4ca0:11f9 with SMTP id
 af79cd13be357-915a9df818amr2285212885a.7.1781087566367;
        Wed, 10 Jun 2026 03:32:46 -0700 (PDT)
X-Received: by 2002:a05:620a:6288:b0:915:4ca0:11f9 with SMTP id
 af79cd13be357-915a9df818amr2285210485a.7.1781087565913;
        Wed, 10 Jun 2026 03:32:45 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6912365bd3fsm6191618a12.5.2026.06.10.03.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 03:32:45 -0700 (PDT)
Message-ID: <0a578098-7003-4048-9c29-affb632c44c9@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 12:32:43 +0200
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5c57153a.79.19eae7e2814.Coremail.ks002278@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TeamcxQh c=1 sm=1 tr=0 ts=6a293d4e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=onwFKEomLvbxLXU0c08A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: jo_6sgExLnLPOt8MHDY7SW9zFhjLjuZn
X-Proofpoint-ORIG-GUID: jo_6sgExLnLPOt8MHDY7SW9zFhjLjuZn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA5OSBTYWx0ZWRfX4lnaWzZPBMdd
 wRm0c8DJ9XLY7bKXDyiiE1ws5fw9LjiGdNkwDDwWgDb1GA30I0701Z/rcUk9Z2dn320m/wxwh7u
 lOQTiTkoimtYAoRu6YDoXnuXT9i8vappinb5Tn52aQKxM0CcvN+eUytiXE6lGehbLOwSGKcdPre
 ccs88gP4j3tHDK6DYmdba5gSj1lHiNxKNglt4GC9IhTHw7iC/EN7si/F29q3kp1l1mYpQoOJHmX
 jDiObCAg9Id6cDRQiiCi84Wn/pyOUnJNLzI52xgEkSS8SM+zedpSJzGvKLNkxIdcMTwx95gTs2+
 kxAQk5UcglyPOlfeUbyJV0WRkMjpxa6UgfuczrWS0qFUW2vvINcQYeNMGC6lW9UbrIT91H5IddA
 UBQQaG78YadSlo/w1u4cItJq8iOEca5WRokJjD8xPjnB9uBJDN8wreZIiwGzig355CDt7ecbgwx
 FlilQ6nybl7uFUd5xrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100099
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: FQGHEA46ZNHOZQIS2T2VEHRPLDKR5RLL
X-Message-ID-Hash: FQGHEA46ZNHOZQIS2T2VEHRPLDKR5RLL
X-Mailman-Approved-At: Thu, 11 Jun 2026 19:31:20 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FQGHEA46ZNHOZQIS2T2VEHRPLDKR5RLL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 6/10/26 12:26 AM, thomas.kuang wrote:
> 
> 
> grep ^ /sys/class/remoteproc/*/state
> /sys/class/remoteproc/remoteproc0/state:offline
> /sys/class/remoteproc/remoteproc1/state:offline
> 
> 
> grep ^ /sys/class/remoteproc/*/name
> /sys/class/remoteproc/remoteproc0/name:adsp
> /sys/class/remoteproc/remoteproc1/name:cdsp

Try writing start into > /state

This will attempt to power on the DSPs, most importantly the A(udio)DSP
which is necessary for audio to work. If that fails, check dmesg as you
may be missing some firmware files.

Konrad
