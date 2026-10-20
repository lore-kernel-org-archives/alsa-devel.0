Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89D9606A31B
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=OFl1pnfl;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gKMzz6P7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Au9DV2+b
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE28D601CB;
	Fri, 23 Oct 2026 09:08:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE28D601CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792739337;
	bh=8jK9TIWbD6QefR9kQ++tVg/5xwWCv77cabG/zWe3+ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OFl1pnfl0EKNJmEXjYOeC+I1GK3NwoZukOLJZfDQRT/84TTPdZh8zh2qASB0mX/Mx
	 g1F8jCnOvxDDZWfF7vcY+mQa5mU8RIVzy33MMumnUkqgqEJQjpGFMQKpSLbfHJ0tH9
	 ae9deE90YYz2+X1b2PMCSawqAHxs7oUoykCfMHQ0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1DAAFF805F7; Fri, 23 Oct 2026 09:08:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 161BAF805F3;
	Fri, 23 Oct 2026 09:08:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 18C32F800B6; Wed, 21 Oct 2026 18:12:31 +0200 (CEST)
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
	by alsa1.perex.cz (Postfix) with ESMTPS id 93954F8003A
	for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2026 18:12:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 93954F8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=gKMzz6P7;
	dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Au9DV2+b
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tAfq186182
	for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2026 07:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1aGPUh+pH+A
	6f+5NezhpjcrkpA6qe52i06POTDfLDA8=; b=gKMzz6P7IWIG5jqMUbxkvExJGml
	rHJM3N2sdPQVifjUvOa7uGFo3mYydNWiNYMvCFXn5hujoTCH8qcLESQcsf2V5v9H
	6kNKyfGZYik6FW8tZ7AnvI8P4+qEO1lQQ5fV7/CuBvn2oc/lB3mkqpqT7ETsN9Ka
	9SkIvIKD99QZkkIiyOf/u/VfQXkJrk3vmHtbjgzKNfuUPzJyaObAemfPiMookj/3
	hMX+tvCbi0OhCLU51PE0MPRd5g1pxCOaSzO6p3ey+kdvbYQmRszJPiSY1xRvhpvB
	QCW3QRl4q3zzGDhhlXX9sHrU/Bab0KT0OtpiNoJcKN17kMilQ3xYEgwE4Gw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nse82-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2026 07:39:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f32050e72so864850785a.1
        for <alsa-devel@alsa-project.org>;
 Tue, 20 Oct 2026 00:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792481964; x=1793086764;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1aGPUh+pH+A6f+5NezhpjcrkpA6qe52i06POTDfLDA8=;
        b=Au9DV2+bxKAcfQjfBw7d0gdAeSA9q3+LkvNPFu9RV6E+T/GcTBUc82ipFqGK7a6M3Z
         o9IAuAlJ1k4IFP7P7kc2z+1HMVkl99IRVYjbwR3ZutaPqmOw9VP0Db1EpA1i3Zn5qqFA
         w7Og/dQkMa4nGCVVjo//pgiQxkTNN9tAaf9pzYHp6dti22vM8xr5nTwrb5KcdyrufWOV
         TaHHBHKRmo34Wh9nig/M/gLGl/QkSFRQnxptO5VBYnisxQAegdNMp8nWXeJPhmdpIahb
         3Ia2q/FtVYgFhgi2QvPlK/dl1cuAWV55aZ6XMjFPBhn+255xj6Ka/0FlHjI/U/qLEcFG
         SeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481964; x=1793086764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1aGPUh+pH+A6f+5NezhpjcrkpA6qe52i06POTDfLDA8=;
        b=N8tUe1oyaV/AypxcekHLBorGqzokv+zq2QY+xDBuwnNbiKu8B1wx3+8PHlv+2BVnyR
         9GQ7TNHbLLaBBFBHC5TgvRufXBiKWlCUVhfdaMmBrGpEh4+AgoGGd7IMmboky0h+Ef70
         drI6he/qf9ZqCosg7KKfFVU+fqVPiXXYAmpn3XsYPXDEg7wmn9V2RVGpvyGeN2zov7Hk
         yj8QwRKzUpwl7wn1wgmQHm9+gBQdNXLWgUvlE+Q1gWA+ABlh4sqx3CpPMXBi+kne+xni
         0oqfV/DeAjRtk8u5IuYyUQaJeij7MZdCxIjD2xS2+Nome59b464ec0st8BnJTsi2LKOc
         JLvg==
