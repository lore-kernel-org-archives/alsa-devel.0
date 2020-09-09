Return-Path: <SRS0=lIjM=CS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91050C433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:57:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C26208FE
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AXBU1KUH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xDYefFct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C26208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BCF8016F5;
	Wed,  9 Sep 2020 09:56:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BCF8016F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599638231;
	bh=JARiYueBjjGPlebhXcfjdVe1PdGZejQ1v9IQ50hAApA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AXBU1KUHmBvvWP2bORxDdh183kZBcf1iDcW+UnYp4JVNF1UNLxlv3WPQW7daYFJUm
	 QvxntSppiJHaNCx9U8KYwfgxkWMDiSweUk3EJ/LXdzZ7r6Pig7iu8HImj/9sdNOU1l
	 3fyhGyjnftupHkl/op6txZPCBCSiSTQurUCEkCek=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B42DF8015F;
	Wed,  9 Sep 2020 09:56:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0D4DF80227; Wed,  9 Sep 2020 09:56:17 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB798F800FD
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2020 09:56:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB798F800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="xDYefFct"
Received: from localhost (unknown [122.179.21.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7508F2087C;
 Wed,  9 Sep 2020 07:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599638165;
 bh=JARiYueBjjGPlebhXcfjdVe1PdGZejQ1v9IQ50hAApA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xDYefFctxhwXQbotzFIaWwJRSkw/f/qoeiMWJ8/r6KjzfmC4qqvetpY5qNmqI6l+J
 i4WnFSoEuohmVoItnSzX23DYn3OawZOmywupJUQN3/9nNiD9L8FkUnNMTWXesGCzF5
 MFDGj9q6EdlJ+6MdFNJFpgWVyORi0/LIdgzO9ldM=
Date: Wed, 9 Sep 2020 13:25:55 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 2/3] soundwire: SDCA: add helper macro to access
 controls
Message-ID: <20200909075555.GK77521@vkoul-mobl>
References: <20200901162225.33343-1-pierre-louis.bossart@linux.intel.com>
 <20200901162225.33343-3-pierre-louis.bossart@linux.intel.com>
 <20200904050244.GT2639@vkoul-mobl>
 <f35a0ae7-2779-0c69-9ef3-0d0e298888ac@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f35a0ae7-2779-0c69-9ef3-0d0e298888ac@linux.intel.com>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 tiwai@suse.de, gregkh@linuxfoundation.org,
 open list <linux-kernel@vger.kernel.org>, broonie@kernel.org,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

On 08-09-20, 08:33, Pierre-Louis Bossart wrote:
> Thanks for the review Vinod,
> 
> > This is good, thanks for adding it in changelog. Can you also add this
> > description to Documentation (that can come as an individual patch),
> 
> ok
> 
> > > +/*
> > > + * v1.2 device - SDCA address mapping
> > > + *
> > > + * Spec definition
> > > + *	Bits		Contents
> > > + *	31		0 (required by addressing range)
> > > + *	30:26		0b10000 (Control Prefix)
> > 
> > So this is for 30:26
> 
> I don't get the comment, sorry.

I should have added see below.

> > 
> > > + *	25		0 (Reserved)
> > > + *	24:22		Function Number [2:0]
> > > + *	21		Entity[6]
> > > + *	20:19		Control Selector[5:4]
> > > + *	18		0 (Reserved)
> > > + *	17:15		Control Number[5:3]
> > > + *	14		Next
> > > + *	13		MBQ
> > > + *	12:7		Entity[5:0]
> > > + *	6:3		Control Selector[3:0]
> > > + *	2:0		Control Number[2:0]
> > > + */
> > > +
> > > +#define SDW_SDCA_CTL(fun, ent, ctl, ch)						\
> > > +	(BIT(30)							|	\
> > 
> > Programmatically this is fine, but then since we are defining for the
> > description above, IMO it would actually make sense for this to be defined
> > as FIELD_PREP:
> > 
> >          FIELD_PREP(GENMASK(30, 26), 1)
> > 
> > or better
> > 
> >          u32_encode_bits(GENMASK(30, 26), 1)
> > 
> > > +	FIELD_PREP(GENMASK(24, 22), FIELD_GET(GENMASK(2, 0), (fun)))	|	\
> > 
> > Why not use u32_encode_bits(GENMASK(24, 22), (fun)) instead for this and
> > below?
> 
> Because your comment for the v1 review was to use FIELD_PREP/FIELD_GET, and
> your other patches for bitfield access only use FIELD_PREP/FIELD_GET.

yes and looking at this, I feel u32_encode_bits(GENMASK(24, 22), (fun))
would look better than FIELD_PREP(GENMASK(24, 22), FIELD_GET(GENMASK(2, 0), (fun)))

Do you agree?

> 
> I really don't care about which macro is used but it wouldn't hurt to have
> some level of consistency between different parts of the code? Why not use
> FIELD_PREP/GET everywhere?
> 
> > > +	FIELD_PREP(BIT(21), FIELD_GET(BIT(6), (ent)))			|	\
> > > +	FIELD_PREP(GENMASK(20, 19), FIELD_GET(GENMASK(5, 4), (ctl)))	|	\
> > > +	FIELD_PREP(GENMASK(17, 15), FIELD_GET(GENMASK(5, 3), (ch)))	|	\
> > > +	FIELD_PREP(GENMASK(12, 7), FIELD_GET(GENMASK(5, 0), (ent)))	|	\
> > > +	FIELD_PREP(GENMASK(6, 3), FIELD_GET(GENMASK(3, 0), (ctl)))	|	\
> > > +	FIELD_PREP(GENMASK(2, 0), FIELD_GET(GENMASK(2, 0), (ch))))
> > 
> > Also, can we rather have a nice function for this, that would look much
> > cleaner
> 
> I am not sure what would be cleaner but fine.

Ok

> > And while at it, consider defining masks for various fields rather than
> > using numbers in GENMASK() above, that would look better, be more
> > readable and people can reuse it.
> 
> Actually on this one I disagree. These fields are not intended to be used by
> anyone, the goal is precisely to hide them behind regmap, and the use of raw
> numbers makes it easier to cross-check the documentation and the code.
> Adding a separate set of definitions would not increase readability.

Which one would you prefer:

        #define SDCA_FUN_MASK           GENMASK(24, 22)

        foo |= u32_encode_bits(SDCA_FUN_MASK, fun)

Or the one proposed...?

-- 
~Vinod
