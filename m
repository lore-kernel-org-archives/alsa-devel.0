Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5360C35274
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Dec 2023 14:45:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3919DF0;
	Thu, 21 Dec 2023 15:44:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3919DF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1703169901;
	bh=g9H/wip9okyMkI7qxjfibvkApC+JionIjkmsvnCQ86M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jDWB17SyU+ERgROh/Q9GTYmSI97Dvs9gQV0XLbBYs+eFReOYe3xROelPopo/P24LO
	 76NhF7B/kcr3qoZ5m/p3qWiRANt09PPLdK9PRo6Y0RQ1FQjNttOnG9v2BzIXOEqDOk
	 /ax2uF7FN0TXE3XXsa+W1p0eKk4J3oPTDZlxKHzQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E9A57F80589; Thu, 21 Dec 2023 15:44:26 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FD43F80571;
	Thu, 21 Dec 2023 15:44:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EEB62F80153; Thu, 21 Dec 2023 15:44:21 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E8F00F800F5
	for <alsa-devel@alsa-project.org>; Thu, 21 Dec 2023 15:44:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8F00F800F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SaPXCqjB
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 74CE3CE1F83;
	Thu, 21 Dec 2023 14:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AB1C433C9;
	Thu, 21 Dec 2023 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703169853;
	bh=g9H/wip9okyMkI7qxjfibvkApC+JionIjkmsvnCQ86M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SaPXCqjB40+3Toi+YpMPNVzvMqUhEi8Pq2DTWxKvv0Q14fhLGemz0Z89JkFSkoZqJ
	 dlovHK0040LgL6fZepCuoMXpjGM8o4seAeXMRWgtxSDoA0tlmOH2ByijfCr5GIyQ60
	 17KVp/YvSLVyF/1tRxBW5DGCXNBVqQFyuivWNaakyMq7Z7gQ8VJWyNxJQFfrdPS1j3
	 5tR8vARcOo2V57vVmGUu7Y8jGvxmZVjeB55g8jf1CjdX4accE1lrpv0gH2mHHLxRVS
	 opwdVQV6PnOjx6+3x+xSVJreKK3BPNCw4Tv4NZqu7p5m4LEHkGY8O5ol8oll4qoCHI
	 KWA3aLdwpCEtg==
Date: Thu, 21 Dec 2023 20:14:09 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.de,
	broonie@kernel.org, vinod.koul@intel.com,
	Bard liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	srinivas.kandagatla@linaro.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	vijendar.mukunda@amd.com,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Shuming Fan <shumingf@realtek.com>, Jack Yu <jack.yu@realtek.com>,
	Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [RFC PATCH 01/16] Documentation: driver: add SoundWire BRA
 description
Message-ID: <ZYRPOckODRGNNZli@matsya>
References: <20231207222944.663893-1-pierre-louis.bossart@linux.intel.com>
 <20231207222944.663893-2-pierre-louis.bossart@linux.intel.com>
 <ZYAvoFbEP8RH_x0Y@matsya>
 <a5d0e3a7-e45c-4971-8ad7-7ba19702acf1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5d0e3a7-e45c-4971-8ad7-7ba19702acf1@linux.intel.com>
Message-ID-Hash: USRDSBKEEF4AC2HGUM7UPGWMPXE6JKP3
X-Message-ID-Hash: USRDSBKEEF4AC2HGUM7UPGWMPXE6JKP3
X-MailFrom: vkoul@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/USRDSBKEEF4AC2HGUM7UPGWMPXE6JKP3/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 18-12-23, 13:58, Pierre-Louis Bossart wrote:
> 
> >>  Documentation/driver-api/soundwire/bra.rst    | 478 ++++++++++++++++++
> > 
> > Can we split the cadence parts of this to bra-cadence.rst that way this
> > file documents the core parts only
> 
> Yes, we can split the Cadence parts out.

Great

> 
> 
> >> +Error handling
> >> +~~~~~~~~~~~~~~
> >> +
> >> +The expected response to a 'bra_message' and follow-up behavior may
> >> +vary:
> >> +
> >> +   (1) A Peripheral driver may want to receive an immediate -EBUSY
> >> +       response if the BRA protocol is not available at a given time.
> >> +
> >> +   (2) A Peripheral driver may want to wait until a timeout for the
> >> +       on-going transfer to be handled
> >> +
> >> +   (3) A Peripheral driver may want to wait until existing BRA
> >> +       transfers complete or deal with BRA as a background task when
> >> +       audio transfers stop. In this case, there would be no timeout,
> >> +       and the operation may not happen if the platform is suspended.
> > 
> > Is this runtime suspend or S3/S4 case?
> 
> System suspend (which can also mean S0i1).
> 
> I don't think we can have a case where a peripheral driver waits on
> something without having done a pm_runtime_get_sync() to prevent
> runtime_pm suspend.
> 
> > 
> >> +BTP/BRA API available to peripheral drivers
> >> +-------------------------------------------
> >> +
> >> +ASoC Peripheral drivers may use
> >> +
> >> +   - sdw_bpt_stream_open(mode)
> >> +
> >> +      This function verifies that the BPT protocol with the
> >> +      'mode'. For now only BRA is accepted as a mode. This function
> >> +      allocates a work buffer internally. This buffer is not exposed
> >> +      to the caller.
> >> +
> >> +     errors:
> >> +         -ENODEV: BPT/BRA is not supported by the Manager.
> >> +
> >> +         -EBUSY: another agent is already using the audio payload for
> >> +          audio transfers. There is no way to predict when the audio
> >> +          streams might stop, this will require the Peripheral driver
> >> +          to fall back to the regular (slow) command channel.
> >> +
> >> +         -EAGAIN: another agent is already transferring data using the
> >> +          BPT/BRA protocol. Since the transfers will typically last
> >> +          10s or 100s of ms, the Peripheral driver may wait and retry
> >> +          later.
> >> +
> >> +    - sdw_bpt_message_send_async(bpt_message)
> > 
> > why not have a single API that does both? First check if it is supported
> > and then allocate buffers and do the transfer.. What are the advantages
> > of using this two step process
> 
> Symmetry is the only thing that comes to my mind. Open - close and send
> - wait are natural matches, aren't they?

Why have symmetry to DAI apis, why not symmetry to regmap write APIs..?
This is data transfer, so I am not sure why would we model it as a DAI.
(Internal implementation may rely on that but from API design, i dont
think that should be a concern)

> 
> We do need a wait(), so bundling open() and send() would be odd.
> 
> But you have a point that the open() is not generic in that it also
> prepares the DMA buffers for transmission. Maybe it's more natural to
> follow the traditional open(), hw_params(), hw_free, close() from ALSA.

-- 
~Vinod
