From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] ASOC: Atmel: ClassD: Simplify use of
 devm_ioremap_resource
Date: Mon, 4 Jul 2016 16:52:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1607041651380.3790@hadrien>
References: <20160704130352.GA16886@amitoj-Inspiron-3542> <20160704141533.GG6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160704141533.GG6247@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Amitoj Kaur Chawla <amitoj1606@gmail.com>, nicolas.ferre@atmel.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On Mon, 4 Jul 2016, Mark Brown wrote:

> On Mon, Jul 04, 2016 at 06:33:52PM +0530, Amitoj Kaur Chawla wrote:
> > Remove unneeded error handling on the result of a call to
> > platform_get_resource when the value is passed to
> > devm_ioremap_resource.
>
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.

The point is that ASOC should be ASoC?  Ther aren't many patches on this
file, and two of the three have the same subject line as the above, but
with ASoC rather than ASOC.

thanks,
julia
