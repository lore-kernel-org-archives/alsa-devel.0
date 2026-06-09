Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC34ACD8CAA
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:30:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB6B460218;
	Tue,  9 Jun 2026 13:30:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB6B460218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781004635;
	bh=1Uc0kX1/3vX3z8Oj1M3cStKT+Ox2ekhfaIbrJowIJkw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SWEj3MKJA07iQpA0xIEwRJTamLy7Am2cK9FJIxqVyteJYFmBSmhSubIc9j25n9lYE
	 7h2/EkgTPB583DCc297tG/EB7ABU+chkU/rY9Wh2teddxJdG9/y9rM+S83qD8XJAtj
	 uPqLU4tus8ZH7kNBGPZO0ImuxM8VT2YsBzw4swPU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C597FF8060A; Tue,  9 Jun 2026 13:29:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 57ECFF80607;
	Tue,  9 Jun 2026 13:29:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67BA5F80496; Tue,  9 Jun 2026 11:25:06 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780997105;
	b=RjOgohOolEyrRY5CjJb8Cx6TIqUpfsvP1CMHzTQG+qXLvSeCczjmu36zFnsc/VugCGS1
	 000+Htzk4pTE77Y5/BlWpelOxRYBCk6gOQ0A+9NV/WiKvY2hC4xLjDtfsGAhVuYZiEHT3
	 efl8Ly2L7XqDc1I1TtP3uVd9hA8SdDpAQdYI/8M6oeF24rwnGfenii4tjcN8m/VDGh4yM
	 DQCMFIKqyad4tGMRCmiyZStUGdvW58yi3D8rcz23J8Kr3S1snexlOhDXkuaHPMvY9GlWW
	 AksD5AFl8XjqJwZgRyIDmkVuIWLTGnIbRhjaQvLaEuAJp1Hacr+0UdBIxSvJ4sN+btQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780997105;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:
	 To:From;
	bh=1Uc0kX1/3vX3z8Oj1M3cStKT+Ox2ekhfaIbrJowIJkw=;
	b=Ttan/plQ1BZoDKBeViQEFKlDMqzy6DGpBaE+tnJaQ7Gacv0jyBwxS8k6LoUozaNUkJJm
	 hNvrOPfP7+NGxNWiiEoNkjfueViu3i/UDuhcyyxbeMamq7+LyqgCEYOl1rLMK709Gr3Vx
	 MyTbiHFIG5rYR4hC8gWAbxTZjWg5Z6kj4/SgqOb2YES9kc1h4TnaHlrPJkFarqmGJfqc7
	 EEnEVq26n4IRY2XjmaQpIfObdMxx3k3JVvnRQGL2WKyOczpMyi3gU5qv4+PGcD46o3MGz
	 Ia8i1MMKm/BavNWAYJ6xQXeR+z/TAOrV/POaCyJEXxEj567qug2P71DXx/w7kugkkFA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=mtOpoQ26;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CoZWNNvP;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 48356F801F5
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 11:25:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48356F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=mtOpoQ26;
	dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CoZWNNvP
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6597rda31958626
	for <alsa-devel@alsa-project.org>; Tue, 9 Jun 2026 09:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/I+g36BXwfvLsFz5BGL7sHl1r0FpctHV8PV0utNTXoE=; b=mtOpoQ2685OL8tV3
	W2eoZY4qxUsVs8+TZQ9Lf84A/Bfqm4yisZbqxqEHJ86+tmnzXnUeLbSEjzKtgxBE
	t61mMu3rYz0esnICaP+yDUbW+zyEI+We7fpDJSh60KlXoSB15gwRRsOkmK9sRsyt
	g7yIqfKpcHy34IbsvQhDaQrVXOvG93pSKK3YlePIaytbRQI4xKKKqyJ0nSKtkUK0
	Qvq6lcSpktoiQ0NyVvLRm6fvKz2zxfmczbS49GQLBiooWYB6JYNDypcFkQ79Gu/0
	cOUSOMG7BKLfjzr9oTAPaaGnsPX4/pdxqNPXNhp9pX8CgqBN7BfrmrckBCYjoGz5
	OFVItg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epdds8srm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2026 09:25:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91550f68e7cso142750785a.3
        for <alsa-devel@alsa-project.org>;
 Tue, 09 Jun 2026 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780997101; x=1781601901;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/I+g36BXwfvLsFz5BGL7sHl1r0FpctHV8PV0utNTXoE=;
        b=CoZWNNvP1wgaRzxmum6pHRdDvFvgq4h0S4wdW22YYJfGQe958fRL9/688eG6x64V6H
         jut1c8v0NLHxGl0dua2Bsx3T0KOBCzSMETDU/8IytZWcAgI11YYf3xKwq+es/bNbOP/o
         /wcvR9lI+qKj9W4NMwc9Z4TIydpQVx6YpphQ3yuIel8cz0I6Rk1w1wAXYplFUUulSPY5
         ZAA7mBWNX+hBu8nKqzAEtBGq0eN+37JMfyNuKGsPuWtIjQTuz3ACQhI/kZpdi0kjpflF
         fXvqYXvbISp3TnZJ4UZqzDKretaqtINgUBD6FO04GQ36A++BbpLGVfiv0nbArREWxOCP
         9tUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780997101; x=1781601901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/I+g36BXwfvLsFz5BGL7sHl1r0FpctHV8PV0utNTXoE=;
        b=JDEcCbXOIfM//9QgbmufV3S11E/x6Mf+c+3iSR6m+qmRnfZvFJOk1wWsK7uOWOeqZE
         B44hdNd0aLMrhmBzTlg2PeWqNLwbswgn9HnVC9urlNwK0HpWqXbXVhIXiGeKSG2IngdN
         FzjKmWn0n3G92TANjnKtDV4SNUO/9Yyz3ZrPVogqfII0Uq7hLZF9Ag5cCEiBfDo+VM5d
         F2o/vfW63kVDgIqoFm1ukFQ28EroskkIjvRzNnqBBaE1GgJbM02Nb/MH4iYaCi6+uw1u
         TqYMYK9CjYlbaytdGYIlvsHi8wA4ahA+DuMACYrWJkZfIgYMI/HbbcJkWzvr5SHnTdlm
         bT0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kwiIxeeTfV8zUITZFlL3ADbrLZa0duiDA+BSKH3wkEUDDXGNs7Xf3Dge0UrkbOeFgmqz3bv07ITmT@alsa-project.org
