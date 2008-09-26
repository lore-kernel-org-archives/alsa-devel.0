From: Frank Mandarino <fmandarino@endrelia.com>
Subject: Re: ALSA:ATMEL: common arch for audio via ssc(patch
 3/3: adding directories)
Date: Fri, 26 Sep 2008 10:18:33 -0400
Message-ID: <48DCEF39.40003@endrelia.com>
References: <48DCAA3A.8030209@atmel.com> <20080926125035.GB15493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ironport2-out.teksavvy.com (ironport2-out.pppoe.ca
	[206.248.154.182])
	by alsa0.perex.cz (Postfix) with ESMTP id B701224345
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 16:18:37 +0200 (CEST)
In-Reply-To: <20080926125035.GB15493@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, Mark Brown <broonie@sirena.org.uk>, Geoffrey Wossum <geoffrey@pager.net>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, Sep 26, 2008 at 11:24:10AM +0200, Sedji Gaouaou wrote:
>> This last patch contains the board specific files.
>> I have not changed playpaq_wm8510.c, and I did few changes on 
>> eti_b1_wm8731.c.
> 
> It'd be better to submit this as two separate patches, one making the
> modifications to eti_b1_wm8731.c and another doing the simple code move
> (in either order).  This would make it easier to review the changes -
> due to the file move they're not really visible in the current patch.
> 
> It'd also be good to see acks from Frank and Geoffrey since I can't test
> any of this.
> 
> Thanks for doing this work - it looks good, unifying the support for the
> AT91 and AVR32 platforms is a substantial win and it's good to see Atmel
> contributing this support.

Sedji,

Thanks very much for your effort in creating the common Atmel SCC audio
driver.

I would very much like to test your new ASoC platform driver, but
unfortunately this will have to wait until we can upgrade the kernel in
our product.

That being said, I am wondering if it is worth keeping eti_b1_wm8731.c
in the kernel.

I originally included eti_b1_wm8731.c in the kernel as an example of a
machine driver for others who wanted to use the AT91 ASoC driver.  The
ETI_B1 board is specific to our product and we have no plans to ever
sell it.

Now that there are other Atmel ASoC machine drivers in the kernel, and
given the fact that our company does not have the resources to actively
maintain it, I think the eti_b1_wm8731.c driver should be removed.

This reduces the effort in maintaining ASoC, as eti_b1_wm8731.c would no
longer have to be kept up-to-date with ASoC changes.  It also eases the
pressure on me to test ASoC updates against eti_b1_wm8731.c as they are
made.

So unless you or Mark feels the eti_b1_wm8731.c driver should remain in
the kernel source, I'll submit a patch to remove it after your patches
are in place.

Regards,
../fam
-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada
