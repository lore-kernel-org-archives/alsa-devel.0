Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1DC606A31D
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=EKGJUAjY;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ahIuoD11;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AKCSxZMq
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02D28601DD;
	Fri, 23 Oct 2026 09:09:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02D28601DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792739376;
	bh=zjhpkquBchvS8J/MiMzKsLp1+HWDpTKQu8qdNDEPFiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EKGJUAjY018q7Ve9BWzdoBmEtUx/9kHWb4PWWlJgen4GRnRdylM0Gmjt/I/1u9UIw
	 6LhFtf4OHSXFvfUIep2zSug77tU698SUzWeJbJRtNXxxqhTlsSUf9OgC/zfC3sMMK6
	 JCHQQ5mOs+B6mWy01/bsVOUPslFxuOgS5p8nfGvA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F66DF8065A; Fri, 23 Oct 2026 09:08:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C3BBEF8063C;
	Fri, 23 Oct 2026 09:08:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 97EB3F800B6; Wed, 21 Oct 2026 18:28:57 +0200 (CEST)
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
	by alsa1.perex.cz (Postfix) with ESMTPS id 8B9FFF8003A
	for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2026 18:28:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B9FFF8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ahIuoD11;
	dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AKCSxZMq
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tQYs1211293
	for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2026 07:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VgK2cMLsx+o
	bslnqu5sYrnrzY/q9pv3tI9Vj5znR6zc=; b=ahIuoD116fOXstk31lDWAqcUl2c
	d9HLvw7XoiG+xdPmPzCdZ7vTt6TFxsnb58rMI+tae31LlvxJk5d87DRHcXiwdefp
	V0EGRJejVm5imVGORfkfcEivb1HKZfjtxAMQ432rrL4uDcrJA4Xw0t40VaakucJb
	L8jeTUbWGCpaOIdRBVj7bmSDTdebKP+h+zCO4dDpSsX7VIcGaPH8chYYxZL0eQxT
	aiLnjBgaNjx/8NkfPNQoOB5RY9FEIm9tfDNfVfT3D80xPWsa/EFcDhF1QU5Ay/Bq
	s4/3fluD3kyD617vP7+l0C1Lyk/S7+czMIcvBK60rQnD3zrmcM0opv+UenQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5p1e33-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2026 07:39:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93c5ab5c136so491337185a.3
        for <alsa-devel@alsa-project.org>;
 Tue, 20 Oct 2026 00:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792481960; x=1793086760;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VgK2cMLsx+obslnqu5sYrnrzY/q9pv3tI9Vj5znR6zc=;
        b=AKCSxZMqOS6AqS9MPuWdigOs8t5m5TkM5C2iVUdi+lb95cayE7N/5mMk9GwCol3Lh0
         I77kDEjEb87bqe9Z32wDEII6Qjd3yx9hSjjUtOtaISSdx1837JwDcyTBhLdjMOJNeXFp
         9XtpPeCymZbN6oC53Yc1Ipif4/BK7el4Tw97ojGYV/6xxt9yLbvsasanoecXEdWPRrU0
         P95H06NC6N7PkRSQgwOuVBqt2WIOmavyweOCMplUuCXkQa1sPVUZ4iIiFIP2TfaRyehk
         dax02xQLOrCI4Ejt/7RVoJsApkQwO/8lTdnpMmCNNvig9evsrcU4q6fPIAF4GzhgOuPx
         gmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481960; x=1793086760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VgK2cMLsx+obslnqu5sYrnrzY/q9pv3tI9Vj5znR6zc=;
        b=r1hsWJ9l6na5s0f71O/yRktLTtyzlFCZISfB6dBxncVl0MCGAWy1u2QqT7Om3DSkIW
         I4zT00QRquhRGozoKzS32oG7rCIDPzB01ID/0YJeandkEx1yhFQygM4LfgiTW6AVi5Qz
         jJX1BcEMlIhUPg+lYE3swlP1l1JDmmunYdplgFamLl8dH7hvE747wY5pt8X76A9MnT2l
         aYmQGSFA5Zj/hF8Usd/FWtu7Y3S+V7KHdZkhJSAkuidyNxmuDyynUUu2SUuFUFIm7KrA
         IrRnYmTP/HbpGi8p32e8BevVxj5qeux6sEK0mHdg6eHZEhG0mPDD1+OHo+aPUYdwDCZN
         3HYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBya49G7M+vTDcYRhUMbBId7nEfBG/W07iGRJ5rQ2RHYjRnEbaEUBZzjb/F5yMY0liyttyg/UFyaukTb@alsa-project.org
X-Gm-Message-State: AFq9FYIjleK2gid6sThv4DRjaIxgieL99Ar39LGkMlsactDkPXPn0Jac
	18KGvQ6FsuLzLHRC8yDa3EvEbCEgdPF2auzylEzAZ1/qe5UvXxTqGQvtEwCvTq3snOYlkMqFVhg
	L6BQpI96dpWtumc9WDvubqdU5ybBsZnj5YdNM1YNMEulhGFqS1zY6xuymeuoc8KoAKw==
X-Gm-Gg: AYBFou0ul1zPw5Xp0qRthimqGeyyTTYmEl8gypevYAl+YSDeHw0REiO9oCoYp0TvZJm
	mrfwVeaFOjE7CvmsHGoUrCuhjbM/rXhBYUq/BbL6T7gPgOExgxhN8b16Dp5w+HE+V0tSf2jOQTh
	dqmncKrjMmkfYVYDnadyqSwbQXim9M2fOVDhz4dPHS4rEh4DgfS+TgRIWNqX6FjAiS3aAqygW9G
	nh5R+J4XbZycqgcWWjReWe+7xNbb3ZBdiXcGu+JZDWTJcpz4KI/r2r9eLCh+zPEC8VgVhKo0jjx
	3ZVDNmN8qrT3UTu/ZKDSyMNywjfMjGA+92IELkvtE4HbM67qB/JsD+kNC6K5lrl/H6eG1nkpfAz
	bSY8WnHFuPL18
X-Received: by 2002:a05:620a:394c:b0:93e:5861:34df with SMTP id
 af79cd13be357-93f29d7be8dmr1654905285a.47.1792481954678;
        Tue, 20 Oct 2026 00:39:14 -0700 (PDT)
X-Received: by 2002:a05:620a:394c:b0:93e:5861:34df with SMTP id
 af79cd13be357-93f29d7be8dmr1654884485a.47.1792481948317;
        Tue, 20 Oct 2026 00:39:08 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8208e0sm4566271f8f.36.2026.10.20.00.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:39:07 -0700 (PDT)
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
Subject: [PATCH v2 1/6] ASoC: SDCA: propagate sdw_slave_read_prop() failure in
 class_read_prop
Date: Tue, 20 Oct 2026 08:38:51 +0100
Message-ID: <20261020073856.1177749-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p5pR5WRvrRhw7PUmrJY1s4mprQCkuGPl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX1/+RUjw9yOpK
 sHQmwQxhrN3MZtrl2MB+Pt0tSDx4WnoxRPf+H9dM1o3AG3wkZsY2PYLWxPMpJrAjiR8flRDFj0m
 cb3+y6BnegyyPfKYYnxpbUnWJwna0JQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfXx8ahxhTkQxPz
 TjmHb9rYgYpBPfxfmoDSKJ21HsJrOjg0lrs4krFu28pxHXDkF2gUqqoCAtcpb0SK5jQliWG2QVP
 B1CWgb00aMWBaa9qpx3JE1seh712IybOMgiLfjrInzGD7/KFYLwD74ialRNpxFsRSc2vRbpj4Zo
 1Nu7wZno1XykHxmzDBRs8Bg72zCpqnhgtgvJXClgVHi0MCmwJRcP6IDIXwoefKg9lRWM2XkKUgH
 +V7LdvRZ6G5X+Wn+YrEp16AfHpEQudNTbFyY1zAMfiI9c/v78NfqjUjqub8/94jbZYHKoXIrXEK
 UbgsvbccWEV2QGgeA3TLfRnR1RuRiab73P++1JGyAai38c5HTurbMLxkCJN6Lh8NvuQiAe5kik+
 Sc7JGacdmeGwgsmY7O+stRfoQRaN0ZeL6F/jDWeTpu4LXOdUQPq+yd05zSZLQ3jNPWPV0U1C73b
 2hl/Zc6GmJ1Nrzz1LfA==
X-Proofpoint-GUID: p5pR5WRvrRhw7PUmrJY1s4mprQCkuGPl
X-Authority-Analysis: v=2.4 cv=crUOAF4i c=1 sm=1 tr=0 ts=6ad71aa8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=w1d2syhTAAAA:8 a=EUspDBNiAAAA:8 a=jwOcZKWdBhvvz7EOEfMA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
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
Message-ID-Hash: V6YPC77P7YMYMJSO5Q3KILWSOTU77P7E
X-Message-ID-Hash: V6YPC77P7YMYMJSO5Q3KILWSOTU77P7E
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:08:19 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V6YPC77P7YMYMJSO5Q3KILWSOTU77P7E/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

sdw_slave_read_prop() can fail with -ENOMEM; propagate the return
instead of leaving slave->prop partially initialised.

Fixes: 2d877d0659cb ("ASoC: SDCA: Add basic SDCA class driver")
Cc: stable@vger.kernel.org
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Assisted-by: LLM
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/sdca/sdca_class.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sdca/sdca_class.c b/sound/soc/sdca/sdca_class.c
index 79fdb672be1d..bcc660aeb739 100644
--- a/sound/soc/sdca/sdca_class.c
+++ b/sound/soc/sdca/sdca_class.c
@@ -27,8 +27,11 @@
 static int class_read_prop(struct sdw_slave *sdw)
 {
 	struct sdw_slave_prop *prop = &sdw->prop;
+	int ret;
 
-	sdw_slave_read_prop(sdw);
+	ret = sdw_slave_read_prop(sdw);
+	if (ret)
+		return ret;
 
 	prop->use_domain_irq = true;
 	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY |
-- 
2.53.0

