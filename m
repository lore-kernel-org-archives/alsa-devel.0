Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109E4606A31D
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=eOQSK6DT;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CG7+TFoB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zw0y/4b8
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A49A6022D;
	Fri, 23 Oct 2026 09:09:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A49A6022D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792739394;
	bh=4sRRXpcj1h7qIq3WRFGnpGgjLbZc4rZQSxIalBonbsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eOQSK6DTpqskNQZpxF9VmsBCAc2wWCs/Ycj8N3fb6Bu3kDmTI/qhSospj2CHBUQB7
	 7KgD1Jc/B1bIq3aD/DdvHvreJUZqj+//c5irSAudesjLcWuAuHgJI1U0ecMmrKhirS
	 +96qI1zyHncnaWTirYWbGje4LGa5TVf/fc+6ntU4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DB564F8067B; Fri, 23 Oct 2026 09:08:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 43DF3F80684;
	Fri, 23 Oct 2026 09:08:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 71E23F800B6; Wed, 21 Oct 2026 18:32:18 +0200 (CEST)
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
	by alsa1.perex.cz (Postfix) with ESMTPS id 586F0F8003A
	for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2026 18:32:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 586F0F8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=CG7+TFoB;
	dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Zw0y/4b8
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tF3b3807108
	for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2026 07:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ilWLIrnHPQI
	kq8Nqks0gzeKHylePZhRJIyxsg1r+je8=; b=CG7+TFoB9NDdACM7U59ZGSYOThr
	NbCVcej71CkIT7xY6hEFtxo1+MvQjEFYmtqC6OR9S1N+eQ44j7MyNQ6dLae0leVq
	68RMe9vJhaq/KQNyfxyS2SmCsT1+Gqp1XrEDZnL9nA1bNpamg82gglaFNe4WTGum
	WfIIK43Kg6qXHGCV8nuUDpugFeYyJ633VYU83m0eL99ZteNniPGiTbvlt4qD/RJb
	YyWaH/NDXm0fA9uP1U3bPPBplRStYnqOI+Sl82M6XWbo9OmFwyTpgpUE5Hn+e96k
	69HzH/UUkqTZk8KkvQXTXcNG3rwrxr+Xkf350dP2AESz/5YdEJ6x6P1MlaQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5p9e65-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2026 07:39:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936aa34873bso577726685a.3
        for <alsa-devel@alsa-project.org>;
 Tue, 20 Oct 2026 00:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792481960; x=1793086760;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ilWLIrnHPQIkq8Nqks0gzeKHylePZhRJIyxsg1r+je8=;
        b=Zw0y/4b8WibBVoB0mX0tIT6c+PSf/AT+zNx8ijIa2CmePZOMfrGuZiv+fzO+x/SzdL
         XrA31CA6Cj1yorK61sQ+vWk6tegWbgU1QaPM1/dK0xGQWvZod8ZLRiESlEavvf8jtDn+
         gwGDcGWTG/QgZy6KBBrAcOAt9QAgqvrEjtB23FBwz2Us9sHzSANmctr2HP8sH47dvOdJ
         AEytYlkoMrrIv7ndtYKg3oC5pNxatJj8L80UyESdGbhMgWeviu3Ma/cuprbyrkwsEAgC
         Wx+v/A9MHgDcKwr9SIK7Oc5xGgiH9Wy66CFr4CIw6KybMv+szo3CZY2/dwO1cEJe+P71
         iRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481960; x=1793086760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ilWLIrnHPQIkq8Nqks0gzeKHylePZhRJIyxsg1r+je8=;
        b=t9EBlZB6rlfjlxk6NW9JkV/ZmI2Kqd03mDq4F9tAyozWRqluo7GM7keAcjAR61UIke
         e3AU+waSiFQdgGBnkYH2LKx9BtOssfw9VSd7eoLNlbLp4AsaXWY3vRdtt0kq1pzvcdtx
         VRYjB3KlZkTXL15mpr3Y4Z/4h+pqtgN2wREUS0tDNiPjD8780ne4QY8mbVmtin/wtNdd
         5c+gycrG2X999DIAa/1T56FpdEskUL7Q/psAQ1C7gagii7LBRusZnWCHGIs+iawDTLdS
         Y5wv7N6DulH9tQZDy6jRvW5HLHHISSRDK0QsF6R4UJNQMKc1u7QHcTPnHWKsxIC7LLS9
         aS2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBweCIaiHBSvujuV8pv5Kl1ezUnbZff4NClg4d/nL3wd4AyZPGCf2MLcbZkhq83AohwOTNTaMZJ38/FJ@alsa-project.org
X-Gm-Message-State: AFq9FYKMTZbDkAH68zdeDvbL/UOFUAbsHzli97I7zV6LY90ZxgkrYTNB
	IlC6zKo0TzwiTVTThxFHxdBysWJpZ5gujxF6TzUeWYVqa0ac+pdTNGKAU4+KGmvXa0PlNZrizsX
	2Dfwxo879q6OLfJ2jlj+Exdesxl4Af/oD1f7BpO4thUpByvjSo5E5sCPbVvPIde6MzAob3vm3ZA
	==
