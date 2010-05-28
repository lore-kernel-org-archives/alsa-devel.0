From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Fri, 28 May 2010 12:06:25 +1000
Message-ID: <20100528020621.GA12531@www.longlandclan.yi.org>
References: <20100524074946.GC16346@www.longlandclan.yi.org>
	<1274698156.3064.93.camel@odin>
	<20100525004126.GA10968@www.longlandclan.yi.org>
	<20100525022646.GA18030@www.longlandclan.yi.org>
	<1274806007.4728.3.camel@gnutoo-desktop>
	<20100526132129.GA13644@www.longlandclan.yi.org>
	<20100527004702.GA22091@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9189387641430725517=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from helicon.mas.viperplatform.net.au
	(helicon.mas.viperplatform.net.au [202.147.75.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 954742444C
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 04:06:33 +0200 (CEST)
Received: from eryx.mas.viperplatform.net.au ([172.16.5.11])
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OHoxw-0000wX-GT
	for alsa-devel@alsa-project.org; Fri, 28 May 2010 12:06:28 +1000
Received: from mail by eryx.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OHoxw-0007PJ-7c
	for alsa-devel@alsa-project.org; Fri, 28 May 2010 12:06:28 +1000
Received: from [172.16.100.13] (helo=helicon.mas.viperplatform.net.au)
	by eryx.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OHoxw-0007PF-6K
	for alsa-devel@alsa-project.org; Fri, 28 May 2010 12:06:28 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OHoxu-0000vD-5E
	for alsa-devel@alsa-project.org; Fri, 28 May 2010 12:06:28 +1000
In-Reply-To: <20100527004702.GA22091@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, gnutoo <GNUtoo@no-log.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

--===============9189387641430725517==
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2010 at 01:47:03AM +0100, Mark Brown wrote:
> On Wed, May 26, 2010 at 11:21:36PM +1000, Stuart Longland wrote:
>
> > At the moment, when I go to play audio; I see the CODEC being set up =
...
> > but despite the clocks being present -- I see no audio data, and the =
DMA
> > transfer eventually times out with the message "playback write error
> > (DMA or IRQ trouble?)" after 10 seconds.  Would anyone know where I'd
> > look for that?  Is there something else needed in the configuration o=
f
> > the SSI driver for this to work?
>
> This most likely means your CPU side configuration is broken and clocks
> aren't being routed through.  Try looking at the AUDMUX debugfs files t=
o
> verify your configuration, and also try routing out to another external
> SSI port so you can probe signals.  Make sure the relevant pins on the
> i.MX are configured into the appropriate mode for use by the i.MX too.
>
> Note also that the current driver only supports CODEC as clock master.

I figured this might be the case, now to figure out why the clocks
aren't getting through.

The CODEC chip we're using can work either way; I=C2=B2S master or slave.=
  So
switching it to work the other way is an easy proposition.  My work thus
far has been using the CODEC as master.  The CODEC however, sources its
clock (on MCLK) from the clock pin on SSI3.

I have a userspace application that mmaps the registers for SSI2 and
AUDMUX, and sets this up, so no big deal ... the clock it receives is
about 12.1MHz (12.093MHz according to the frequency counter here).

Ka-Ro's TX27 module don't make any other SSI ports accessible (to my
knowledge).  So in that regard; I can't directly test using the above
method.  However, I have tried something similar.  The TLV320AIC3204
CODEC IC can route clocks from a secondary audio interface.  Using I=C2C
commands, I was able to tell it to pretend its "GPIO" pin was the
secondary audio interface bit clock -- this pin is connected to the SSI4
interrupt line; and is being weakly pulled up by the i.MX27.

The CODEC therefore routed this out on its BCLK pin, connected to
SSI4_CLK.  I told AUDMUX to route this through to SSI3_CLK and watched
that on the CRO.  So to clarify (please forgive the ASCII-art)...

		 Pull-up:                      :
		      | :                      :
i.MX27	SSI4_INT <<<--+-:----+-----------------:-----+-->>> GPIO CODEC
AUDMUX                  :    '--> Probe to 0v  :     |<-- Internal link
	SSI4_CLK <<<--+-:----------------------:-<<<-+----- BCLK
    Internal Link---->| :		       :
	SSI3_CLK >>>--+-:----+-----------------:->>>------- MCLK
			     '--> CRO

Whenever I touched the probe to 0v; the MCLK dropped almost
immediately... I was not able to measure the delay on the scope here.

When I try to play audio; the AUDMUX configuration is as follows:
Port:   imx-ssi.0
Raw:    cb205000
TxFS output from SSI4, TxClk output from SSI4
Port is symmetric
Data received from SSI4
Port:   imx-ssi.1
Raw:    00001000
TxFS input, TxClk input
Port is symmetric
Data received from imx-ssi.0
Port:   SSI4
Raw:    00001000
TxFS input, TxClk input
Port is symmetric
Data received from imx-ssi.0
Port:   SSI1
Raw:    00001000
TxFS input, TxClk input
Port is symmetric
Data received from imx-ssi.0
Port:   SSI2
Raw:    00001000
TxFS input, TxClk input
Port is symmetric
Data received from imx-ssi.0
Port:   SSI3
Raw:    c4103000
TxFS output from imx-ssi.1, TxClk output from imx-ssi.1
Port is symmetric
Data received from imx-ssi.1

I'll have a look at the Eukrea CPUIMX27 and baseboard SoC support in a
moment, since it looks very similar to what we're doing (in that it's a
TI I=C2=B2S CODEC hooked to an i.MX27 on SSI4) ... this might reveal clue=
s
as to what I'm doing wrong.
--
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.

--===============9189387641430725517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============9189387641430725517==--
