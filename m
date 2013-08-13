From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/16 v2] sound/soc/pxa/mioa701_wm9713.c: Avoid using
 ARRAY_AND_SIZE(e) as a function argument
Date: Tue, 13 Aug 2013 06:52:56 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1308130652080.1997@localhost6.localdomain6>
References: <1376340564-7975-1-git-send-email-Julia.Lawall@lip6.fr> <20130812214050.GI6427@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130812214050.GI6427@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Eric Miao <eric.y.miao@gmail.com>, robert.jarzmik@free.fr, kernel-janitors@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 12 Aug 2013, Mark Brown wrote:

> On Mon, Aug 12, 2013 at 10:49:24PM +0200, Julia Lawall wrote:
> > From: Julia Lawall <Julia.Lawall@lip6.fr>
> > 
> > Replace ARRAY_AND_SIZE(e) in function argument position to avoid hiding the
> > arity of the called function.
> 
> What is the difference between this and the patch I applied the other
> day?

Sorry, it should have also removed the local definition of ARRAY_AND_SIZE?  
I thought that was in the commit message.

julia
