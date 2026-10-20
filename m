Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A343F606A31E
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=W7n43nne;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gM87Vy3x;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aMpyMv50
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C6F96022E;
	Fri, 23 Oct 2026 09:10:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C6F96022E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792739427;
	bh=acAfBXAT0QJ+r0Ruu1SyuYkxFV+1nznRK2u4sof74e8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=W7n43nnejN8jpukIDq/YLB9ZBE1UVaIybTwd6RS3UD00r4iDAIUrqq7bIsJzp/mI+
	 JJRHiGmnuSi6MS0y5TTEJhqJchtUumyU32R6IaRIcnUIQodzcQP1UwGtwSfizMR0ti
	 xNvVfQ9XmXCRnmhl6zZtHh2j0b+tf3oAgSHxGSk0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 420DAF806C8; Fri, 23 Oct 2026 09:08:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AB3A5F806CB;
	Fri, 23 Oct 2026 09:08:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 791EAF800B6; Wed, 21 Oct 2026 18:48:09 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EBB72F80087
	for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2026 18:48:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBB72F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=gM87Vy3x;
	dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aMpyMv50
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tOcc2877974
	for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2026 07:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ynN8vq55KK+neFzK3sShq/gIeHmeL6EmYwv
	uyW4p4qg=; b=gM87Vy3xodCuUpfe0BXxoaEoS4/RHrfi/bxFk8plVR5l6n+QWkP
	tey6ZCTxWXTSDxQ8dW4MF631UvZAy80N6xot4i3Hwd75uO9CkQGoJkjcYVhntGHX
	NnAEqJh6t5IbrZs9Qn4JhUMgrMhGDGgenut5cfG46jMuJTRvy5/MqDIyPUEB6CaF
	9ph5CfwDEG2AG7DMyYUS3HP7ZIhmjGXEJHFAkaZEkcICo+y7z/6Cn8olCHrXybV2
	bwTyeFJ+QxFk7qYjXWDYqpApDd5C2gGrimbGEK7kAquWeyT0zQSzgCAGDzLd3xPL
	Hrw885YBFt2DJq8P/s7djan/Bb3NhgcavcA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5psdvd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2026 07:39:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93dd3c3badbso701799085a.2
        for <alsa-devel@alsa-project.org>;
 Tue, 20 Oct 2026 00:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792481952; x=1793086752;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ynN8vq55KK+neFzK3sShq/gIeHmeL6EmYwvuyW4p4qg=;
        b=aMpyMv50t/k88BfxDbFbHZqUJYxcup+Qspb3N1RDkzhWBpP+WdJyL7gwXG8avX8SuT
         FSmsY9fdvvxx9V3qLqdAbxuwCaV2YVCMMj7zqAS/gLV7ajxQ4+UeWQhJmxFpkT8oZw3r
         ASzr9j87j4FJd8ZBzEJmxP6D7oOee/fuJOkrwpYKL/8Wqsa0LL3/PjwhkWdepdyArJ4n
         7UKD0IjdsepgyPAR6U7CDrb0maK6V23B3UQPwgDpMv74IEBE767fejCWLHtZV5IGdZ1m
         t5KzMtmkxS1UqtuFmkEREisDqFJ6l5WgncjC6GizPnAOUTp4Unkig+AIlX0nVkNKTN6L
         9Nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481952; x=1793086752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ynN8vq55KK+neFzK3sShq/gIeHmeL6EmYwvuyW4p4qg=;
        b=c11R6Qxv1CXIpGy6LNcj7WuxVIQf8CMFF8EoJr5Qf6rR54rPlFzZppwbR41nqwWh2v
         drH3qPax4KE5aHlmt6inZG+/JmHB51CfW/I7HaKHjqwH2HToDzhWAH2eUg0x2CZ+Bd7T
         yR41gjujF1JhKjhIcgEvo0rFplgDxOdRDXooLbyD9KkZMalGYFEn/rhmLdIus0AoFQlt
         9dfPDJvlbkXiwWz0WmrZ0RrYwH9fGzL+7NO8TTB7jfCOK3vCCuRu5v4gkjB1w7tVOqed
         25QELE7z7fI1ZwU3BXGQJoN11N84VsFZLZQJvKjnniBIN9DQ3TviclRoWerQSSzoMTKo
         Udyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoxlzVao2X5C7q1dC1giwvjxDNUKNC0xN/82+yJb+L+GCvvcIcOLFAegIDbefw1xE+PX+QuZrESEOy@alsa-project.org
