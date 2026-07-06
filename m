Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ED1C44501
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:46:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4784860214;
	Mon,  6 Jul 2026 15:46:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4784860214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783345612;
	bh=G+V5mq9CoCDw3jcj7Gbs5q9zgJuDpi/s+Ojb1o1qBKk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=LAXt3degQ6QYvZBo8Y2RxqOMjTaQnnTmvq7rd2XntBEmuJo0X0xH1mWcNQu5PiLE5
	 sHt9yBmgKFgx5T1yYvsd2LtSQun9rSsuhAOwHZDTCV66ru76qyZ9JnR0GF8a7fNfa9
	 dPH2ld3oIBLRNPabHcIcAl2sIGBpHfHthDOjBTxg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E781EF805F4; Mon,  6 Jul 2026 15:46:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 89344F805EC;
	Mon,  6 Jul 2026 15:46:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0719FF80524; Mon,  6 Jul 2026 15:46:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783345570;
	b=RKnZkZEWqYC23fOLlvHb1KwLac1MUWQ5RTd9vxsaDXOIFC0Cputh2uH69I+7iseI+31u
	 nZBZTrhVXenMRCxzurgZCG011x9jA2Qjim3QjVnnz78R9Zpql/Ygvp52/6JbUDLm2i4TY
	 tBwcIE7t1URlN42SWc2va9XmiLij0qexqGZl3OIMA17oYC7kLzU1X0+nzZBdC09eJe/MQ
	 qGrH4Di1K/GvTVLwEvkvife37eExbenn3f71DTHyVkLTDRnipaYHpAXWJJKFJqL6pDegj
	 RSpD8Ay3Y7uCiJRJIYIN5HqaSZi/yjUheSrRcS7s3FzCFshk4/yuyc0FxYiOA2KWLvQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783345570;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=G+V5mq9CoCDw3jcj7Gbs5q9zgJuDpi/s+Ojb1o1qBKk=;
	b=jqYT1lBPy5qnJrdagMdgQ1uwOslimccCjl+0HM1Lm7Fm4UkXdMj93tCO8koNZrdVUSK8
	 kUR6JLzz41tusSp80bmTBD6hC8UXW7ptd1hH1dTnMYwcly6lFeWrWSiC2tomC+FGpaCU4
	 mxfyImP2sMtDjUe/DVyOvfuBBRLUlLBxiXHnIsj9GFjPyA9nRPE7Z33N1I5EH+878HA3Z
	 9MVeSUTuCoC8znJZAdoKyq1G9FgXkdqhQK7QU7hzcHIXnEMNdJykZIEaxHXWFmdrH94Vb
	 kKdFk5I1U0fmqOmCUfk/CAM62FUo/uQsYDxnpmX/AS1d9gbu7JXLcCMv+Wv6GvSECsQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1BA19F8025A
	for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2026 15:46:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1BA19F8025A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bfb75896a98300-webhooks-bot@alsa-project.org>
In-Reply-To: <18bfb758969b4d00-webhooks-bot@alsa-project.org>
References: <18bfb758969b4d00-webhooks-bot@alsa-project.org>
Subject: rt721: capture switches (FU0F/FU1E) default to OFF on AMD SoundWire
Date: Mon,  6 Jul 2026 15:46:11 +0200 (CEST)
Message-ID-Hash: FSXWTMSFXD5H6NBYLKGVICVZZYZ6WGZV
X-Message-ID-Hash: FSXWTMSFXD5H6NBYLKGVICVZZYZ6WGZV
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FSXWTMSFXD5H6NBYLKGVICVZZYZ6WGZV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #805 was edited from BenSharir:

The RT721 codec capture switches for ASUS ProArt PX13 (AMD SoundWire) default to OFF, which mutes the DMIC microphone.

**Symptom**: Microphone records silence despite being selected in system settings.

**Cause**: The following ALSA mixer controls are off by default:
- `rt721 FU0F Capture Switch`: off,off
- `rt721 FU1E Capture Switch`: off,off,off,off

**Proposed Fix**: The UCM profile should enable these switches by default in the HiFi verb.

**Hardware**:
- Laptop: ASUS ProArt PX13 HN7306EAC
- Chipset: AMD ACP70 SoundWire
- Codec: Realtek RT721
- Card components: `cfg-amp:2 mic:acp-dmic cfg-mics:1 hs:rt721`

**System Info**:
- OS: Fedora 44
- Kernel: 7.0.13-200.fc44.x86_64
- alsa-ucm: 1.2.16.1-1.fc44

**Workaround**:
```bash
amixer -c 1 cset name='rt721 FU0F Capture Switch' on,on
amixer -c 1 cset name='rt721 FU1E Capture Switch' on,on,on,on
```

**Verification**:
```bash
# Record 5 seconds of audio
timeout 5 arecord -D hw:amdsoundwire,4 -f S32_LE -r 48000 -c 2 /tmp/mic-test.wav
# Play back
aplay /tmp/mic-test.wav
```

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/805
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
