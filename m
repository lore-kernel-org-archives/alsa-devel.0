Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C00606A322
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=m0Q6L7AG;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lCKlW3HA
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CAE7460293;
	Mon,  9 Nov 2026 16:04:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CAE7460293
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794236659;
	bh=M685jcwraRWTO2z5jw7z+IH+CyXCVQlol4ek+READi0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=m0Q6L7AGAP4RtvasK7lBtrdVRrDL+cA95e0CQqZt14nHsly5ZvRLDkFu9CW1uy+E2
	 wVwAG3s57yHcavjkss8e88qtZsbufrV51gON9kz0PHbltewmzAOSE+LPvbeUSliqBK
	 Zie2d9oWPIRkobM95kutbM6+ISXVrnn6QXvP3O5Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD221F808E7; Mon,  9 Nov 2026 16:01:20 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 02988F80BF3;
	Mon,  9 Nov 2026 16:01:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 94AD9F80510; Fri,  6 Nov 2026 14:12:04 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=91.218.175.182
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793970720;
	b=qP8h/Q46zi8iAvOOQd+odhi9ZQvNlZ+pyvAEFTh4nvkad0tHg7hgZCLq2rktv33aHFq2
	 Y80oi+nya5BBGV4D0Qc6gDIzyhVC4dvGrsLYXYNBZ3cdzyoaPGWaNl6sTxNSvitaKBH0K
	 n5w8ysce22nDbAABHwbu3J7EUcc6/diW/Qx4tChj3N9CQd0tcgNCJnhfsPgZ5cVw5uzON
	 fh9kTKXfo/8hHWStFTNH6Uf1/3hVn7TrI4I+VHqaQl/UylLLWrBLEryCPdZLfJtIgz2QG
	 i3cac90lCLGOIi/5GlwN9aF9Kgu2r5yLL2bbq5s4LUznVH5fFhHYQeAoSxPytO9nEQA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793970720;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=M685jcwraRWTO2z5jw7z+IH+CyXCVQlol4ek+READi0=;
	b=DzZrXXSnvWAyPkPYrrYAUqMklb5HJWboq6Tt5w3345FRLhSTmezZOcBOOWt3F1eb0vWK
	 L35Vg9x8LOTpwhaVXry9mcVWSaS3cxKNJA4DKusKdEzrPy/MZrDhbIziEOhOP98SzmwFP
	 dYPchSRne/El1l9fD1gQYWn6oH89ydc6Zjk0usZMuzgT++ID8saNW+9BdUX6ivZXOa1u+
	 uuS/iOSsUgGBixJ/2eO7U+1DljgtUCbXBx6GCBZ0rU+9jhz0IcrC997UI8id+UIH6r6fk
	 hteRThSdkLAoCe2SWa2eThCNrrcOBdRdK27FJXDrqglKQ6pszT43pNk6Zb8u+g5NqwA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=lCKlW3HA;
	arc=none smtp.remote-ip=91.218.175.182
Received: from mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B08AFF8024C
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 14:11:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B08AFF8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=lCKlW3HA
X-Envelope-To: alsa-devel@alsa-project.org
DKIM-Signature: a=rsa-sha256; bh=M685jcwraRWTO2z5jw7z+IH+CyXCVQlol4ek+READi0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793970715; v=1; x=1794575515;
 b=lCKlW3HA8s/pAjZZSfd1VHTi3r1fEOx0vPHU+VekO7bw3+bIYEaVEMNyqjyzgfvuyg2X4XSX
 wuPdKxOZIDpYjbLpsWSCfw9kJmfGZdAwcZgQwRk6flrHm9GT9rxCHNdP6zdb/EV4TXqqdrKMTkq
 8QxF+tGS5dwfeOBgxtK1pBMs=
X-Envelope-To: alsa-devel@alsa-project.org
Received: by smtp.migadu.com with ESMTPS id b1afb51c95a7749d;
	Fri, 06 Nov 2026 13:11:55 +0000
X-Mizu-Trace-ID: b1afb51c95a7749d
X-Migadu-Flow: FLOW_OUT
Message-ID: <efd5f1ed-4f45-451b-8ad8-212efebf2d8f@linux.dev>
Date: Fri, 6 Nov 2026 14:11:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ASoC: amd: acp: supplement patches for ACP7.B/7.F
 SoundWire machine driver series
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, yung-chuan.liao@linux.intel.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
 Mario.Limonciello@amd.com, Richard.Gong@amd.com, Poojitha.N@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261106130801.506026-1-Vijendar.Mukunda@amd.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20261106130801.506026-1-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-MailFrom: pierre-louis.bossart@linux.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: ZLBYCBNG4AGOHGE63JIETK7VKY6YQQHU
X-Message-ID-Hash: ZLBYCBNG4AGOHGE63JIETK7VKY6YQQHU
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:00:52 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZLBYCBNG4AGOHGE63JIETK7VKY6YQQHU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On 11/6/26 14:07, Vijendar Mukunda wrote:
> These two patches address nit-picks raised in review of the ACP7.B/7.F
> SoundWire machine driver series posted at:
> 
>   https://lore.kernel.org/all/20261030094714.1123396-1-Vijendar.Mukunda@amd.com/
> 
> These patches were previously posted as replies to the original
> series. Posting them now as a standalone series to keep the dependency
> clear and avoid threading new patches under the existing review.
> 
> Patch 1 renames three static adr_device arrays in amd-acp7x-acpi-match.c
> to reflect their endpoint set rather than their structural role, making the
> distinction between jack+dmic (combo with RT1320) and jack+amp+dmic
> (standalone) self-explanatory.
> 
> Patch 2 adds a block comment above the ASOC_SDW_ACP_DMIC and
> ASOC_SDW_ACP_DMIC1 quirk bit definitions to document the dual-PDM-
> controller hardware model of ACP7.B/7.F, and annotates each bit with its
> role.  ASOC_SDW_ACP_DMIC is a generic DMIC-enable flag on all ACP
> platforms; on ACP7.B/7.F it additionally identifies the PDM0 controller.
> ASOC_SDW_ACP_DMIC1 is ACP7.B/7.F-specific for PDM1.  BIOS wires exactly
> one controller per platform.
> 
> Vijendar Mukunda (2):
>   ASoC: amd: acp: fix adr_device naming in ACP7.x ACPI match table
>   ASoC: amd: acp: document PDM controller topology for ACP7.B/7.F
> 
>  sound/soc/amd/acp/amd-acp7x-acpi-match.c | 22 +++++++++++-----------
>  sound/soc/amd/acp/soc_amd_sdw_common.h   | 11 +++++++++--
>  2 files changed, 20 insertions(+), 13 deletions(-)

thanks for the patches

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>


