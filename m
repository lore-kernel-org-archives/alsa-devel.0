Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14419CDB46F
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:11:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C51A601EF;
	Tue, 23 Jun 2026 14:11:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C51A601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782216706;
	bh=vLSk0bzdNmyr+K0pOyx3AJyRLMoI+Vv+4Ce9/7yuHjw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=I20PJDgtPqIJFKYTKtRa4lWKUrr5MlG+ueCDQM5zP5L08VyLEh4pbJZqXVQNC13Jj
	 VgmMK4W9E8sDzSdeyn8T96i9p4+vcLPtwy5vxAB01ZePtjGVdTHswHih4NhZnNWW5/
	 KGtfDaME5biPnY/MPzH5RVjbGh5CxgotX0aBF2MQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 694BAF805BA; Tue, 23 Jun 2026 14:11:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B2CF1F805F8;
	Tue, 23 Jun 2026 14:11:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1B465F80579; Tue, 23 Jun 2026 14:11:07 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782216666;
	b=VIQXFDFPfQmy9UETf/BnZDDEng8BHAAXchXGAylNfrOy+f5rglacMphqKjE2HTANrTyh
	 pbeEP6cEOx22Bb49BmqP9CuW6vstGRTZ5UX8ckQj/YprbIKlj0lu3PBLZ3VZJhLUAYdaz
	 jBRNzPArivNh3MKn+bt4fEFhYC3dEY+aZ0lXbxJvwzOpYvqkVKNm7pT8iflOFi1YoegnV
	 yxYaawE09/fKys3Qec8JG7jlNz4hp90FubvAPK7u0XZHTGVWTUOQXCnWDGmXu2FAAag81
	 SbXFBsejPIwJ6LCQWP73DPnbFYuC1id44o0UlEmF7M0PTXHnhtck8ua2yY4GbAaWtgA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782216666;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=vLSk0bzdNmyr+K0pOyx3AJyRLMoI+Vv+4Ce9/7yuHjw=;
	b=nX4tyWaCODygKEXa5+t7HEpTfdl8/MwU+UfNWQKZNEpRKZMthyalOyLfzjrDC+NDSGlv
	 9fyw7ricSJPR1WRBh7UA8fpoK5h75RfwM22GaAZqicOJMQECGzj60KgcokpZxt3g43YFz
	 cRs885fC5H0i1LyagMKSSRXr2wUYGIe+l3/KWgj+YG9jbFyCZFaRS43rp0JCRFpRmYvNx
	 4wIBX2HmWV4wnBVNojSRm+ayknWkh6ANlnzbAtQd55jVD66Oa/Me2xw5fLnACiygVY7lM
	 Mln9/qJZ5dkHImPosz9GWcP+qBwjhx8YgLT1R+M6+jkzNKFgsB9QHiB7RKY0ROBgc9g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F56CF8045D
	for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2026 14:11:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F56CF8045D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bbb49d25b60900-webhooks-bot@alsa-project.org>
In-Reply-To: <18bbb49d24d3df00-webhooks-bot@alsa-project.org>
References: <18bbb49d24d3df00-webhooks-bot@alsa-project.org>
Subject: SSL2+ MKII shows [ALSA UCM Error] on Fedora 44 KDE
Date: Tue, 23 Jun 2026 14:11:07 +0200 (CEST)
Message-ID-Hash: LBC5MZGTAPIKCLSZLIF5OVR2T5NCUXUZ
X-Message-ID-Hash: LBC5MZGTAPIKCLSZLIF5OVR2T5NCUXUZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LBC5MZGTAPIKCLSZLIF5OVR2T5NCUXUZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #795 was opened from a118n:

Wireplumber errors:
```
Jun 23 14:58:05 Obelisk wireplumber[2084]: spa.alsa: Error in ALSA UCM profile for _ucm0001.hw:II,0 (HiFi: Line2: sink): PlaybackChannels=4 < avail 6
Jun 23 14:58:05 Obelisk wireplumber[2084]: spa.alsa: Error in ALSA UCM profile for _ucm0001.hw:II,0 (HiFi: Mic2: source): CaptureChannels=4 < avail 8
```

Firmware version: 1.16

alsa info attached

[alsa-info.txt](https://github.com/user-attachments/files/29249939/alsa-info.txt)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/795
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
