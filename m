Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168CDC35274
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Dec 2023 14:45:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5947D83A;
	Thu, 21 Dec 2023 15:45:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5947D83A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1703169939;
	bh=qR/VUPzO8jIzabOI56INyptFUDjyYZAwRvCJFtLVKyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Yomsohd5OmaYEKcLB+KNBvizLptnEGfKVVUqmyild8NzHgFX0/BBVqXZ92/xLUQOu
	 EJvZ2dmwzzWBHPlDlile+9Iz2Uq1OE7iXWbE2b7lWfOKFC3FIAR6dQ1g1w91uDBbwy
	 8qnGE+OvPYMs1H5hVyQGhYGzdvO6OFAidOc2djKw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0E81BF80567; Thu, 21 Dec 2023 15:45:06 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6374AF80570;
	Thu, 21 Dec 2023 15:45:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C42AF80212; Thu, 21 Dec 2023 15:45:02 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2EE57F80124
	for <alsa-devel@alsa-project.org>; Thu, 21 Dec 2023 15:44:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2EE57F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=aMiNkHkT
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id BB0A0CE1FC5;
	Thu, 21 Dec 2023 14:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64839C433C7;
	Thu, 21 Dec 2023 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703169896;
	bh=qR/VUPzO8jIzabOI56INyptFUDjyYZAwRvCJFtLVKyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aMiNkHkTa6ttUo2aNbk7SwpG13CIhLkIWTlm+/wgobEqqqYSJvluX9qgtw0QbMXLH
	 s6Z/mZ34KZRw74xF7k1lmwoLA0tM4hod8E71WH+7O7vwp74k0FsP9DJecMo3OCj4Jw
	 dGISynPcXXTSMJcjrmHwZmX6XTkkyMpHHx7rQMBies4akh8yNs0ro9eXcUXw1fxfYt
	 jOiYqTI32fjWcP6zA6vAwILeLZv5+cPaTtmcrKEk49gDbJlIQOVRvMjuBmlwyKQMzr
	 KYQrfncxD3gbIanjzIPdPdsENk2QqDwiXQy/DhEKDkFHTOi19pfhX1tDxfLV9GwUwC
	 QbX8tT4RkFizg==
Date: Thu, 21 Dec 2023 20:14:51 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
	tiwai@suse.de, broonie@kernel.org, vinod.koul@intel.com,
	Bard liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	srinivas.kandagatla@linaro.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	vijendar.mukunda@amd.com,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Shuming Fan <shumingf@realtek.com>, Jack Yu <jack.yu@realtek.com>,
	Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [RFC PATCH 01/16] Documentation: driver: add SoundWire BRA
 description
Message-ID: <ZYRPYwPlzCz3jWLc@matsya>
References: <20231207222944.663893-1-pierre-louis.bossart@linux.intel.com>
 <20231207222944.663893-2-pierre-louis.bossart@linux.intel.com>
 <ZYAvoFbEP8RH_x0Y@matsya>
 <a5d0e3a7-e45c-4971-8ad7-7ba19702acf1@linux.intel.com>
 <20231218142946.GZ14858@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218142946.GZ14858@ediswmail.ad.cirrus.com>
Message-ID-Hash: FMYTY6IXJ7VEO62XYX4ZGBGJOKCFW64W
X-Message-ID-Hash: FMYTY6IXJ7VEO62XYX4ZGBGJOKCFW64W
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FMYTY6IXJ7VEO62XYX4ZGBGJOKCFW64W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 18-12-23, 14:29, Charles Keepax wrote:
> On Mon, Dec 18, 2023 at 01:58:47PM +0100, Pierre-Louis Bossart wrote:
> > > why not have a single API that does both? First check if it is supported
> > > and then allocate buffers and do the transfer.. What are the advantages
> > > of using this two step process
> > 
> > Symmetry is the only thing that comes to my mind. Open - close and send
> > - wait are natural matches, aren't they?
> > 
> > We do need a wait(), so bundling open() and send() would be odd.
> > 
> 
> I agree send->wait->close would be odd, But you just bundle close
> into wait. So the API becomes just send->wait, which seems pretty
> logical.

You would drop close as well, only send and wait...

> 
> > But you have a point that the open() is not generic in that it also
> > prepares the DMA buffers for transmission. Maybe it's more natural to
> > follow the traditional open(), hw_params(), hw_free, close() from ALSA.
> 
> I think this just makes it worse, you are now adding even more
> calls. The problem I see here is that, open and close (at least to
> me) strongly implies that you can do multiple operations between
> them and unless I have misunderstood something here you can't.
> 
> Thanks,
> Charles

-- 
~Vinod
