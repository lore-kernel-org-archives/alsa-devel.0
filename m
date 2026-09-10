Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F3CC88E5C
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:28:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62E36601DF;
	Wed, 16 Sep 2026 08:28:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62E36601DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789540130;
	bh=51cFfM5S3umxZrJCaooV7zSyAKYpkpsKge6vy0/4mW0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=acdGnVMBigC94kpEFyU2ODn0I9GgePwQGVGc38JM6H6luYN+c1UuJgDlid57rPsAN
	 ZokIFHMIjTKinvuXFoJM+AozEP6gVLhnNRugH4BrYcYQMXHtSp9moqKxeGFvaqARNl
	 Zg72yeaR2tQNXtnjtQiT3j2MY9/S3UXYWqkylcPY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F1D06F80609; Wed, 16 Sep 2026 08:28:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 092A2F8061E;
	Wed, 16 Sep 2026 08:28:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 892B6F8051D; Thu, 10 Sep 2026 18:27:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789057644;
	b=Amp2x+yurILrMXfEjH5xJAIXCAR0OhG8CPnQpagvf+wRl5Zo/FPFr9Ru3jQubGJyelp9
	 DioKUvhrvuxWa8qnHG0Ct7nUD/ZrN7yhDPe5Canjol8+fzx2TwZZDCY8qAV4XIaCcB+H0
	 84M02+IzfNSNZoLBkSqWHABcZ6RGvlVck7Kg6iJPAywaLSMJjYrwZIsL5ofpaZ4bTgBFl
	 FY2MZzX/ApCP5A9KgBvXyGe3AnoftC8QVXKtmovZlK9YsRUrM6g4VOeJsiJCWECOAnSxS
	 jg2Wwvi4f+Jkp2R6dSyx07AJnBUUxu2PV7hiu+pgAMlNGp2zTMzx1YZ30e6bv3EOL7w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789057644;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=51cFfM5S3umxZrJCaooV7zSyAKYpkpsKge6vy0/4mW0=;
	b=WLm0COab7vAYDF1SEoxmpjbtfLfC6sc7+mlTxYqau99vmVVzW1JtEcRaZFnPpnRBVvKn
	 gA+PNCiuxUDo7esAg09J1fD07SlX2lQ5D84NMtL8E4UwU3/JmUHgvQiywbBieD9NY21Z9
	 6t1xygcs96CIavRhzv0EBQVoFAC41Zmcdc+VGw0AhNZtM7I2S4x4fH0RQ7dm32BPd5dm0
	 msWHFlNuCE89pWJfS+ipV/nbGRkCJr0VZkikFw9DXrriL60cWtW/dxrofsZ/34EXKXKGN
	 cGsHU98zHiezpInaB/bwGeGanfi+pYFhqoSW55PdMytKO3f3dD3dgfo1hRuiuPLb9ow==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=O7bKDPWj;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A5053F8003C
	for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2026 18:27:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5053F8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=O7bKDPWj
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 44200600E2;
	Thu, 10 Sep 2026 16:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7641F00893;
	Thu, 10 Sep 2026 16:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789057641;
	bh=tWNDrqWCw8zhX+YW2XyBg3uxHDB/fBuRnMf94DdU+MA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=O7bKDPWjpZ8y2KwinEehTvAR5FwRMpG8EJ03uBXEOVxDx8tLITVyLwPwrfG9wzrtm
	 UTxG46SGygJG8jZ+FhWG2pTIWJP7HdCiCEXfiRAekgZMaGUfWBoeVMDHRHUXCMSovv
	 IZceBBu9sMu7tFZ2zyy/bPVoH8ME/A7LghS5C8Z5CJFiHawAMNP+HZURDyvkAHwcH0
	 BejqFm3aOol+R7KrI47SQPnF7/CZuTnwJDNeMSx8TwSSGwiqQVoGWS249BHu7tOxMf
	 7iTYNySaCuSBXofJ7lSonu2BLU7VrS9t9dRlHybjCtMKH36qQEOHGJMkoSiR8/kBF5
	 7jNttkDpUFMfA==
Message-ID: <f8ef053f-d73c-47d7-bb81-72ce9844069d@kernel.org>
Date: Thu, 10 Sep 2026 11:27:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 0/4] ASoC: amd: acp: SoundWire machine driver fixes
Content-Language: en-US
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, yung-chuan.liao@linux.intel.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
 Richard.Gong@amd.com, ckeepax@opensource.cirrus.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260910161728.1452808-1-Vijendar.Mukunda@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260910161728.1452808-1-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: superm1@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: Z46MOQ6G5DOICDBGO5JAKDYAG4ILJ7OA
X-Message-ID-Hash: Z46MOQ6G5DOICDBGO5JAKDYAG4ILJ7OA
X-Mailman-Approved-At: Wed, 16 Sep 2026 06:28:00 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z46MOQ6G5DOICDBGO5JAKDYAG4ILJ7OA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 9/10/26 11:16, Vijendar Mukunda wrote:
> This series fixes four defects in the AMD ACP SoundWire machine drivers
> (acp-sdw-legacy-mach.c and acp-sdw-sof-mach.c).
> 
> A bounds check is added to validate the SoundWire link ID before it is
> used as an array index in create_sdw_dailink(), preventing out-of-bounds
> access when an unexpected link_mask value is encountered. The codec
> config count in the SOF machine driver is refactored to use a dedicated
> variable rather than reusing the endpoint-count variable for two
> purposes, making the intent clearer and avoiding a stale value being
> passed to the codec config array. An operator-precedence bug in the
> ffs(link_mask - 1) expression is corrected to ffs(link_mask) - 1,
> ensuring the link ID is derived from the correct bit position. Finally,
> the SOF machine driver card name is shortened to fit within the 16-byte
> snd_card driver[] field and eliminate a compile-time warning.
> 
> Vijendar Mukunda (4):
>    ASoC: amd: acp: bounds-check SoundWire link ID in machine drivers
>    ASoC: amd: acp: refactor codec config count in SOF SoundWire machine
>      driver
>    ASoC: amd: acp: fix ffs() operator precedence for SoundWire link ID
>    ASoC: amd: acp: fix card name length warning in SOF SoundWire machine
>      driver
> 
>   sound/soc/amd/acp/acp-sdw-legacy-mach.c | 14 ++++++++++++--
>   sound/soc/amd/acp/acp-sdw-sof-mach.c    | 23 +++++++++++++++++------
>   2 files changed, 29 insertions(+), 8 deletions(-)
> 
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
