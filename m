Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718E0CA9EBD
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:11:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA280601F1;
	Fri,  9 Oct 2026 19:10:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA280601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791565869;
	bh=vY6L4NTvm/on6IWMnloYlwQJX0aRNJuGQuYsvtVGC40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JpSt7XLLOGJfDCpGGA4KqNJayjbo7QGcZBSklMYJghBLKxdrMlwgqyqwXcGlzQiMC
	 HatnCrHGJe5v0+SWk7+zWcjdXrlYhaYKR5ESt6mrXEhabjKvvFxFaiSZyYGTbDZqul
	 ArptXsJ8svoy4SeFV6qT+FQNr8JXDcMV8PfZ9dFY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A6647F80601; Fri,  9 Oct 2026 19:10:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C01ABF80600;
	Fri,  9 Oct 2026 19:10:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 989C7F80557; Fri,  9 Oct 2026 19:10:29 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791565829;
	b=bmy9e97c+4fYOjyrQyyrk1ZgVY1H/EzFXlpCKBJH4QXS8axUXw1YWkGvhYoDkKAuYygm
	 JSTv7IKEEKNseHmZryHJIwvD2CTUqjMAoKc9jqD0FMJMwf4DqiJSFpSL8RpP5XRHDdxep
	 cPrjob+hmFPWODSXo0YhyBJl0AUX3tiyDYASbv99ncc3hH1uj4kYGQjaf3F8dWVNJ02JQ
	 U2KLszslmVrrlZgg2/CzjcM/w2vVjpaCLAJSdNsq+c8kIiVMQWk9spn6svGHAmko+6gBV
	 +UFHE/+vCAJ3QLxhZCZElACOr1L/AG065Ec5YV+Ouh+LmZ5D7tHdqZMmsLOEB8cYQRg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791565829;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vY6L4NTvm/on6IWMnloYlwQJX0aRNJuGQuYsvtVGC40=;
	b=E3tSGrh855/WUGiGJLVZBXCKn8OsEBrExBl6/y6X1sZ7hskyQ2y40uMvWLmCMz5QS8VY
	 7OHsvR/y3zGfTQ/lgfTQj/lz4Mne0T9nQUI7Wzj7T6C5+GxnPuFJK+hvqmrlF2EyeN758
	 xT8gPylUQLSlRPqnkITMoKHw/kkz4+NgYhnwuIH/eCraRkD2uUaoxD7fmDGt82e+XPOFL
	 +5aPfH0v51s1dukuDsXW0nHJ55h8cuzi3zQQCY5CbgyKYr+tpQ52d5ggmm1hXoaTex2ZY
	 rKw0M83aSilsFObRZm2+GNcJBs58UWwmy+52XOkYfFfU0B1AvLQA7lcd5MLzfMFpguw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YixGXwa3;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CD9E2F8025A;
	Fri,  9 Oct 2026 19:10:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD9E2F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YixGXwa3
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EF01443D3F;
	Fri,  9 Oct 2026 17:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4448F1F0089A;
	Fri,  9 Oct 2026 17:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565823;
	bh=dmxj2lj4Q4GvWHDzZDgnLPWqXygKdSJybIHJoEn8ViA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YixGXwa3MLom9Js4zQIUKVFQdomaKuo9cj7RvEu0/wb0JhokZZMOEaTvxvCCpjvKE
	 OPZi7RwFAxnMSyrVUQEF+ez1UumpLy+NM8vTQlpd7Znls15GLowiQYFfmI8DUTsSX7
	 N3UX30F/lGzfORtfhFMy6rfYAmXg5lH3p53zliBjjaHfO2Tt3gteffSCAZJMCpfFgV
	 5AO9iYgk0Rap9dp3jxVbL/nOq/cbqmCfdSXoQL8rE6gt4rMW3lz2eBzX3kc5mbHEuC
	 9msIKk6MfZFAFyEmVhr2cIw8bVkN9jenTDbtOz/htkGYjPUfpSPPbUR5KKOlvNtgYG
	 SbgHQ+LVYgWQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	linux-sound@vger.kernel.org,
	Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH 6.6.y 0/2] asoc: backport CVE-2025-21870
Date: Fri,  9 Oct 2026 13:09:44 -0400
Message-ID: 
 <2026-10-09-1-daily-reply-0007-sof-alh-cve-2025-21870-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008190108.96660-1-artem@trailofbits.com>
References: <20261008190108.96660-1-artem@trailofbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 42565YVHUEIDTMHYYV5DHX6KK4KC37RT
X-Message-ID-Hash: 42565YVHUEIDTMHYYV5DHX6KK4KC37RT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/42565YVHUEIDTMHYYV5DHX6KK4KC37RT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> Could you please consider this series for 6.6.y?

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
