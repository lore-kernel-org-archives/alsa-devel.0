Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6B606D80D
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=IZGhcGOd;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uCOWqGsR
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B5AB601FF;
	Mon,  2 Nov 2026 22:14:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B5AB601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793654082;
	bh=cW6qKgzk8mxeXA6HkHDZMcqXE+l3PrzoIeWlvKUlAVY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IZGhcGOdKZgdEwRyc+7x7yiMS138cQe3msv4OV4w3CL8lgr2DOOjSSXYmfYRi5Woh
	 /4lG0zXBFMqzM5hqDxs7Z+mKEb7HVYNlh4uGkBcu/s1psVOgf1O+xEmX8QnI5mB+sy
	 m/iUbXdRMK7camJO5O3BgV7EhsZDqaSnxP17iodE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 18346F80659; Mon,  2 Nov 2026 22:13:48 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 022D2F80631;
	Mon,  2 Nov 2026 22:13:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E692DF80424; Mon,  2 Nov 2026 16:12:31 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.215.58.136
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793632347;
	b=Yq7MEuTnPr9OJfxK7qdKWPQ7dBtceMuSYdH6kr4sDJWJO+af95k3mZD5YJUJh5/piYC+
	 6dG0vutDHmR73MzJoiKP1SMpGSvsttGh1FQedrRIXim9a9ktAv0KKVcjdOlQzyy5T1SGV
	 x+kNfyddC5UO9fugzbesonSdoj9bJ2tSf2mHp+WHINucLXsIwZ2iDPWPZXvssiFiefzL9
	 hQjQFMImF/DxZ2GZPoiSZjPcgyizwMtf0qpXRSitbdx5OJVO2NpzWH06RYYPW3sgjjJ1l
	 dRwlo78qjWPi7cBXPdzybghHHDxgG4+QBJidUguosrhxxNN6Bf5ppC6RN0TdEtEAxbw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793632347;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=cW6qKgzk8mxeXA6HkHDZMcqXE+l3PrzoIeWlvKUlAVY=;
	b=Vz6L9PLPN4rRAXxKS6d5p6qV+GRTfQjaYHDNaKQalqZJ3BE0eUjrXzn3Hn1yd/mIg5YZ
	 2HxmUVY+sSG4dhKcXqBmPPKxZ/DZTgf2Yu4dmeRv+TbZ/+vlJFQe634HgUR+6swjlgYwy
	 BKvfFIVcGOLw3RHNIVRyjP0aFFMFILNsXHQJDM6nk9xCUTzjcLe0nY3PbqwmQBc4DI5+o
	 gOUQUgDJVIB43Vq8qHnUAsp4bsmehgaXV0MBMLvDQEXr5h3W0CSmzBIOzVnh32kAIJXzX
	 7SEmdnbkH7uIsp1omhV2l/s768jlkCzBfjeyuV3IJHU0YiGxqrJ5U74ea+9kdp/3PWw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=uCOWqGsR;
	arc=none smtp.remote-ip=95.215.58.136
