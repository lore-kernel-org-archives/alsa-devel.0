Return-Path: <SRS0=iKRb=DH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA37C4727E
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:11:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BBEC2076E
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cdWtbM7i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kfv/VbF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBEC2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E61381804;
	Wed, 30 Sep 2020 14:11:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E61381804
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601467917;
	bh=6S8w3/dR+DtjyosgRVlanSKikC5vLhD5x2kP86xGkUw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cdWtbM7iHsvQz4cZ/D8gR3oDphcwXguLOBN812iZHqjn9VGgUKxxeB9LVmKyKJfxx
	 Hg5BMlppDNS0itGZL9S1QtlsgCIrrQwfe+icHACtbrsFAg+h4D13ugkQQ2boHhy/uy
	 bm5xwk7PZkbWvF/XG6axJYd/oKzd7Su58fw/kr3k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 755EEF801ED;
	Wed, 30 Sep 2020 14:11:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C1DDF80247; Wed, 30 Sep 2020 14:11:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06A8CF801ED
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2020 14:10:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06A8CF801ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Kfv/VbF9"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DCD85206B7;
 Wed, 30 Sep 2020 12:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601467856;
 bh=6S8w3/dR+DtjyosgRVlanSKikC5vLhD5x2kP86xGkUw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kfv/VbF9zL+Z4gjc+e+hvyi7k55/ly6vk+hQbcKgPff/MMp3fUsaEfZ46w8GNiKxB
 uxR3h/76ppj2h0zLh6NBfyczkFfFKSWPcq4xdOMG7Gc+KnJY5oAnHK0XAyuAUwFrUd
 WTrH4UxTlhIWOsubzuLwMU2Zn7SIVAhEfY9Zearo=
Date: Wed, 30 Sep 2020 14:11:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] regmap: add support to
 regmap_field_bulk_alloc/free apis
Message-ID: <20200930121100.GA1616135@kroah.com>
References: <20200925164856.10315-1-srinivas.kandagatla@linaro.org>
 <20200925164856.10315-2-srinivas.kandagatla@linaro.org>
 <20200930115915.GB1611809@kroah.com>
 <20200930120849.GG4974@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930120849.GG4974@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, srivasam@codeaurora.org, lgirdwood@gmail.com,
 rafael@kernel.org, linux-kernel@vger.kernel.org, tiwai@suse.com,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, rohitkr@codeaurora.org
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

On Wed, Sep 30, 2020 at 01:08:49PM +0100, Mark Brown wrote:
> On Wed, Sep 30, 2020 at 01:59:15PM +0200, Greg KH wrote:
> > On Fri, Sep 25, 2020 at 05:48:55PM +0100, Srinivas Kandagatla wrote:
> 
> > > +int devm_regmap_field_bulk_alloc(struct device *dev, struct regmap *regmap,
> > > +				 struct regmap_field **field,
> > > +				 struct reg_field *reg_field, int num_fields);
> > > +void devm_regmap_field_bulk_free(struct device *dev,
> > > +				 struct regmap_field *field);
> > > +
> > 
> > You only have a patch that uses these last two functions, so why add all
> > 4?  We don't add infrastructure to the kernel without users.
> 
> We have managed versions of the other regmap allocation functions, it
> makes sense for consistency to have managed versions of these too.  I
> think there's a meaningful difference between a simple and expected
> wrapper like these and infrastructure which hasn't been proved out by
> users.

Ok, do you think these are really needed?

A review would be nice :)

thanks,

greg k-h
