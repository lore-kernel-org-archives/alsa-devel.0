From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: ASoC: AC97 codec PM
Date: Thu, 3 Jul 2008 11:53:44 +0200
Message-ID: <20080703095344.GA24177@roarinelk.homelinux.net>
References: <20080703073309.GA24116@roarinelk.homelinux.net>
	<1215077359.4882.115.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil48.netpark.at
	[217.175.205.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 02B5A2483E
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 11:53:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1215077359.4882.115.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 03, 2008 at 10:29:19AM +0100, Liam Girdwood wrote:
> On Thu, 2008-07-03 at 09:33 +0200, Manuel Lauss wrote:
> > Hi Liam,
> > 
> > This simple patch adds suspend/resume support to the ASoC AC97 codec.
> > Tested on Au1200, works fine for me(TM).
> > 
> > Thanks!
> > 	Manuel Lauss
> > 
> > ---
> > From: Manuel Lauss <mano@roarinelk.homelinux.net>
> > 
> > Simple suspend/resume for AC97 ASoC codec.
> > 
> > Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> 
> Thanks.
> 
> Acked-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
> 
> 
> Btw, any plans to fix or remove some of the 'Fixmes' in your other ASoC
> code. We could upstream the Au1x000 stuff after a little cleanup and
> resolution of the fixmes.

I've updated the code considerably since the last year.  It's still ASoC v1,
and lots of the FIXMEs in the ac97 part won't disappear until it's moved to
ASoC v2 (I hope, didn't investigate).

If you're interested I can send you a patch (against current linus' HEAD)
with the newest, most awesome au1xxx psc asoc code ;-)

Thanks!
	Manuel Lauss
