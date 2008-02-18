From: "Alexandre BOUIN" <a.bouin@kerlink.fr>
Subject: Re: Random inverted audio channels
Date: Mon, 18 Feb 2008 11:00:43 +0100
Message-ID: <43424.2713534788$1203328918@news.gmane.org>
References: <20080218095442.GB21314@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from scanner-relay-corvus2.pulsation.fr
	(scanner-relay-corvus2.pulsation.fr [80.74.64.70])
	by alsa0.perex.cz (Postfix) with SMTP id 7EE0F1038C2
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 11:00:59 +0100 (CET)
In-Reply-To: <20080218095442.GB21314@rakim.wolfsonmicro.main>
Content-Language: fr
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, 'Frank Mandarino' <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

> > We are porting a WM8900 driver from a 8731 one. It fit quite well our
> > requirements and should not be the same as your dev branch.
> > Sincerely, It didn't know you're working on it.
> 
> No problem at all - I was just asking from curiosity.
> 
> > > The most likely issue here is a DMA underrun but from what you say
> you
> > > may already have ruled that out?  It would be helpful if you could
> run
> > > through the debugging you've already done here.
> 
> > I had traced the addresses sent into PDC (soc/at91-pcm.c), and are
> always
> > the same.
> > What other traces are you looking for ?
> 
> Have you checked to make sure that the PDC is not reporting any errors?

at91_pcm_dma_irq (soc/at91/at91-pcm.c) doesn't reports that there is
underrun or overruns.

I've seen the same swap behavior with codec configured as slave.
