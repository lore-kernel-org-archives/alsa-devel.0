Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB2E606A32C
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=BCrF+2af;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ShS8XVxx
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7023601F9;
	Mon,  2 Nov 2026 14:46:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7023601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793627223;
	bh=VicT/YUdGiJ6Cr7rMS8iYjcfBaYab6ltk8ob32ealIQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BCrF+2afiv9eT1tdDP1xSjblYJoiNwreu2dKiiRIACezeOOwzmec+PQvAYb3z4LC+
	 LqEB2zsI/7uHbCziaC0q6Idu/pCtkGs53h/kxrK1qHDRw0n3QjvEOiPJp2wjuKfNBY
	 mrEGAZVayOlAoemVmGGiuarMPizDiQzYAnczPC4o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D523EF80606; Mon,  2 Nov 2026 14:46:28 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C62A9F805F6;
	Mon,  2 Nov 2026 14:46:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AC01AF804B4; Mon,  2 Nov 2026 14:46:22 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 26A8FF80095
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2026 14:46:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26A8FF80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ShS8XVxx
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 782BF60F4D;
	Mon,  2 Nov 2026 11:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D3D1F00A1A;
	Mon,  2 Nov 2026 11:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793618472;
	bh=LOFuYQz5j6DmIjE/Q+g11UkPLw7GOVvDSuUkb+wz1/c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ShS8XVxxkrOTl1Sn3gFl76mVmG1hta04ifCwJwBPSRvOQkX4X3Q+F0Dkde2tlLhSt
	 H9kiywZP6DlTl9c2E+NzcXezOfwdNJwCSbZhsOpM7YQMTLoVECG1IRv4N+Anm21/4W
	 U6rRckaK1edfSfMgSRvXP8G7dbb8RrlUAZgVLaXW3ztM6KJs2abQP3uVpwOyKpGost
	 RHtImOGJnlnZcBGkZ4JLUlrJHXC2oyEAdpBEzcCufPMwJZR/w9T4PWuM93HNfSNQAL
	 KYPky/jaXKiY5MC1esdDp26LD+96eWTkQihKYqfSDJrnCYYndw+QE58J6Jx9O+lUqV
	 pMcpaRDsyaJyw==
From: Vinod Koul <vkoul@kernel.org>
To: Mark Brown <broonie@kernel.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Maciej Strozek <mstrozek@opensource.cirrus.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Sanyog Kale <sanyog.r.kale@intel.com>, Takashi Iwai <tiwai@suse.com>,
 patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/6] ASoC: SDCA: class-driver fixes and PDM
 data-port support
Message-Id: <179361846817.71449.16862116006916454790.b4-ty@kernel.org>
Date: Mon, 02 Nov 2026 16:51:08 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
Message-ID-Hash: J2NMKLHH6BVEM5GMIY3SIHEZW4S6FB2T
X-Message-ID-Hash: J2NMKLHH6BVEM5GMIY3SIHEZW4S6FB2T
X-MailFrom: vkoul@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J2NMKLHH6BVEM5GMIY3SIHEZW4S6FB2T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>


On Tue, 20 Oct 2026 08:38:50 +0100, Srinivas Kandagatla wrote:
> Three small fixes in the SDCA class driver (propagating a read_prop
> failure, dropping an extra pm_runtime reference on probe failure, and
> re-enabling the IRQ on a failed system suspend), plus three patches
> that teach the SDCA class_function path to tag PDM data-port terminals
> and the SoundWire core to treat PDM streams correctly.
> 
> The three fixes carry Fixes: tags and are Cc'd to stable; the PDM
> support patches have no Fixes: tag as they add new behaviour rather
> than fix a regression.
> 
> [...]

Applied, thanks!

[5/6] soundwire: stream: skip bps mismatch check for PDM streams
      commit: afd88e7ad78170040612f608203734156b8a9eb1

Best regards,
-- 
~Vinod