X-Gm-Message-State: AOJu0YzL3W2I/iDGJMjj1DlUZNhm/XgCu3J4CQKyba3YNiPcIlqM0CWD
	s01GyZE1Zaj98Vi2Sj+L7oD9y5twwr6cclTH5XTKmcQTfs7MYi1Y22QzuagF/0gwy4dBg2kyhik
	iYNbNO1o2qFWM1N3SiHd6BwcQtz4CYRwPfkRVS6/aNa3svlZdgtiOsXlHIF9J5ZGvjw==
X-Gm-Gg: Acq92OFICVhmvbaBvXIYCYFmaQX2a20LSC6wYBtOCJ1jMvIVlJ6guBvLEYrJp+ZI+M+
	mrBB4SdFyQI/zTecCDE8SgVEYmUrIzbXmeyf9D3SdY6dX7YsFuNPofcd1FMVJVEby2+sGOhhBB8
	KPc5lApwsTtIC+yr9QpX+Clo5sv0WOiUBdTMl8OVv+yCdbK6dvT4ZpROVw+A1fjNNCHPTZBfkct
	HWeZUHtulrxbv0QILaIB9fEf9hUTys0cM11o0MPIOdVWSZI5BAaril7u14dgamMAt/B8DJtoP7G
	iW18mfXxnk77GpLYljJt2toWDo1FV0BiWnyURI68Q86f+YVwlmUGOMn/0eQV/Bz9zfhW03ClYAF
	l0ZXSO6WDv0wG7F4zGdTmSwL3mKs4+BKqPOPT00ESLyuh/X37GmlOyk1i
