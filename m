Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1771C606A324
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=K1ds2s13;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f4Kuknhs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hqxCFBId
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 217E4601AE;
	Fri, 23 Oct 2026 09:09:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 217E4601AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792739361;
	bh=aaehUpN662lq42ZhGwnG4ypwBwWyBgwh36C9mkI+NBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=K1ds2s137nOGPjiWSoSLTdEL/O3XPhAdQcFrEMu5EmMzrvy0mTqxeaP/WnKSiWohr
	 MI3CV/puikIWg3XfvLCXF6pSsopVGjaxotwG/ducPNksW+WurbFYR8TxKsqjaPfNq0
	 xRnpyDTjv7rb0Q9dP6S6gdhdQF9aBjHA26Qh2Wn8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 37FB4F80620; Fri, 23 Oct 2026 09:08:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 662FAF80622;
	Fri, 23 Oct 2026 09:08:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E32EEF80087; Wed, 21 Oct 2026 18:28:56 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 51885F80087
	for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2026 18:28:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51885F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=f4Kuknhs;
	dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hqxCFBId
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tPCo1211286
	for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2026 07:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qoA6ADeVtXS
	q9JMrH4L+llb/0nFEv/ASnOYsfH0syRY=; b=f4KuknhsLH070xKg974nmwJrNAc
	lBI3yzn4D6mV/ibCdntGHPF/AgmRzylNGT/On/T61J1Gt4s05eAbQ+K3nGnMve0R
	p9oLw52f0zZXvwnE5C3AR05Ug+9d48+RvLLWr+Q/cSXxsfml6LmuTq4fkt0s7060
	/B2s0xOrTotlWT1iPd8f5+o69Dfh/tuwTFya9fmbmwrK2rmLCCWHCFoFKrNXETQU
	A2BYXS7VnQN7aW8H+Vc/mIRDuOwgAiYcSlztqSDQ9mzqKw3o1S25S50IfiXJh+Wv
	sqowOVmkKPFzKyUm/cq62SjJ8MnekRP4hmWgM6ZHzlWGzaGOmfdHNde1xUA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5p1e3d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2026 07:39:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so604865985a.2
        for <alsa-devel@alsa-project.org>;
 Tue, 20 Oct 2026 00:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792481963; x=1793086763;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qoA6ADeVtXSq9JMrH4L+llb/0nFEv/ASnOYsfH0syRY=;
        b=hqxCFBIdbKh5QcO8ZJMg65jutUm6Y9w3GpEzjG25s+LXgUfHe/eOZI5HPnR9LTx6oL
         XM6DN7nRdIQ24Be+uqIOUGSnygSh3smnetlXCkolIZvnsgzJ+MGJjxCv4PuVcpoiyWRL
         EBvqexkAgqeNgvBS4wEz0hN2iod59xv+AmR/kV4Xk2fjAqgTcth1v3saudXf3F18tnvz
         6NuHj+oPkMjcF/m6iP7yH72bnGJf/c8I8QrrG0QrxPJbN8bxRlI6/IlV8EUVGTGovCs7
         dhKHa/UxQxJ+RyasG2wKlnFn1hWGY9XT84MIbF4FsiP5iJV1P0/rZVN+Xdo2Fkm1c3Bn
         n9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481963; x=1793086763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qoA6ADeVtXSq9JMrH4L+llb/0nFEv/ASnOYsfH0syRY=;
        b=I1i57Eg7QG0yMRLKrNGEGy4eblbTcjjyGrlk2yru/xAffXUwKCeofizjX8sdPZEUbw
         ueivmsCRM8RPY/5FbnUXh1EfvLSpnMQaOOiBCmNgu1Gr4gEtVCPX3Uojk2RlwA4VjAew
         w1Gs2K/+7N9rV/UF2xgfDsSbY/DRBzJeNvA++elk8jvnJ/cNntTyzXDwkRg4ypMB4+zF
         a941J3FGdCR9Rlht1TABQ9MDKnPs3GQkuxphGxyJnNKC3qvCXbeYFe9dtyfMR2HNo9Um
         oZcGNbzCvO4uq0uLRUupsGx44NnGVJCyaiOjg0EJ1uLrWWTH8Gvqcrc5+67h3fV1sCTW
         Zz3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVSt7sAbbcAfK3PQnwVZ068bQqTPsoETPd88MQKCVV8MeEnbtlYO2FM5jQDPQKjxh3uHuofogixPfZ@alsa-project.org
X-Gm-Message-State: AFq9FYIPgqZdxBktJRqiL2uWxP10UO8cbv6o1zzhb0k4kjuxTmwf/HbW
	H9jQoTUh0aadSH/t/woVNQ/vFWEpNT8VqFiyKS1i77qn5rJ629buRguuCgZmY6pBb4op8yvhnrg
	bBYxE2KN2eKqk0RrEu6ezMULBpGM1RW7KjGeahoQQ2vmbNEtuHLFTI58mh7CrNYy2aQ==