X-Forwarded-Encrypted: i=1;
 AKwUvByrPpW653KHQ0MG86y107DYzrzehvnLaitPHXNreL8NYoOb1NNBYPzimIR3kBmbxfEeP2IFcNH5ohBE@alsa-project.org
X-Gm-Message-State: AFq9FYKECdwc8j9t7WCqczElA6YvizI/+XD/7nVF7ybp9+gLjlOzu9qY
	+muzcTUJJb0OYU6O7Ey+xfl6II+dWTiiCU7B0Gqr0FgC3JlsS2YevxVaPFhdQN/pyruwqMbqtIX
	rRyVR4HXHfx8f8nRBXQvedO8cqeEQATqBPLka9ElASaeX2MWiFOrNNK6nIQgxa9WjqQ==
X-Gm-Gg: AYBFou1debIYlh2CkRc4lxaPWNX3H1SDkKNt1gMIvwm2PHPjJNQX752vSfLmGh9rpyd
	8TNkmaAPtw3kiqbZVPsJV2bUV94uRKSkitR8c2taMFwdP0AMRLrt74puTY0mTbHMMvmpQCe27UU
	HLr8Jzg06BtS4HlqI8P+u5ph0GfVT7s2qgUA0lymXt0Qhr/TH60wX56sUW6JVZpg8SRohPc4yeB
	jG0UOzZ4/u39QDs69MUoDNQNbtnIwPKFdYR9BsmxhcrEt6MZ0a7doGeyM/M18BALjYTzi606yim
	luW7SIy432x7Wstgo+gxm4IQQN2O4euAugsqcYVe1h8acNMCsX1RxAwK6YA/S3kwz3tE9PMjW4I
	HkP2BcNIbwEbr
X-Received: by 2002:a05:620a:1b86:b0:93e:bcbf:4ad with SMTP id
 af79cd13be357-93f29d0a5a2mr1584877585a.33.1792481959278;
        Tue, 20 Oct 2026 00:39:19 -0700 (PDT)
X-Received: by 2002:a05:620a:1b86:b0:93e:bcbf:4ad with SMTP id
 af79cd13be357-93f29d0a5a2mr1584855485a.33.1792481954007;
        Tue, 20 Oct 2026 00:39:14 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8208e0sm4566271f8f.36.2026.10.20.00.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:39:13 -0700 (PDT)
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
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 4/6] ASoC: SDCA: add sdca_asoc_dai_is_pdm() helper
Date: Tue, 20 Oct 2026 08:38:54 +0100
Message-ID: <20261020073856.1177749-5-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LbLFyL59ue4GDIw2Cit83tXEDJbmPTso
X-Authority-Analysis: v=2.4 cv=DZOCOftW c=1 sm=1 tr=0 ts=6ad71aad cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=UfHDTIoufQuGQUpisKIA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: LbLFyL59ue4GDIw2Cit83tXEDJbmPTso
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfXzl4RgD85m+pr
 eoB7kmbW6FSv5GIobS43rwqA68t3aqNoNu21QyapAx90HiN+Ra++aLDh227oDqbVWzi3eepB/NL
 kfGlrfQEI8F9vSimqbRD352dzXWmsplYMJFQU3if5//LhNUt6cl1HEhtTvfD4/+Z5CaMK7Fji42
 hFPug3usTBIwnZrTZD4wMOUpmWrWfDlxsoKoblxRsn0l+HB3ETWFINoOh1GK4xUyE1Mn710k9K/
 Ts0T5wQXxcnD4amM6I8NknP78gIlIggAkRoIDPfglgLMZB2fSSyY1j6RIxAPH84e9dJTmvXZfY8
 /BilR7Go8Urbc5HvSaNlgy0k3J5bYvXKjYGLm58z2HnQak/6GdWVJZSlgr/gOcnDl8OfKW/5/Fs
 EfTPwHwAZaX4x2HEWMfSh3IYvU6Acmq6WoBpSXhJ+SUeKc3/sWy9JPl/jmt6xMTSKmaK1WAplIy
 /19EC/cM6DKryu79y3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX8TroDePaiOIc
 swbe+55FfhR/KV1x9Mb/mCt3c58mwzANqmv2vh7cHkMn1KfYEPOXNlP/UOSndICT+fR5sl04dDK
 DzAYq0Hw5+Xn1Q58e6H+xEu7x4r1Qyw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200030
