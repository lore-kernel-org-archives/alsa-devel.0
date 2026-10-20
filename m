Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB3606A31D
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=CMImD8Wz;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aHjw9wPk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PIv14Lhd
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BC71601A7;
	Fri, 23 Oct 2026 09:10:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BC71601A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792739462;
	bh=7njETQilDKlPj6G1zKOlpLVbsTk+KHUdN8xUlHHemRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=CMImD8WzMZjRH1NEAcdEo/rnDj2UOz+vM5rPptY7TcRrDMFJQr5Al+ujJjy8jMbLg
	 r9p+lACFhqny6v+UyFkUPodTChNmTlYjZHQQc1BtGds+7IWdm8mWPYD/Yvm4Q6jkuM
	 Q/K5Nxxb0K3zL/aGAhA5BIg1U7oPg9SAGqmKbp38=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4B742F80709; Fri, 23 Oct 2026 09:08:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 312F1F80735;
	Fri, 23 Oct 2026 09:08:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 34FF0F800B6; Wed, 21 Oct 2026 19:03:01 +0200 (CEST)
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
	by alsa1.perex.cz (Postfix) with ESMTPS id EFCCCF8003A
	for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2026 19:02:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFCCCF8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=aHjw9wPk;
	dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PIv14Lhd
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tWpD1255247
	for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2026 07:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=EyaVBfoPjvn
	SMo2Diw9nR7qJvmDk1I5n9dnvXC2rzQM=; b=aHjw9wPkBTJ0aaaTt7OQG4XQbHy
	ihAM7SSwPiPp9jd/PR4jv8AGXcxfeMcJSXSaTf6C/HBgzZlGhb9DHif6AUYHft0g
	bIDvc0vlrlRlOhrVNAM3uh+2o6gDtzfI/w4fZhqDHMv5b+btJWw4LadULgCyr6E5
	PBCWZlvUsXq6zhGS4gDwqgssG57HTYHRjMGdYHEeNDKf/Jiu5f49N1yK7ljpP/2V
	IAKDClWfq6QiASUVdco43Dp0PoCmOOHem0PM5qW/x6yV6VdtWXgSFUFeMZBe50e9
	yyWu5G3u3iRzttQGpXKVvfylxaHzf2Bkn+PssUyK6e4gA659dAoCCbIAAYg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n9e01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2026 07:39:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936aa34873bso577712285a.3
        for <alsa-devel@alsa-project.org>;
 Tue, 20 Oct 2026 00:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792481952; x=1793086752;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EyaVBfoPjvnSMo2Diw9nR7qJvmDk1I5n9dnvXC2rzQM=;
        b=PIv14LhdImOcZ8bGNmVVOugHN/MB51ddgPxXlcvv5xiBRN3las+/qiORzPmJdwbqtW
         IjloR2LCackioQw8JU+ynBMlaBqieboylJgL8NjEOvcuLKysFg3V6pW8Edu2zLJ15wsn
         UVIEFXGYTLpk0DiArGXiyUSy6rzp4GZPnw41p8/4Jub+cCoeyHtMkdMe5ZqeX5VqBxpY
         t/GE1kVCpX1Ns/c5sE4zjbv2L6iJsRpgoQgKV7YxdvK0YJR9gNKatamk/RN1jDppxQQv
         qS08IRB41xZb65L99xksUaXWhwbdpL6pa42I3O2/snyHEiXqrn7lkDeiwGcFod/SiTjN
         dpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481952; x=1793086752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EyaVBfoPjvnSMo2Diw9nR7qJvmDk1I5n9dnvXC2rzQM=;
        b=HN2G0QlGoR6St4GEdstBigVDn0VV7rVdybV74z+xJsiRZKC67Ux1nzYP62OrUDIFn3
         7w8O0LgoJkrE+8tXmOjmqI9pH0cCAZdvM++2W3Ay/ozuEw8ZzoQIXqsYQhjt5v9sPLfy
         7rEFcfX+6Osz8MpvHRAetdd9A2PWAEFizdk69gVzb/KHPSU4ZeVgILNc0S+uBPdXyXh+
         ERYp42RZVMyGgoe2dMmYN/CCmhbFDEZV/Hx1UeeWtm+KuJBcbLFBpryb6mgqppRKpGA4
         Q+V747fJDFXh+o3JRr6hCfkPQOHSJMhDrgkSeUC+reRYWboZVoCCV53r4Oi1gHZltcw1
         ICjg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLNSBlb+Lav5Qb67JRqtRmpaYfiYNCxFZn42wdw0M6CcTqUxOv8BXmYHZhCZONu9/6QEwgHMpidbCh@alsa-project.org
X-Gm-Message-State: AFq9FYJH65o56hAk9Fk2vlduQdA8sd+CmNZsdHGvSmRJpoC0qXzojY2T
	gL63V4oTBLmnZUXg6KdaGfu9p//L3s85FG8c1ZYrjqsN0DbEvi87YP/MAn3BI0cLuUUL8IfV7yj
	tJk7ilfgt/0adXkzDatFkM0XZ1PpaCgKjxOAEvQIk/Ndol2e04AZBN7emQTMugYGM2Q==
