From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 3/5] ASoC: max9860: switch to SPDX license tag
Date: Sun, 15 Apr 2018 00:32:29 -0700
Message-ID: <20180415073229.GA19823@infradead.org>
References: <20180412161601.GI9929@sirena.org.uk>
 <20180412211437.21599-1-peda@axentia.se>
 <20180412211437.21599-4-peda@axentia.se>
 <20180413111927.GC6854@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180413111927.GC6854@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 13, 2018 at 12:19:27PM +0100, Mark Brown wrote:
> On Thu, Apr 12, 2018 at 11:14:35PM +0200, Peter Rosin wrote:
> 
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * Driver for the MAX9860 Mono Audio Voice Codec
> >   *
> 
> Please don't mix C and C++ comments like this - it looks unintentional
> and messy.  Just convert the entire comment block to C++ so it's
> consistent with itself.

NAK - that is exactky the wrong way to go.  Normal Linux comments are
classi C-style comments and should remain so.  SPDX tags use c++
comments exactly to be different and stick out.



---end quoted text---