X-Gm-Gg: AYBFou20VaiU6EOuc1/Nhn3J5RHQfTLaCD+saxnvaBbA56s5IJXpneIWqBrRJMOXzsE
	vWFQFqiX8tT1rlQkMqiZ3WaVfMYy2bxd+2UN6XyWLoMZ1SxJkBpfEl3WzP7LFWqmhV59AbohJxL
	n5RLkQtsrof63kF7/ucg4WGIrgs4sH6V77H1aKufgdwbxk9SWhLjO3OCq7sI0ojYhu+S7vYnTcz
	XeWpOaAQzVMQaJDq9hEs6E9r+uSq3LRtZxysdIP/5nHG3dEiyqGn8Ze5q2KmqfZfCq/n7Gfr0Ek
	xs4sodiQcsK986WrLV8+biSWdWrd7nW6N4Re8rGKxHHCh858G+9Jv36ttIwxLxumQFvA6vkASTa
	U3yJF04lf1ZWb
X-Received: by 2002:a05:620a:3190:b0:93e:f499:43b0 with SMTP id
 af79cd13be357-93f29cee012mr1765058985a.22.1792481957858;
        Tue, 20 Oct 2026 00:39:17 -0700 (PDT)
X-Received: by 2002:a05:620a:3190:b0:93e:f499:43b0 with SMTP id
 af79cd13be357-93f29cee012mr1765038885a.22.1792481952471;
        Tue, 20 Oct 2026 00:39:12 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8208e0sm4566271f8f.36.2026.10.20.00.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:39:11 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Sanyog Kale <sanyog.r.kale@intel.com>, Takashi Iwai <tiwai@suse.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 3/6] ASoC: SDCA: re-enable IRQ on pm_runtime_force_suspend
 failure
Date: Tue, 20 Oct 2026 08:38:53 +0100
Message-ID: <20261020073856.1177749-4-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pqiKe87L7gjdjA_xQ3z1iEJir2FWIlDZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX4nKODELJofTb
 DlZYVNvz0V6tYniygf/V59pwbR9t+cH6qX5sOyLWKUQ3WlDlW6NXlE+gFeHRvH9CCHhm8Rc8TbX
 QwQX46GSKPrkThFUs0O4fPLo9a+ifFg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX6neHtVMypDjP
 MUtlWabZAe9VT93/3mjSWxa7Z1a+CVR5gNzyBl8mAupGUqtDYcCUO3JsCrPUh2tkokGh470/Kmr
 lu3OCWxVcUSYF8wMJbaGuDb1/1OOxQ7CyglVfGPOWThY27BcNMUkXqIdXjVX8Ip6cQagVhyt53V
 CymCO/bVrOQvrX+jsI+UuyDZuP4V34zSBk2d8Rsz3Wy4AT2y91Z2VHxPTVHxk0s71kzVRis395K
 jPoXbs3p4VzLdDZ87c7+gYXexn6WbWzLISWx8tQkA/tagzsRafWSk6VyGAM1rroJ7NVAxBgENFa
 6PR7mEuxFyEptvUCoLeYci+6FpJQZDVeVqr2kQNq8TMDv3NUVaViFbORuzhxeN9Rhof9Rn0qUWq
 NVHTEeatBOeOKjelM9ZogBSBM0dnd7mSXMYkUzeg5rG5XofuVgloViliYr/raN+3sHbWPTP14ne
 x3klq/8fINkR8vP45vQ==
X-Proofpoint-GUID: pqiKe87L7gjdjA_xQ3z1iEJir2FWIlDZ
X-Authority-Analysis: v=2.4 cv=crUOAF4i c=1 sm=1 tr=0 ts=6ad71aab cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=w1d2syhTAAAA:8 a=EUspDBNiAAAA:8 a=AaUSbDpTSIYfnfK-pzQA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200030
X-MailFrom: srinivas.kandagatla@oss.qualcomm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: RW2CGVUNXKEQO74M34HMJSVPGRZ5GILK
X-Message-ID-Hash: RW2CGVUNXKEQO74M34HMJSVPGRZ5GILK
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:08:18 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RW2CGVUNXKEQO74M34HMJSVPGRZ5GILK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

The SoundWire IRQ was disabled before pm_runtime_force_suspend() but
never re-enabled when the force suspend failed, leaving the codec
unable to receive interrupts.

Fixes: 2d877d0659cb ("ASoC: SDCA: Add basic SDCA class driver")
Cc: stable@vger.kernel.org
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Assisted-by: LLM
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/sdca/sdca_class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sdca/sdca_class.c b/sound/soc/sdca/sdca_class.c
index ca311209c6d1..ee61c983dc57 100644
--- a/sound/soc/sdca/sdca_class.c
+++ b/sound/soc/sdca/sdca_class.c
@@ -265,6 +265,7 @@ int sdca_class_system_suspend(struct sdca_class_drv *drv)
 	ret = pm_runtime_force_suspend(drv->dev);
 	if (ret) {
 		dev_err(drv->dev, "failed to force suspend: %d\n", ret);
+		enable_irq(drv->sdw->irq);
 		return ret;
 	}
 
-- 
2.53.0

