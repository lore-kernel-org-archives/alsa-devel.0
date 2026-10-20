Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021EF606A31A
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=SFjhJIE2;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D4tP/Cr6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=APB+aeAL
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C04C6023F;
	Fri, 23 Oct 2026 09:09:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C04C6023F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792739408;
	bh=OQ7/mJg5aT0Yo9yluTzJ4+iQdLNUPWw0nA3/o121Ngk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SFjhJIE29F9K9yYtJ888Gy0fTAAEnfp/Q7DZo5CsL/Y74NHHs/Em3y+P8SBBbrrgb
	 20tYvqZ3gLWQW5Jt78a+k3w+beaEtsDDhZxs4J4kqoKcSwcOT4lvfkPUKUJAcreSOq
	 MjxxmppZbmg1KVCwe6opTPR+fsNJqNKc06ONmC04=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 91181F806A4; Fri, 23 Oct 2026 09:08:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A5BA9F80696;
	Fri, 23 Oct 2026 09:08:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1C047F800B6; Wed, 21 Oct 2026 18:47:42 +0200 (CEST)
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
	by alsa1.perex.cz (Postfix) with ESMTPS id 99EA6F8003A
	for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2026 18:47:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99EA6F8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=D4tP/Cr6;
	dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=APB+aeAL
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0t3Ff1253880
	for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2026 07:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=u+NWBmXiXBL
	707eUK7wLUNS8C0nG+19FKKE94ew9qXw=; b=D4tP/Cr62K8ELIarr3dIBcU2ORt
	D2deI8w2yCFXNuRSDgZfAEZBQDyZmm+K5ZGjIn3lQZA3gNSEI+KO1/gb1/YPcdnK
	y6B15NJtfD7osEb0wZz3roCmLUtPwGVH9f2babHcD/sJ6GYHVGeqyu6odmnPa2RL
	PUbad1Lpi1udf/ekGLOHkd8RNOIMpjrYEManWV4C+Gp43xed2SAhjKaKfamVHqqm
	oJonIdw0L9gG5z8tx3HyJyWg+yOo5jA2dBOflXq/Q8eBvFq2K8iitV/duxI4mbl7
	VmfMvoKJuQEwG1Ao767ZlHsti/lp0dxZ2hETOouIna3RZeJ2yCFzIE4TeFw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n9e1f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2026 07:39:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f26dd2165so992744485a.3
        for <alsa-devel@alsa-project.org>;
 Tue, 20 Oct 2026 00:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792481961; x=1793086761;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u+NWBmXiXBL707eUK7wLUNS8C0nG+19FKKE94ew9qXw=;
        b=APB+aeALbaefNF2pUMNk1sMbg9rlSG/S+H8Mgy2lHsHV961u3E5KlYfTRCm5zhfxrF
         ikpIL2K64q3CYy8I7I3CsZsMmFFh1AhHNvUyUoadyktMfKqxyzYubstXw8JTpUt5/D79
         v5F7PLdQUBHEmLPa0ipKdT1XcfTgvPEdWQi8tM2Z1pwtWT7+zw+Sqj1BhX20vhvRnbdQ
         QPyi45BVblDzhSPGGadIx7Y4LZU4AjjofAlcqqjQBNycTtGF3Cj5swhrZXQECLiwc6p6
         7t0E6NXW+MjZCnhkI/Cy90mOi5ThvGkOnDrG1lh8wAfbJv9qP6JdNH06d5eNfDDcG9M7
         HRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481961; x=1793086761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u+NWBmXiXBL707eUK7wLUNS8C0nG+19FKKE94ew9qXw=;
        b=jwo9C7voiR3IMx84o5YKwmZktFoV6c0JsMGauhdHKUUeCWv79SSPVAAbNv2IJfMn5D
         ZqiG+eVMlfnwbWkBoWPxzVdbMWZ/l7Y9kkNVfBC1md0Co/eAt/oVUJLnd28FDeQQqQW/
         Fu4rQMytNj4ZclgY8V+rJc6NIqPzuoni2LskFA7P2bKmCfHjFLyAjC0E5MW/fhAHHjFx
         XmBdvbWGOZwFJXGPFTFTGv6hYhi1/Y7C9OrGubBS0qM2CeqXf6/Om82lgmXk4p8hDr0R
         EZ92eIFUJhzr2X8TLNcmmFyd2KIJloIMDI9A3BYEVRP5H2pdBFiwOAqt0Z/c2oIHSgf6
         5WTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9aW0iV0MoUfE4C0rCosXATafe5/ANE5AAqFhyJp6kg296ry9GEeIw+XCmmqXBJrS9JUA5CMmLW7Wo@alsa-project.org
X-Gm-Message-State: AFq9FYI4FBolqseZsYmugtzl/sg1EM5VntzmiMnF3890KhjnIxcj+o6b
	FmYOAij84sAk0KzUOGLOprMW/UlCNEMRayeWzrltfeB1WRvyp03axuhj5V+Sc45Nx3Gb/nS9n0j
	5kC6eAlicHrqJNp5ibTQmilzzS+A/pAeoew7O5jGyubZvhdZo3dRIK8mVxPisbAmqZg==
