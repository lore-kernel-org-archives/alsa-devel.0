Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E8AC79F9E
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 00:55:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D300601DF;
	Tue,  8 Sep 2026 02:55:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D300601DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788828912;
	bh=6Aa3Oh/OYfzZjQnM5Cvru7eXWARousxI+2vlohZUiQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=T12B3Z6FfogRruE0/r5ONasLxGxBldR1SBYAGDAV7ivvgLES3soRRej68SHJc/j/C
	 QKaLSgVCuXIQoMSj5P0hc9Ux34ikmhuHSNzQuuTjpYGylEJVMEVOmueMMZkIn0jWeh
	 oUC1F9+3yKyOhXSPtYnkPmiEnD9c5Zf4Rjj+Wp2E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B36A2F80609; Tue,  8 Sep 2026 02:54:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 80815F80619;
	Tue,  8 Sep 2026 02:54:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B677F805F8; Tue,  8 Sep 2026 02:54:19 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788828857;
	b=lHqq72Q6ifH1mApSdMZyIsdxCg6DgWclsBEXixBegbPyin91e+xRWBrlOWqD0DA3y/h9
	 aPHIShykVnrETq+59p2avXEioejtGI5n8K+z8Y6DBRblI4MMeuGjy+pr46Tl/x4YcjHQP
	 cy8mjIgMvvC5Vkq9g9jWp9fkDfzYyywGI8KLT1iRodo7S5YOv8Q4BCxRVFIpYl20HaI0B
	 BQG8FI+3nQ1NAw8rSCNbaeDnMdcDJKahhvMAwjAGoZEvCXlXOO0c1OPPtVHPIHENtI9Db
	 1AQBq4p+ihCR/kWGa2r+yedbzfdmBbGihME1jvTboi6DK22s4kQ8tx2mXsyABE4FOhg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788828857;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6Aa3Oh/OYfzZjQnM5Cvru7eXWARousxI+2vlohZUiQM=;
	b=bN4RWwq0txYXiA2VFZFr0S1rxafEEctRQ1W3/wHScnGqRR5+srbhsy7gaP6uCfg+DOkQ
	 GtoBidRIvnYzboEbPYh+2Yhk22XzLu/Hem4Bj7CUMJzsO9Fe1v0wOLIfjILSs8xyByAqZ
	 NtHjNzvs1jFX6I9ejIO/lWF2rlIcuXY5oMtwntLrhSen783NrmlXhZWSPcyLLTymndJot
	 WLJDtNPhNQIdKWjr9yRcm7fN5yOfO+et+UqumFkfSDwGz2VQUUzzIVW7Dr7jh1hrwkJRe
	 DTT65TSf02amhFcoewE80fQKEUlNwL5Qih3MAblOI4fGqTMCFbqeGmkqyDfOvThDsng==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=CauG2H7A;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 708C5F80580
	for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2026 02:54:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 708C5F80580
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=CauG2H7A
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 431FF41709;
	Tue,  8 Sep 2026 00:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F6C1F00A3D;
	Tue,  8 Sep 2026 00:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828855;
	bh=RGVkylAtYY/mR1Af5vZ3OiT/YcdF1Cff9cCPpVpo22k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CauG2H7A/Af8rmb8kCAGqGfSs/kB5SzmrWVmuI1JKbGuAYa0gxVmm+Vqm524xDWkW
	 0n9ULaZUV+CHXrpTZNnyTBI+Qfvh9FVo7OkmeZx+lzHQsiFj4QVAt35gMzp7OHpSGr
	 kObA3IwXMFNze8pcRJWbOhFbt9lZB2R9dUhEV4Iff+5viDg2iu8Wwg+uSUlfofr/QW
	 4dNeCLUdbslCqetfgipL6JmLPpE6NqExlFsWEFjL6EZ+3fjoQe680LSbCJgI38PPkO
	 DiVnAzBoP1xJzPhLYh03iV5PQpVBgw46u4J4PAVg1bT+2T7DqUKwXKBXcNqg0qzsYs
	 PwUQcqWYBNgLw==
From: Sasha Levin <sashal@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Sasha Levin <sashal@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	tzungbi@kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] ALSA: seq: Fix port lock leak in
 deliver_to_subscribers()
Date: Mon,  7 Sep 2026 20:53:50 -0400
Message-ID: <2026-09-07-daily-reply-0011-alsa-seq-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87se3krhcj.wl-tiwai@suse.de>
References: <87se3krhcj.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: AKAWSJNCQIWAW2K7S66SMGPTEEFIZ2SH
X-Message-ID-Hash: AKAWSJNCQIWAW2K7S66SMGPTEEFIZ2SH
X-MailFrom: sashal@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AKAWSJNCQIWAW2K7S66SMGPTEEFIZ2SH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> The fix is correct for the stable branches.  Feel free to take my ack
>
> Reviewed-by: Takashi Iwai <tiwai@suse.de>

Thanks for the ack. Queued for 6.1.

-- 
Thanks,
Sasha
