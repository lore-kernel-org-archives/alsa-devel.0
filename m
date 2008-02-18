From: "Alexandre BOUIN" <a.bouin@kerlink.fr>
Subject: Re: Random inverted audio channels
Date: Mon, 18 Feb 2008 09:38:12 +0100
Message-ID: <1243.1388292045$1203323951@news.gmane.org>
References: <20080215171627.GA13164@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from scanner-relay-corvus2.pulsation.fr
	(scanner-relay-corvus2.pulsation.fr [80.74.64.70])
	by alsa0.perex.cz (Postfix) with SMTP id 5AE1D244B9
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 09:38:23 +0100 (CET)
In-Reply-To: <20080215171627.GA13164@rakim.wolfsonmicro.main>
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

> > This embedded project includes a AT91SAM9260 CPU and a WM8900 codec.
> 
> JOOI, is this the WM8900 driver in our dev branch or another one?  It
> shouldn't make any difference either way what driver is used for the
> codec, though, so long as it is generating the relevant clock signals.

We are porting a WM8900 driver from a 8731 one. It fit quite well our
requirements and should not be the same as your dev branch.
Sincerely, It didn't know you're working on it.

> > We have an issue : when we play a right channel stereo track, sound
> is
> > played on right channel, but sometimes on left.
> > This issue could happen right after starting kernel, or later after
> 10-20
> > sounds played.
> > With Frank Mandarino, we've checked any issue from SSC(audio bus) or
> PDC
> > (dma) controlers, but no much success.
> 
> > Any idea to help us debugging this issue would be welcome !
> 
> The most likely issue here is a DMA underrun but from what you say you
> may already have ruled that out?  It would be helpful if you could run
> through the debugging you've already done here.

I had traced the addresses sent into PDC (soc/at91-pcm.c), and are always
the same.
What other traces are you looking for ?

> One thing to try if your design allows it would be to try making the
> CPU the master.  That should reduce the number of variables, at least.

You're right I should try this way, so it would confirm if I have or not an
issue with my LRC clock.