X-Received: by 2002:a05:620a:28cc:b0:8cf:d953:b4ec with SMTP id
 af79cd13be357-915a9d5afd0mr1932135085a.3.1780997101505;
        Tue, 09 Jun 2026 02:25:01 -0700 (PDT)
X-Received: by 2002:a05:620a:28cc:b0:8cf:d953:b4ec with SMTP id
 af79cd13be357-915a9d5afd0mr1932132285a.3.1780997100955;
        Tue, 09 Jun 2026 02:25:00 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0517714c5sm1018106666b.2.2026.06.09.02.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 02:24:58 -0700 (PDT)
Message-ID: <3c28dd62-223c-4447-8cec-c7c527aa49e3@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 11:24:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [alsa-devel] [BUG] Lenovo ThinkBook 16 G7 QOY (Snapdragon X) - No
 soundcards detected
To: "thomas.kuang" <ks002278@163.com>, alsa-devel@alsa-project.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5fc3ab80.a3e2.19ea717f09f.Coremail.ks002278@163.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5fc3ab80.a3e2.19ea717f09f.Coremail.ks002278@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MOGvOabDgbYrgq4F7j4Kcpscqux5U_i0
X-Authority-Analysis: v=2.4 cv=EI42FVZC c=1 sm=1 tr=0 ts=6a27dbee cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=0t5lN559Mg9gQR7Lf2AA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: MOGvOabDgbYrgq4F7j4Kcpscqux5U_i0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4NyBTYWx0ZWRfX6XJhSO+ukH//
 gGO8kvUIa3T4AiSr6RldZDs0baBMv4YbMr9TFQeC//+jcxTCA2J97NCIA+dI1ACgLg1WqKK2ggG
 h6RnVkdE2IWz/mocMUFVdv02j4Vbc+nrFjFKd7iFWC4h/QiMEGJfOrtY/kAvC9Ei1Sp5XsxX+4x
 5XZK2MQ4+aPbYmu8d60deiKyKMKaY4mjPYNEzDCHtG5tC1uy/mJ+j9a44dG+91WY+aCwXZWcml9
 mMmwO6AC9y6mp+9L0qomA3CBjC+0JttQUTjy2xkfepxdTGRqUeGBqamhpO2vW9cf7crAptoC+0M
 WDC+GVObv2R2klKP/saOYMglh/BgusRKuAbkwCtcg6cOHF5cWky+rbpuNm9H58ynJ1AJq+Ud8vF
 vCsr+Nv+GPu6VJJeof9cpYpnCUwjjgxdskuPdA0pjwlaUMt+0ZML5r4+9ab/grXig4Q5aH+MPcS
 0KAAA1Yvep9AXXC8xDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090087
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 3BT3ODNEQYB7OIFQ2C75XOLXTQFKVFEZ
X-Message-ID-Hash: 3BT3ODNEQYB7OIFQ2C75XOLXTQFKVFEZ
X-Mailman-Approved-At: Tue, 09 Jun 2026 11:29:55 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3BT3ODNEQYB7OIFQ2C75XOLXTQFKVFEZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 6/8/26 1:57 PM, thomas.kuang wrote:
> 
> 
> Hardware: Lenovo ThinkBook 16 G7 QOY (Qualcomm Snapdragon X / X Plus / X Elite)
> Kernel version: 7.0.0-22-generic (Ubuntu 26.04 LTS)
> Architecture: aarch64
> 
> Problem Description:
> -------------------
> Audio is not working on this Snapdragon X-based laptop. The system fails to detect any soundcards,
> even though the Qualcomm audio driver modules are loaded.

Please post the output of

grep ^ /sys/class/remoteproc/*/state
grep ^ /sys/class/remoteproc/*/name

Konrad
