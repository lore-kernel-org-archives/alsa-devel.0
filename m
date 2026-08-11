Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBF4C5AC67
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:59:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BFB860202;
	Tue, 11 Aug 2026 10:59:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BFB860202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786438753;
	bh=VzxeI3GoFOSVpVnNpPeO9ClCrkfMkQPqjlMHsH3DoiU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DTtfDXg2u30+i5aPH9acMKm8y//61F7E74hJHEmDbcZ0sFD5MKGsuPMaOXfTQfNZx
	 OgDekTivvwlrMbtS/HcIj/c8Rx4IqMPuMQazJso3NKix5t3d3DVm6rmSU2DDQeqXEw
	 vLrnkaheDyL5zk+GoyLl0fDGMO2oyllXTm0AEKLI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C3C7F805FB; Tue, 11 Aug 2026 10:58:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4FEAFF805F4;
	Tue, 11 Aug 2026 10:58:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4A66EF804E5; Tue, 11 Aug 2026 10:58:30 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786438709;
	b=mrG/bTFoPtsI6hS/aVyr2FzkRiPoHo8qUgVi0JcGpldvO2PgzEo3PJAHXY3m0y9cShqG
	 FgH8S1WYnDR+AmFyMEyfYj3HTRKTEP/bEv0mxGXs3gs663Ldac+InGJUGcUvZk5d8tfz3
	 zM5T4xg36/hHcdVaiRER8qKCdOOtQ1/JivPBobEIKPKqTljZ/53bjEUP7kr5JphyvlwB0
	 DtUhA4PBmGClPu/uFe9DJ1GQZ2+tNWNypSbw+QD1zLJVqp6YjeJHF9PBRrbx9sjrrH8GK
	 X/5x4tdWEjMbIVqfBAPcx8If0WWMk/MiJK7cLuGLlxTtmBkrQJIiHXcvtZH3OQkSE+w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786438709;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=VzxeI3GoFOSVpVnNpPeO9ClCrkfMkQPqjlMHsH3DoiU=;
	b=VX/qmzfukUIEuBBn6Xji8hDrFTrhrqpaQkTpZ74nLsYhpqMVBI1VXustWM4Mt7e3t662
	 nCj1ENxap14p70ZuTsJzU+KgE3/SbgRjEiO1ziLItHb3JQBRKk3kQB4Pn/zc0USEJJq9z
	 XKJP2dG8fz/h5JQ3/Ueki0nGIaMGPwzDIKs/kd38y5DFd849yCGADPsqMooLcU7UhQ7i8
	 4+eLPe0iH/fvXLeRK7a3NVmwAO6fRJvo9kC1m1CiHH+GQbL153jgKO00Ef1hdcRvVi6jY
	 5pirjo5qRnmpCVNObvQ7AQW5x/sKmoRrvpBV/UX9+Zeh7JPm7JgriuftRjQcGvClQmA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id C21C2F8032D
	for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2026 10:58:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C21C2F8032D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cab48a3df64600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/tinycompress/pr/39@alsa-project.org>
References: <alsa-project/tinycompress/pr/39@alsa-project.org>
Subject: src: utils: Add ccaps to query compress device capabilities
Date: Tue, 11 Aug 2026 10:58:30 +0200 (CEST)
Message-ID-Hash: HC3GG25R5I6HWC6YKEL6CJDUVQDXNRZL
X-Message-ID-Hash: HC3GG25R5I6HWC6YKEL6CJDUVQDXNRZL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HC3GG25R5I6HWC6YKEL6CJDUVQDXNRZL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/tinycompress pull request #39 was opened from ujfalusi:

Add a small utility to dump the capabilities of a compress device. It uses the same device selection style as cplay (-c card, -d device) and prints the protocol version, direction, fragment size/count limits and the list of supported codecs.

For each codec the SNDRV_COMPRESS_GET_CODEC_CAPS descriptors are printed as well. Drivers not implementing the codec caps ioctl are reported instead of treated as an error.

The direction is derived from the open flags by the core, so by default the device is opened for playback first and for capture as fallback. It can be forced with -D p|c.

Example output:

  $ ccaps -c0 -d50
  Compress device hw:0,50
    protocol version:  0.4.1
    direction:         playback
    fragment size:     38400 - 131072 bytes
    fragments:         3 - 64
    codecs:            4
    [0] AAC (0x6)
    [1] MP3 (0x2)
    [2] VORBIS (0x9)
    [3] PCM (0x1)

Request URL   : https://github.com/alsa-project/tinycompress/pull/39
Patch URL     : https://github.com/alsa-project/tinycompress/pull/39.patch
Repository URL: https://github.com/alsa-project/tinycompress