X-Gm-Gg: AYBFou0hb3420V31sQ/KIorETlcERAsMM46KZWcxSseN4doHrbaQExikSW4icqjiXU5
	PGFHXyPdxGFWIz69Kb/j3Edjq2pnUho4mToZZX9m3d96nf6c7ziYTKcOfpSqF7PrStqr+l958Mh
	nabVEbqIplhzLclNawNDMN8UN8KayE3j3hz9JWEkvGWzmAOLcrZXSrps5Z0NC8VDXmI6a5eYnvb
	uc7iipTd9lxRd+W0f3umXu3p6gsETq9VhwXsnDexc3IYInCVpnmeVTvplvaJyqfOaWlCa8iaEVs
	hqFjFOIDMMD3AoscMVWFiNma5sP47PvctoT7k4PbIiBO+MxLivY4wyKfnAssOeJEeu1KTvaCm4+
	t410X+FHoT3DK
X-Received: by 2002:a05:620a:2254:10b0:93f:2ba5:170e with SMTP id
 af79cd13be357-93f2ba51e72mr983915885a.18.1792481951650;
        Tue, 20 Oct 2026 00:39:11 -0700 (PDT)
X-Received: by 2002:a05:620a:2254:10b0:93f:2ba5:170e with SMTP id
 af79cd13be357-93f2ba51e72mr983913985a.18.1792481950954;
        Tue, 20 Oct 2026 00:39:10 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8208e0sm4566271f8f.36.2026.10.20.00.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:39:10 -0700 (PDT)
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
Subject: [PATCH v2 2/6] ASoC: SDCA: drop pm_runtime reference on probe failure
 path
Date: Tue, 20 Oct 2026 08:38:52 +0100
Message-ID: <20261020073856.1177749-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ExYt3iphNC1fWF38BvH1B9i3_51ERocU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfXzZvOs6X74VFZ
 JeCdgMVCLiPvRjEpI+swpXlx/R7qzJsWbCOuzssL2T07AWAxAIy1RSP7Kf4B4FyFY5C6RlDnPna
 iwoLJYDv02korxXwAyYHbbImy9+/SC7vws/iFB73wFbV8jOIkv+hUfpZKrGq+xEFbNBsprHKZdf
 nB9xW5W04ogRZxyHDJuc7/VVwrm5/5Bt3ZWjZgNlKVIEjYiPWW+VCUpbI8H6V4cFr5qSiL28mjU
 PJScatpB3gTrLs2W7xItNY0ZjrP5pAA4e2qbsvWjA03tf8LYjtsoPp98DoguA1+A4CjH/6j8+w+
 1EBeWVlnbfEVeLD6ebqqIe7IQaZ6ZvFUIX9Bji86Hq13LdxRPw0V6nu5FXCskHYx55c116+92Vf
 gTY9/afgFKohRbPaSVasDJuKagiWvcbUc6VmmkicLgKUEOTsfEMbpHiFcIp+8w8uEIR4KgBLTzc
 jVtgsM1cQWql2Fkas6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfXwj92LXwcTg/X
 2hg6Thy7KTfAq7FWjhhzuKdPLuzUbDuAavmw0VP7nP5wDTmJWLiQvBYF+khleA0GzxZAb0RwD2P
 VWE47Rxgn3uXvSHvAj2ZDJC10GStNPk=
X-Authority-Analysis: v=2.4 cv=VI9IDNPX c=1 sm=1 tr=0 ts=6ad71aa0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=7vtXEAv6VZJtN8Rt8ykA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: ExYt3iphNC1fWF38BvH1B9i3_51ERocU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200030
X-MailFrom: srinivas.kandagatla@oss.qualcomm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: PRPOLUQ7WJL3LSGF7CQFN6GLE3WEXBX7
X-Message-ID-Hash: PRPOLUQ7WJL3LSGF7CQFN6GLE3WEXBX7
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:08:19 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PRPOLUQ7WJL3LSGF7CQFN6GLE3WEXBX7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

sdca_class_probe() takes an extra usage count with
pm_runtime_get_noresume() to keep the device powered on until the
deferred boot work has run. If devm_pm_runtime_enable() then fails,
that reference is never dropped.

Drop it on the error path.

Fixes: 2d877d0659cb ("ASoC: SDCA: Add basic SDCA class driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/sdca/sdca_class.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sdca/sdca_class.c b/sound/soc/sdca/sdca_class.c
index bcc660aeb739..ca311209c6d1 100644
--- a/sound/soc/sdca/sdca_class.c
+++ b/sound/soc/sdca/sdca_class.c
@@ -197,8 +197,10 @@ int sdca_class_probe(struct sdw_slave *sdw,
 	pm_runtime_get_noresume(dev);
 
 	ret = devm_pm_runtime_enable(dev);
-	if (ret)
+	if (ret) {
+		pm_runtime_put_sync(dev);
 		return ret;
+	}
 
 	queue_work(system_long_wq, &drv->boot_work);
 
-- 
2.53.0