Received: from mta1.migadu.com (out-136.mta1.migadu.com [95.215.58.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 48FBAF80095
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2026 16:12:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48FBAF80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=uCOWqGsR
X-Envelope-To: alsa-devel@alsa-project.org
DKIM-Signature: a=rsa-sha256; bh=cW6qKgzk8mxeXA6HkHDZMcqXE+l3PrzoIeWlvKUlAVY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793632345; v=1; x=1794237145;
 b=uCOWqGsRZsvxMcv2Iq9cm4ThEVhyE0ItiJF4IAglrMBuOQGR6hvuatjyc6hyqEiuaAvyxWGH
 5a7fTWGjQNK8+s8IonBLnVunq+iMlBV8qwPs+ovfmfRB3MBVQT5cnVrzvR5RFTluN/34QFvq2ME
 zqiOElb4Y9SeeGbAobfD/1Mk=
X-Envelope-To: alsa-devel@alsa-project.org
Received: by smtp.migadu.com with ESMTPS id 53ac8b846c1ec72b;
	Sun, 01 Nov 2026 18:34:38 +0000
X-Mizu-Trace-ID: 53ac8b846c1ec72b
X-Migadu-Flow: FLOW_OUT
Message-ID: <3f3d7e4b-dd5a-4ef9-806e-5bc98a40d2d3@linux.dev>
Date: Sun, 1 Nov 2026 19:34:20 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/16] ASoC: amd: acp: ACP7.B/7.F SoundWire machine
 driver support
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, yung-chuan.liao@linux.intel.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
 Mario.Limonciello@amd.com, Richard.Gong@amd.com, Poojitha.N@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 sound-open-firmware@alsa-project.org
References: <20261030094714.1123396-1-Vijendar.Mukunda@amd.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20261030094714.1123396-1-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-MailFrom: pierre-louis.bossart@linux.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: P56TVMVKPQOMKVWOF6R2JGXU2BJF745Z
X-Message-ID-Hash: P56TVMVKPQOMKVWOF6R2JGXU2BJF745Z
X-Mailman-Approved-At: Mon, 02 Nov 2026 21:13:36 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/P56TVMVKPQOMKVWOF6R2JGXU2BJF745Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On 10/30/26 10:45, Vijendar Mukunda wrote:
> This series adds SoundWire machine driver support for ACP7.B and ACP7.F
> platforms. It extends the existing AMD ACP SoundWire infrastructure with
> per-platform CPU pin ID lookup, PDM controller selection via ACPI and DMI
> quirks, DMIC DAI link and components string handling, PCI subsystem ID
> propagation, and ACPI machine tables for RT721/RT722/RT1320 codec
> configurations on both platforms.
> 
> Changes in v4:
>   - Patch 1: fix missing asoc_sdw_mc_dailink_exit_loop() cleanup on
>     devm_kasprintf() failure in acp-sdw-sof-mach.c mc_probe() (new).
>   - Patch 2: fix missing asoc_sdw_mc_dailink_exit_loop() cleanup on
>     both devm_kasprintf() failure paths in acp-sdw-legacy-mach.c
>     mc_probe(); update commit message to reference the correct function
>     name soc_card_dai_links_create() instead of sof_card_dai_links_create()
>     (new).
>   - Patch 3: remove unused ACP63_SDW_MAX_CPU_DAIS define (new).
>   - Patch 5 (was 2): add comments above ACP7X_SW_AUDIO* define block
>     and get_acp7x_cpu_pin_id() to document the dedicated per-port DMA
>     layout and the port-to-use-case mapping.
>   - Patch 9 (was 6): replace misleading "No functional change" claim
>     with an accurate description of the behavioural change for platforms
>     where ignore_internal_dmic is true (dmic_num now stays zero at the
>     gate rather than reaching the dmic_num > 0 block).
> 
> Changes in v3:
>   - Patch 3: update subject and changelog to accurately describe the new
>     PDM controller selection infrastructure being added.
>   - Patch 5: fix commit subject prefix from "amd: acp7x:" to "amd: acp:"
>     since the change is in the generic ACP SoundWire machine driver
>     (acp-sdw-sof-mach.c), not the ACP7x-specific SOF driver.
> 
> Changes in v2:
>   - Patch 6: simplify the DMIC enable condition as suggested by Pierre:
>     evaluate the three-way boolean once and nest the ignore_internal_dmic
>     check inside, avoiding the double-tested condition from v1.
> 
> Vijendar Mukunda (16):
>   ASoC: amd: acp: fix missing cleanup on devm_kasprintf() failure in
>     mc_probe()
>   ASoC: amd: acp: fix missing cleanup on devm_kasprintf() failure in
>     legacy SDW machine driver
>   ASoC: amd: sdw: remove unused ACP63_SDW_MAX_CPU_DAIS define
>   ASoC: amd: acp: add ACP7.B/7.F SoundWire link count for machine driver
>   ASoC: amd: acp: add ACP7.B/7.F SoundWire DAI link support
>   ASoC: amd: acp: add PDM controller selection for ACP7.B/7.F SoundWire
>     machine driver
>   ASoC: amd: acp: log ASOC_SDW_ACP_DMIC1 quirk in SOF SoundWire machine
>     driver
>   ASoC: amd: acp: enable DMIC DAI link based on PDM controller selection
>   ASoC: amd: acp: move ignore_internal_dmic gate to DMIC enable
>     condition
>   ASoC: amd: acp: add DMIC components string for SOF SoundWire machine
>     driver
>   ASoC: amd: acp: set PCI subsystem ID for SOF SoundWire machine driver
>   ASoC: amd: acp: fix MODULE_AUTHOR missing closing angle bracket
>   ASoC: amd: acp: add ACPI machine tables for ACP7.F SoundWire
>   ASoC: SOF: amd: add alt_machines for ACP7.F SOF SoundWire
>   ASoC: amd: acp: add SoundWire machine table for ACP7.B platform
>   ASoC: SOF: amd: register SoundWire alt_machines for ACP7.B
> 
>  sound/soc/amd/acp/Makefile               |   2 +-
>  sound/soc/amd/acp/acp-sdw-legacy-mach.c  |   8 +-
>  sound/soc/amd/acp/acp-sdw-mach-common.c  |  48 ++++++
>  sound/soc/amd/acp/acp-sdw-sof-mach.c     | 109 +++++++++++--
>  sound/soc/amd/acp/amd-acp7x-acpi-match.c | 198 +++++++++++++++++++++++
>  sound/soc/amd/acp/soc_amd_sdw_common.h   |  45 +++++-
>  sound/soc/amd/mach-config.h              |   2 +
>  sound/soc/sof/amd/pci-acp7x.c            |   2 +
>  8 files changed, 396 insertions(+), 18 deletions(-)
>  create mode 100644 sound/soc/amd/acp/amd-acp7x-acpi-match.c

For the patchset:

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>

I added two nit-pick comments on naming and DMIC0/DMIC1 explanations, in
case you respin a v5.