X-Gm-Message-State: AFq9FYLdVHkzASY7Nn5KkBeZfGRSaogpKB/crB7NyZtI2QKtVnEluk/N
	a60Q2VFfB8qkazhmRha87Maqj+9gZQX4DXR1wxC898O25jXAOPQWJ/VDHB2gcFavTn6jVziTdFY
	EeFjP0+0Xu4ITlWhy/CCOZ2ZV9EDszJ/1HL0ujqDJfLJj0pSqPieVbZYH0WR2gfksjA==
X-Gm-Gg: AYBFou12dKyhLQZwdhB/5OOJeS+5v1Ym++gBFIX/iny7xq/h+AMEGF5/fdNKA0gF0fy
	XcyKxoaqwD3vcOSM/y0LFXLbKUHEH4Ut77wlD3SPb4JPWMHBhAd9k1jN/xjbIMBGg8pGZN2Aj+P
	BGk3iSopc2prOm1RaPLT+0gIGueyRb/BRrdGucMCn/7KwTCpxDQpqsSDf3FEieOXQMXeSwGs4Ns
	tqc8SLiMquHNiELyumGd15mXvMGDF4oNSaghmuVKRqJo0aHYioUEeGjFnaemxbQDcqBbvtrXKN0
	+si9M4Kpe5qR7HV8wc0Gwx8f0GH80WWd0ZpGRZQ9eyw6NFQWCNl60aPYWCzrg9oxHDkrYe+FqC/
	6VBQnD2l754lR
X-Received: by 2002:a05:620a:444d:b0:93e:c12c:9b69 with SMTP id
 af79cd13be357-93f29dc8f14mr1625396485a.68.1792481952267;
        Tue, 20 Oct 2026 00:39:12 -0700 (PDT)
X-Received: by 2002:a05:620a:444d:b0:93e:c12c:9b69 with SMTP id
 af79cd13be357-93f29dc8f14mr1625375785a.68.1792481946786;
        Tue, 20 Oct 2026 00:39:06 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8208e0sm4566271f8f.36.2026.10.20.00.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:39:05 -0700 (PDT)
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
Subject: [PATCH v2 0/6] ASoC: SDCA: class-driver fixes and PDM data-port
 support
Date: Tue, 20 Oct 2026 08:38:50 +0100
Message-ID: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DrrDa2/+ c=1 sm=1 tr=0 ts=6ad71aa1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=ZXgMDdy8QFCOA18ocHQA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfXwQM4bz++X4Ey
 uZthOvygUACC4E7s3u5wsvyCSojVdxbFlfkxdksEzHBHpG6otc/FlRH6UHgMRc9s+LkECWClk02
 IeHCcF9ISRmkNfk9TbvIA+NV9tb7LEAtmVRfOt703KdMXLdyTnPuuX5JkMiwsjPUs+P2jRpCwpY
 JTGiEM6o6AAasRd1ZyI/tu21Kzl21DALWivzDszuZaJWzsPTqBvy+WXA28GDnkgm0G0GnwFvUqz
 W/7HRdEMbeQG3l6R1kxk0VPwcdRZIRErBTWgm6rLoMKDpRkQ2vGWMnzQDmYtbuxaGo/jGP/7s3Q
 Lw8tk+EInoZYaoJzUAVjvqJ1zAMBRx5s+hmOAjhsOGyKEi3NcGfPaT/NxUKe2L4A+ublL56EZZx
 iBjfaW5SogkUtjn3H81VUGMLpM+7JiJcH1WYgJyGEjDrBjFMji7hzK3YZMAEGhf7VGZH+0Mw7Gu
 ClVyo9RHR2wxkpljEMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX4FUO36EqTNeN
 CuvJyDMzG7x0Bwf6v4IehFE5KrjeL4GlTnv/y69gFUVQMATqFmDPjpwNHCDprE3a0Gb0zMUCP+O
 DOrpS8KysgYGtiLTUaRkmzspbCz50bc=
