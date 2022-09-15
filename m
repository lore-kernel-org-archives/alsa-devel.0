Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79314ECAAD3
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Sep 2022 09:09:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6164183B;
	Thu, 15 Sep 2022 11:08:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6164183B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663232954;
	bh=5T7fANvbR8aOkxZKsm17t90nIE/N2i6lzPnLtMrGZng=;
	h=Subject:From:In-Reply-To:Date:References:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SaMhz8BiE2aQzwCIqbiLGEKyH569qQa09dlF87DV20TlFDKCm17Q3/lfJ8du0kAql
	 i52DDQRmcoLIZLw1Gsx4dwa7PCds8SK+2ngzz23I7zVMFyoGPS07RUNEW1LmkA7VNb
	 LcetOMMJDqQn9L0GZkj4OpXEWJMStWrqILE7136g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A6A5F8013D;
	Thu, 15 Sep 2022 11:08:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3DA96F800B5; Thu, 15 Sep 2022 11:08:23 +0200 (CEST)
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09B62F800B5
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2022 11:08:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09B62F800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org
 header.b="Pcpl22El"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
 t=1663232894; bh=5T7fANvbR8aOkxZKsm17t90nIE/N2i6lzPnLtMrGZng=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=Pcpl22EllOQGrrVzCCwI7v343ZqXYueCFtqmX2hj1JqswEZRjm7P/BAmKO20CTLCV
 kABvmE3rEUvznJVv/IG8M68id8aQqks6gQY7gk23+GQmdoAloa7/L73ZYsJtxSLkeG
 CKr1oQIv6VQW5MEikA70J8azkXsbCn/Ngkpdyz/M=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 04/10] ASoC: cs42l42: Split probe() and remove() into
 stages
From: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20220909135334.98220-5-povik+lin@cutebit.org>
Date: Thu, 15 Sep 2022 11:08:11 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <A40F3F43-2052-4759-BAF0-3EE0EEA270DC@cutebit.org>
References: <20220909135334.98220-1-povik+lin@cutebit.org>
 <20220909135334.98220-5-povik+lin@cutebit.org>
To: James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Lucas Tanure <tanureal@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 - <patches@opensource.cirrus.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>,
 asahi@lists.linux.dev, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Matt Flax <flatmax@flatmax.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


> On 9. 9. 2022, at 15:53, Martin Povi=C5=A1er <povik+lin@cutebit.org> =
wrote:
>=20
> To prepare for adding SoundWire the probe must be split into three
> parts:
>=20
> 1) The bus-specific probe
> 2) Common bus-agnostic probe steps
> 3) Initialization of the peripheral registers
>=20
> Step (3) must be separate because on SoundWire devices the probe must
> enable power supplies and release reset so that the peripheral can be
> enumerated by the bus, but it isn't possible to access registers until
> enumeration has completed.
>=20
> The call to devm_snd_soc_register_component() must be done at stage =
(2)
> so that it can EPROBE_DEFER if necessary. In SoundWire systems stage =
(3)
> is not a probe event so a deferral at this stage would not result in
> re-probing dependencies.
>=20
> A new init_done flag indicates that the chip has been identified and
> initialized. This is used to prevent cs42l42_remove(), =
cs42l42_suspend(),
> cs42l42_restore() and cs42l42_irq_thread() from attempting register
> accesses if the chip was not successfully initialized. Although this
> cannot happen on I2C, because the entire probe would fail, it is
> possible on SoundWire if probe succeeds but the cs42l42 is never
> enumerated.
>=20
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>

Preparing the next iteration of the series, I noticed that I reset
the authorship of this patch in the course of git manipulations. The
author of this patch is of course Richard, apologies for that. It will
be fixed for v2.

Martin

