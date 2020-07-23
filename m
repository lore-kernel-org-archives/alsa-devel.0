Return-Path: <SRS0=vWr5=BC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8500C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:06:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 328752064C
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PsWB2JF2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzkjyiaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328752064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D154167E;
	Thu, 23 Jul 2020 15:05:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D154167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595509588;
	bh=D93rNzAL3USHhE9CiOsmWZA4GSaCfM1HHTv9GxgV/TQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PsWB2JF27ajh9NEqholnGT6z5FozdhYEu5s5B+qEUrAn2wR4E4+eCrq85GAjehP0h
	 w6+uUMNwaoGyX3nv00/oAp+ycj/ATsRfhUTge8Tp2ZYmKkrKucfRqj5NpvQSuDNkJj
	 rc50J8mBhDp2rHBBxppugzlm0yuIzN+jwNv7tsis=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 279B9F800CE;
	Thu, 23 Jul 2020 15:05:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21614F80212; Thu, 23 Jul 2020 15:05:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BEBA9F800CE
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2020 15:05:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BEBA9F800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="OzkjyiaW"
Received: from localhost (unknown [122.171.202.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BCA752064C;
 Thu, 23 Jul 2020 13:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595509526;
 bh=D93rNzAL3USHhE9CiOsmWZA4GSaCfM1HHTv9GxgV/TQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OzkjyiaWEP47zA/ArSXhwj8fLX4f+WunUlSeYwjiPe/ckQr0mmOcvq1LRK6nJqXtu
 DbKe/qBCHhSjtSwCH/baM6gChe+fAftSzYxX22ms5Ayh3VNCURT7gZ5rpiU5sxhCuJ
 36CAOZH6TKlC9u4hTeGeCwvTrtzy6qwXShSDQMXY=
Date: Thu, 23 Jul 2020 18:35:22 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [RFC PATCH v2 0/6] ALSA: compress: add support to change codec
 profile in gapless playback
Message-ID: <20200723130522.GB12965@vkoul-mobl>
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
 <s5hpn8mqudq.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hpn8mqudq.wl-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
 broonie@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

On 23-07-20, 14:38, Takashi Iwai wrote:
> On Tue, 21 Jul 2020 19:00:01 +0200,
> Srinivas Kandagatla wrote:
> > 
> > For gapless playback it is possible that each track can have different
> > codec profile with same decoder, for example we have WMA album,
> > we may have different tracks as WMA v9, WMA v10 and so on
> > Or if DSP's like QDSP have abililty to switch decoders on single stream
> > for each track, then this call could be used to set new codec parameters.
> > 
> > Existing code does not allow to change this profile while doing gapless
> > playback.
> > 
> > This patchset adds new SNDRV_COMPRESS_SET_CODEC_PARAMS IOCTL along with
> > flags in capablity structure to allow userspace to set this new
> > parameters required which switching codec profile, either for gapless
> > or cross fade usecase.
> 
> One idea that came up at the previous audio conference regarding this
> implementation was to just allow SET_PARAMS during the stream is
> running (only if the driver sets the capability) instead of
> introducing yet a new ioctl and an ops.
> Would it make sense?

That does sound good but only issue would be that we need to somehow
mark/document that buffer info is useless and would be discarded, how do
we do that?

> I have no big objection to add a new ioctl if other people agree,
> though.
> 
> 
> thanks,
> 
> Takashi

-- 
~Vinod
