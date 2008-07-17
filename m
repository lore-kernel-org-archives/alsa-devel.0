From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: WRITING AN SOC DRIVER WITHOUT DMA
Date: Thu, 17 Jul 2008 08:05:49 -0400
Message-ID: <9e4733910807170505k5aaf1c6fp10c6c268cb8e15c7@mail.gmail.com>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<1216199130.749.4.camel@dinesh.dua>
	<8d6898730807160307g4455597ck921d55da8f51455d@mail.gmail.com>
	<1216203206.9723.0.camel@dinesh.dua>
	<1216274611.18207.6.camel@dinesh.dua>
	<20080717105614.GC15333@sirena.org.uk>
	<8d6898730807170426wac4719cv7cd925cfcd91aa68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 39C6D243BB
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 14:05:51 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so4827117rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2008 05:05:49 -0700 (PDT)
In-Reply-To: <8d6898730807170426wac4719cv7cd925cfcd91aa68@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, dinesh <dinesh.dua@coraltele.com>, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 7/17/08, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> Hi Dinesh,
>
> If that is your requirement then go and see the actual code
> sound/arm/aaci.c. They are not using DMA. It is programmed IO.


Search around the list archives, the first version of the
Efika/mpc5200 ac97 driver was programmed IO. The next version updated
it to DMA.


>
>
> Thanks
> Nobin Mathew
>
>
> On 7/17/08, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Thu, Jul 17, 2008 at 11:33:31AM +0530, dinesh wrote:
> >
> > > What i want is that i have a buffer in driver code which is also handled
> > > by some other application i want that this buffer data is to be used for
> > > capture and playback  stream fills data to another buffer which i can
> > > passover to my other application.
> >
> > Depending on what exactly you're doing here you may find that this is
> > best implemented in user space with an ALSA plugin rather than doing it
> > as part of a driver.  If you do want to do this in kernel space then the
> > parts of an ASoC driver which transfer audio data are just the same as
> > those for any other ALSA driver so things like sound/arm/aaci.c may
> > provide useful examples.
> >
>
>
> _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Jon Smirl
jonsmirl@gmail.com
