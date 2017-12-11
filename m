From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: nuc900: Fix platform_get_irq()
 error checking some more
Date: Mon, 11 Dec 2017 17:41:34 +0100
Message-ID: <20171211164134.GE32306@piout.net>
References: <20171209115203.pdtdfnmzwz6zpjqs@mwanda>
 <5A2BE644.3070009@gmail.com>
 <20171209172732.GF15660@piout.net>
 <20171210015200.gr4mxzqgzyvamxui@mwanda>
 <5A2C9E9A.7020501@gmail.com>
 <20171211084053.p5ke733i3kzzk5mz@mwanda>
 <a191218d-fe63-db5f-1993-2167a2077f70@gmail.com>
 <20171211102730.agtoczxiu4dcn5ra@mwanda>
 <20171211114950.GB32306@piout.net>
 <20171211120129.ssrw65eghtdpmjej@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171211120129.ssrw65eghtdpmjej@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On 11/12/2017 at 15:01:29 +0300, Dan Carpenter wrote:
> On Mon, Dec 11, 2017 at 12:49:50PM +0100, Alexandre Belloni wrote:
> > Maybe the good thing to do is to actaully leave the nuc900 code alone
> > instead of trying to change something that never failed and that doesn't
> > seem to interest anyone anymore (else the platform would have been
> > converted to DT).
> >
> 
> I don't know.  The bug is less than a month old and this discussion has
> been useful for me as I review any platform_get_irq() changes sent to
> staging.
> 

What I meant is that the original code before this "fix" was more that 7
years old and nobody ever had any issues. And that's because getting
that IRQ on that platform will simply never fail.

Also, I really doubt anybody is going to copy paste from the nuc900-ac97
driver so I'm really wondering whether it is worth fixing this non-issue.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
