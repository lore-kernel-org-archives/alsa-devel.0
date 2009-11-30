From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH V2] Add i.MX sound support
Date: Mon, 30 Nov 2009 14:13:47 +0100
Message-ID: <eedb5540911300513j3730078v1393b9b42dca497b@mail.gmail.com>
References: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
	<eedb5540911260753u369d6cffp97c05089cdd30868@mail.gmail.com>
	<20091127075834.GG27548@pengutronix.de>
	<eedb5540911270101o4bf06b2ct6ff22e29b7c1fe15@mail.gmail.com>
	<20091127095416.GK27548@pengutronix.de>
	<eedb5540911300243t20ecf407o317b414720cf962e@mail.gmail.com>
	<20091130124305.GQ27548@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.144])
	by alsa0.perex.cz (Postfix) with ESMTP id A3E5824534
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 14:13:48 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 3so879107eyh.16
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 05:13:48 -0800 (PST)
In-Reply-To: <20091130124305.GQ27548@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2009/11/30 Sascha Hauer <s.hauer@pengutronix.de>

> On Mon, Nov 30, 2009 at 11:43:23AM +0100, javier Martin wrote:
> > Hi Sascha,
> > have you tested capture direction on an i.MX27 based board?
> >
> > I have been testing your patches in the place you suggested and playback
> > seems to work fine but I have several problems with capture stream. I
> found
> > a BUG in the audmux_v1 code
> > and I have fixed it but I am still having problems with capture. The file
> > keeps empty and nothing is recorded.
>
> Capture works fine on my boards.
>
>
>
> > Please could you try the following on an i.MX27 based board?
> >
> > arecord -t raw -c 1 -f S16_LE test.wav
>
> Does it work with two channels? Do you use DMA or FIQ? Could you try the
> other variant?
>

 Unfortunately, I can't test it using two channels because our board has a
wm8974 mono codec. Please could you point me how can I change between FIQ
and DMA? I thought FIQ was only for AC97,

It helped me a lot during development to use a tool like memedit
> (http://www.pengutronix.de/software/memedit/index_en.html) to show a
> register dump of the SSI/Audmux units of a working setup and a non
> working setup. Usually the differences showed quite fast why one was
> working and the other was not.
>

 Indeed, this will be my next step.

 Thank you for the tip.


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