X-Gm-Gg: AYBFou3Aw4voODk32qkYGoa7aqXzF3WtLTYBnSMebwkNj81+6hszhCeGCuuunyUqkUp
	hyUqZKExtX0X7DHzdKk3dPZ0j/st+Ul35JvPZdZNQgtXivVjsFK2f7VcDBgotoVG1cRQmNCsmyO
	Nm7quJx+TTyHpMNoyeWTwc5hbTQTHTFieK/TpMzlflZSu37Nsd7YwHgiRN52c/8kzrkAv4buuPV
	NzERsQN96CYj6EM3SM4G+JAeQyMnU1Gb1uEty97NhS1vW6IJbmLiY4cZcbzMIPlNseaqaLeFC7p
	svBgdWyUN454GiW42V5K/MOtj9qQDL7TCF1wxPf0vJnpVmpMzfwZuTu/SIeQLpqpSIRqwZg1/x8
	nuLPCd+weo/fn
X-Received: by 2002:a05:620a:7106:b0:93e:722b:1f79 with SMTP id
 af79cd13be357-93f29d75a16mr1687329485a.53.1792481958425;
        Tue, 20 Oct 2026 00:39:18 -0700 (PDT)
X-Received: by 2002:a05:620a:7106:b0:93e:722b:1f79 with SMTP id
 af79cd13be357-93f29d75a16mr1687326985a.53.1792481957979;
        Tue, 20 Oct 2026 00:39:17 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8208e0sm4566271f8f.36.2026.10.20.00.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:39:17 -0700 (PDT)
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
Subject: [PATCH v2 6/6] ASoC: SDCA: class_function: mark PDM data-port
 terminals
Date: Tue, 20 Oct 2026 08:38:56 +0100
Message-ID: <20261020073856.1177749-7-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: frsbbuM4r2Bu24rwSjKJ_XhnGHXIA3OW
X-Authority-Analysis: v=2.4 cv=fb84WEQF c=1 sm=1 tr=0 ts=6ad71aa9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=0o_WhHQcJ6e7tPDH-2wA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX9VF3T+Ykx/HN
 43E7RjP4Ww0hNpcKWZfN3tlYvc9CPA95gs9yGPHvyN1TEw2n0Svyg1qWmuOovu7vPynRUE3oltc
 EOxO5pNJf6OxDR12tF9ba1tIgX2zV2W05ieQshqPiaWBtga5kWuFOgK7lXUtFCpEyGgOzlwrrOG
 nZERLmltcLzHqm9dzrrm3BzMUalYF9ARZKIgHsegQsU3ZuTWx97/sssbXgAs5QrkXmSfppWXheD
 HQ0ev932Skzcf2b81719+6tknLQ78vBEUkOdaeojsI1HaIyuw2Xs3P6UbeAejCzLW9M/1gzms5S
 fjgb3XREp4EFdVdhay0ESHj7r31zg1NuWMJyIIpeXTN2eA1evN0md1+GJUukmc8FumIYIj24RW6
 8c2/ySXdiOKzosyxqWoTKvPa38e4IgnWLmXB4MsQDZvanGBGyoDpbFEJIotZ9KVY723DnOvvkbs
 MWoKKBhrS1B/w9Wx9WQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX41DBKS6UPunf
 cYbuZD5yTdqgscfbE3Q7FuCuqreuGXxAAyeIW/ejr667qqEOlRsZHYZbnnim+05tLFZpVN+kfH+
 1t1ha08CopIi2nqPn1qto2F0h3+o8b8=
X-Proofpoint-ORIG-GUID: frsbbuM4r2Bu24rwSjKJ_XhnGHXIA3OW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200030
X-MailFrom: srinivas.kandagatla@oss.qualcomm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: EIYXDMRPXQZGEPGBNJLPSUUKYG67NYIB
X-Message-ID-Hash: EIYXDMRPXQZGEPGBNJLPSUUKYG67NYIB
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:08:19 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EIYXDMRPXQZGEPGBNJLPSUUKYG67NYIB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

snd_sdw_params_to_config() leaves sconfig.type at SDW_STREAM_PCM,
which is wrong when the DAI is routed to a PDM data-port terminal.

Set sconfig.type to SDW_STREAM_PDM for PDM terminals so the SoundWire
core sees the right type and does not enforce bps match against the
PCM-container-width value stamped by the helper.

Assisted-by: LLM
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/sdca/sdca_class_function.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sdca/sdca_class_function.c b/sound/soc/sdca/sdca_class_function.c
index 13b70f0f0dbf..41f6f0eb8563 100644
--- a/sound/soc/sdca/sdca_class_function.c
+++ b/sound/soc/sdca/sdca_class_function.c
@@ -142,6 +142,9 @@ static int class_function_sdw_add_peripheral(struct snd_pcm_substream *substream
 
 	snd_sdw_params_to_config(substream, params, &sconfig, &pconfig);
 
+	if (sdca_asoc_dai_is_pdm(drv->function, dai))
+		sconfig.type = SDW_STREAM_PDM;
+
 	/*
 	 * FIXME: As also noted in sdca_asoc_get_port(), currently only
 	 * a single unshared port is supported for each DAI.
-- 
2.53.0

