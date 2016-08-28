From: Joe Perches <joe@perches.com>
Subject: Re: Misuses of ** ? (was Re: [PATCH 1/1] ASoC: Intel: Atom: add a
 missing star in a memcpy call)
Date: Sun, 28 Aug 2016 13:34:13 -0700
Message-ID: <1472416453.26978.115.camel@perches.com>
References: <20160828173945.27721-1-nicolas.iooss_linux@m4x.org>
         <1472406636.26978.95.camel@perches.com>
         <fcac5d87-9f50-b303-f100-4313d7f21907@m4x.org>
         <alpine.DEB.2.10.1608282137050.3419@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.10.1608282137050.3419@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>, Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Cc: alsa-devel@alsa-project.org, Dan Capenter <error27@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2016-08-28 at 21:38 +0200, Julia Lawall wrote:
> On Sun, 28 Aug 2016, Nicolas Iooss wrote:
> > On 28/08/16 19:50, Joe Perches wrote:
> > > On Sun, 2016-08-28 at 19:39 +0200, Nicolas Iooss wrote:
> > >> In sst_prepare_and_post_msg(), when a response is received in "block",
> > >> the following code gets executed:
> > >>
> > >>     *data = kzalloc(block->size, GFP_KERNEL);
> > >>     memcpy(data, (void *) block->data, block->size);
> > >
> > > Yuck, thanks.
> > >
> > > Julia, Dan, could cocci or smatch help find any other
> > > similar misuses here?
[]
> I tried the following semantic patch, that is quite general, and the fixed
> issue was the only report.
> 
> @@
> expression x,y,sz;
> identifier f,g;
> @@
> 
> * *x = f(sz,...);
>   ...
> * g(x,y,sz);

Hi Julia,

This would find exactly the same form, but I think
the question is are there assignments of a **pp
that should have been *pp

Something like:

@@
type P;
P **pp;
@@

* pp = <alloc>\|<copy>\|<access>(..., sizeof(P), ...)
