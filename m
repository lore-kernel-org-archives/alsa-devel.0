From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [alsa-devel] [PATCH] ASoC: sgtl5000: Use devm_ functions
Date: Wed, 9 Jul 2014 10:10:01 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1407091009450.2375@hadrien>
References: <20140706070800.GA2927@himangi-Dell> <20140707144832.GL30458@sirena.org.uk> <alpine.DEB.2.10.1407071655171.4757@hadrien> <CAOMZO5AiFCnfTzo4TyB5e5c+xiHQiHUbhRVY7z=AbjOWZDX3NA@mail.gmail.com> <alpine.DEB.2.10.1407071721270.4757@hadrien>
 <20140708080232.GQ30458@sirena.org.uk> <alpine.DEB.2.10.1407081012400.2347@hadrien> <20140708145249.GX30458@sirena.org.uk> <alpine.DEB.2.02.1407090727410.2022@localhost6.localdomain6> <20140709080134.GE30458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140709080134.GE30458@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Himangi Saraogi <himangi774@gmail.com>
List-Id: alsa-devel@alsa-project.org



On Wed, 9 Jul 2014, Mark Brown wrote:

> On Wed, Jul 09, 2014 at 07:30:40AM +0200, Julia Lawall wrote:
> > On Tue, 8 Jul 2014, Mark Brown wrote:
>
> > > All devices do this - it's done as part of the driver model core code so
> > > there is no need for individual buses to do anything.
>
> > How should one realize that this does not apply to the original file
> > under discussion, sound/soc/codecs/sgtl5000.c?  The associated structure
> > is snd_soc_codec_driver.  What code could one look for at the call sites
> > of the probe and remove functions to know that managed memory can be used?
>
> That's not a device model driver; the way you should realise this is
> that there's no device being registered on a bus which is matched by the
> driver core.

OK, thanks for the clarification.

julia