X-Gm-Gg: AYBFou2OiNtST+03yTpRlHWc39DDXsxI04a+MOf0dmEEOcPzEZcfvdyRVVU0eesAKjU
	kjZjWq9OOJ3F9zZYzQYcev+5CcZ39hCgwfihBjMKY8IiUSL0B1J8H2n3yq0yxcvlBOkShutJkq6
	8WHLtyg5vm8lNsCHuqy7JBXhJYKnfB7iRJdb5kCYMgxWhBxXK84PvyMeHKO40WvjE0QRaKBZi2k
	VsxvF+jcMYvn0oxAGuTKHUfHUmjNB1Rkp5jNz3agtX4AINN9dpJu2wMfRSfkAtBVz9MmtTVA6Is
	xznNUPbX46NUOVm2az59jfVkm15kxVEfL6AqWQo3OGcWcnUV+D+H13Rl1K2EVoA2AxJWz7E1ycP
	XQDDS3tXidhHF
X-Received: by 2002:a05:620a:27d0:b0:93f:23ef:d6b1 with SMTP id
 af79cd13be357-93f29dc1c0emr1816088785a.72.1792481956474;
        Tue, 20 Oct 2026 00:39:16 -0700 (PDT)
X-Received: by 2002:a05:620a:27d0:b0:93f:23ef:d6b1 with SMTP id
 af79cd13be357-93f29dc1c0emr1816084685a.72.1792481955561;
        Tue, 20 Oct 2026 00:39:15 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8208e0sm4566271f8f.36.2026.10.20.00.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:39:14 -0700 (PDT)
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
Subject: [PATCH v2 5/6] soundwire: stream: skip bps mismatch check for PDM
 streams
Date: Tue, 20 Oct 2026 08:38:55 +0100
Message-ID: <20261020073856.1177749-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bjdYSxmF8qhnzpuVSCbbqCadv9M_IxRG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX9xBqqE2RfTNk
 6gEuXCSdICTiDZNsHJghj6b4CyUhq0y5/F0ENhnDzCwehcYqQ0UwDdO3XreQ9DUIy5SwR83jK7L
 owyQQTi4P5zM28rgjjXX/OLZHjxBrodxSKHWjPzhcrEuFneTs/mR96slyY/4tgop3fGqWkmqguG
 WabERMrVh5yWCuxtCT50+3HRwx/A3I+N+E3h9JMcjRiOzFkTcZIugue7dvjPlOLhtX99FUH+W5H
 t4pCxpQC+kDRGiABT5td/Za4seqBHZfD/7Nrt/cf7sb3kW0F5RnZbX/BGx5Wnb1sx8FSDihoKzz
 s4nVZr23Whi9/FDgI1pX+Yv5ulMJdLpp4AxY/F4hxAmZrWu8ybryDqocvcIEc4/TNNdHZOvsiv9
 t8KbuleacgNdTAsqcQyyoR6HAt1F+C4TLjd17gBNoDh7INpz5RNOWX8unigcE7rEZCAYjbP58F2
 lXfZ95Jp1h62d58mH2g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX9/9YwmuxhZUZ
 lcsfcQ+B6QxSmiTT6t6PkzQ+sUCfDF/QRANikSuyfRrzqpPUpSzaS5h3qhIQt0BMO5kBVoZJSJh
 HKfJ0TETfUaukTptP2IBLoOdDEBI4nM=
X-Authority-Analysis: v=2.4 cv=VI9IDNPX c=1 sm=1 tr=0 ts=6ad71aaa cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=t42oVSYFIGZoS8p1b6UA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: bjdYSxmF8qhnzpuVSCbbqCadv9M_IxRG
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
Message-ID-Hash: UHWTOPSF5NUCBILL3MXM4SGBKMS4HOW5
X-Message-ID-Hash: UHWTOPSF5NUCBILL3MXM4SGBKMS4HOW5
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:08:19 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UHWTOPSF5NUCBILL3MXM4SGBKMS4HOW5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

PDM data-port terminals carry a wire word length defined by the
stream payload, not by any host-side bps field.

Skip the sdw_config_stream() bps mismatch check for SDW_STREAM_PDM.
Behaviour for SDW_STREAM_PCM and SDW_STREAM_BPT is unchanged.

Assisted-by: LLM
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 drivers/soundwire/stream.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 0b00fcdcab2d..31db368ba24b 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1374,7 +1374,9 @@ static int sdw_config_stream(struct device *dev,
 		return -EINVAL;
 	}
 
-	if (stream->params.bps &&
+	/* PDM streams have no stream-wide bps; skip the match for them. */
+	if (stream_config->type != SDW_STREAM_PDM &&
+	    stream->params.bps &&
 	    stream->params.bps != stream_config->bps) {
 		dev_err(dev, "bps not matching, stream:%s\n", stream->name);
 		return -EINVAL;
-- 
2.53.0