X-MailFrom: srinivas.kandagatla@oss.qualcomm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: IM6QCOOYYSWJ7IAIYWUUROBETKVA5TCY
X-Message-ID-Hash: IM6QCOOYYSWJ7IAIYWUUROBETKVA5TCY
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:08:18 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IM6QCOOYYSWJ7IAIYWUUROBETKVA5TCY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Resolve the SDCA terminal type for a DAI and return true for the
spec-defined PDM terminals (SDCA_TERM_TYPE_RAW_PDM_MIC and
SDCA_TERM_TYPE_PDM_RENDER_STREAM).

Used by sdca_class_function to tag PDM streams; expose it so other
SDCA codec drivers can share the check.

Assisted-by: LLM
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 include/sound/sdca_asoc.h  |  2 ++
 sound/soc/sdca/sdca_asoc.c | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/sound/sdca_asoc.h b/include/sound/sdca_asoc.h
index 599a72f33515..99c39b5944e3 100644
--- a/include/sound/sdca_asoc.h
+++ b/include/sound/sdca_asoc.h
@@ -112,4 +112,6 @@ int sdca_asoc_pde_poll_actual_ps(struct regmap *regmap,
 				 int from_ps, int to_ps,
 				 const struct sdca_pde_delay *pde_delays,
 				 int num_delays);
+bool sdca_asoc_dai_is_pdm(struct sdca_function_data *function,
+			  struct snd_soc_dai *dai);
 #endif // __SDCA_ASOC_H__
diff --git a/sound/soc/sdca/sdca_asoc.c b/sound/soc/sdca/sdca_asoc.c
index ccc579f878ff..559a0fdfd98e 100644
--- a/sound/soc/sdca/sdca_asoc.c
+++ b/sound/soc/sdca/sdca_asoc.c
@@ -1781,3 +1781,26 @@ int sdca_asoc_hw_params(struct device *dev, struct regmap *regmap,
 	return 0;
 }
 EXPORT_SYMBOL_NS(sdca_asoc_hw_params, "SND_SOC_SDCA");
+
+/**
+ * sdca_asoc_dai_is_pdm - True if the DAI is routed to a PDM data-port terminal
+ * @function: Pointer to the Function information.
+ * @dai: Pointer to the ASoC DAI.
+ *
+ * Return: true for SDCA_TERM_TYPE_RAW_PDM_MIC and
+ * SDCA_TERM_TYPE_PDM_RENDER_STREAM, false otherwise.
+ */
+bool sdca_asoc_dai_is_pdm(struct sdca_function_data *function,
+			  struct snd_soc_dai *dai)
+{
+	struct sdca_entity *entity = &function->entities[dai->id];
+
+	switch (entity->iot.type) {
+	case SDCA_TERM_TYPE_RAW_PDM_MIC:
+	case SDCA_TERM_TYPE_PDM_RENDER_STREAM:
+		return true;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_NS(sdca_asoc_dai_is_pdm, "SND_SOC_SDCA");
-- 
2.53.0