X-Proofpoint-GUID: 3zZbOEP-O5u3-rGDTzGaLMVgPZvQD9qP
X-Proofpoint-ORIG-GUID: 3zZbOEP-O5u3-rGDTzGaLMVgPZvQD9qP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200030
X-MailFrom: srinivas.kandagatla@oss.qualcomm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: R4ID4S7CFX5JA4ASTCL3X3I7JXOHVOD4
X-Message-ID-Hash: R4ID4S7CFX5JA4ASTCL3X3I7JXOHVOD4
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:08:19 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/R4ID4S7CFX5JA4ASTCL3X3I7JXOHVOD4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Three small fixes in the SDCA class driver (propagating a read_prop
failure, dropping an extra pm_runtime reference on probe failure, and
re-enabling the IRQ on a failed system suspend), plus three patches
that teach the SDCA class_function path to tag PDM data-port terminals
and the SoundWire core to treat PDM streams correctly.

The three fixes carry Fixes: tags and are Cc'd to stable; the PDM
support patches have no Fixes: tag as they add new behaviour rather
than fix a regression.

The three fixes were flagged during a sashiko review during WCD9378
SDCA codec driver patch review.

Merge strategy: patches 1-4 and patch 6 go via ASoC, patch 5 goes via
SoundWire. There is no compile-time dependency between the SoundWire
and ASoC changes: patch 5 can land in SoundWire while patches 1-4, 6
land in ASoC in any order. Patch 6's runtime behaviour depends on
patch 5 to work end-to-end on Qualcomm SDCA targets, but each tree
compiles and tests cleanly on its own.

Changes in v2:
- 2/6: switched from reordering pm_runtime_get_noresume() to dropping
  the extra reference on devm_pm_runtime_enable() failure, per
- Replaces v1 4/4 ("clear sconfig.bps on PDM data-port terminals")
  with v2 4-6/6:
  - Moved the PDM terminal-type check out of sdca_class_function.c
    into a new sdca_asoc_dai_is_pdm() helper, per Charles.
  - Signal PDM via sconfig.type = SDW_STREAM_PDM instead of clearing
    sconfig.bps, per Pierre-Louis Bossart (use the type field that
    already exists in struct sdw_stream_config).
  - Added a core SoundWire change that skips the bps mismatch check
    for SDW_STREAM_PDM so the slave's PCM-container-width bps and
    the master's PDM bps convention can co-exist without -EINVAL.
- v1: https://lore.kernel.org/all/[v1-cover-letter-message-id]/

Srinivas Kandagatla (6):
  ASoC: SDCA: propagate sdw_slave_read_prop() failure in class_read_prop
  ASoC: SDCA: drop pm_runtime reference on probe failure path
  ASoC: SDCA: re-enable IRQ on pm_runtime_force_suspend failure
  ASoC: SDCA: add sdca_asoc_dai_is_pdm() helper
  soundwire: stream: skip bps mismatch check for PDM streams
  ASoC: SDCA: class_function: mark PDM data-port terminals

 drivers/soundwire/stream.c           |  4 +++-
 include/sound/sdca_asoc.h            |  2 ++
 sound/soc/sdca/sdca_asoc.c           | 23 +++++++++++++++++++++++
 sound/soc/sdca/sdca_class.c          | 10 ++++++++--
 sound/soc/sdca/sdca_class_function.c |  3 +++
 5 files changed, 39 insertions(+), 3 deletions(-)


base-commit: 3d229ce89862b8e82d71a9e11d6f840ca272a6d6
-- 
2.53.0

