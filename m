From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH 1/2] ASoC: wm8904: rework FLL handling
Date: Tue, 23 Jul 2019 13:54:15 +0200
Message-ID: <20190723115415.GA14036@qmqm.qmqm.pl>
References: <cover.1563817201.git.mirq-linux@rere.qmqm.pl>
 <3e104cf18cb4e26096f0fe065a2c0e80373f861c.1563817201.git.mirq-linux@rere.qmqm.pl>
 <20190723082716.GM54126@ediswmail.ad.cirrus.com>
 <20190723105248.GA5365@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83C07F80227
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 13:54:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190723105248.GA5365@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, patches@opensource.cirrus.com, Nicolas Ferre <nicolas.ferre@microchip.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 23, 2019 at 11:52:48AM +0100, Mark Brown wrote:
> On Tue, Jul 23, 2019 at 09:27:16AM +0100, Charles Keepax wrote:
> > On Mon, Jul 22, 2019 at 07:57:21PM +0200, Micha=B3 Miros=B3aw wrote:
> > > Extract and rework FLL handling. This makes it possible to reuse
> > > the code for other Wolfson codecs and makes codec adapt SYSCLK to
> > > exactly match frequency required for used sampling rate.
> =

> > Do you have thoughts on which CODECs you would be including in
> > this? These older parts often have small differences between the
> > configuration that might make this challenging so if you have
> > plans here would be good to have a look from this end.
> =

> Right, it's not like it's the same IP being dropped into multiple chips
> in an identical fashion.  There's a lot of high level similarities in
> the register interfaces but also many small per device tweaks, and it's
> not clear what benefit we get from refactoring at this point.

This would be mainly code separation, so it's easier to understand and
has a potential for direct reuse. I can see that clock selection needs
to be changed, but the idea is to have it configurable via device-tree.

I picked at random WM9081. It's FLL implementation looks very similar -
major diffferences being in FLL_OUTDIV selection (direct divider vs 2^N)
and register block offset.

Another random pick - WM8900. The general FLL idea seems the same, but
this one has a bit more complicated register layout, so I wouldn't
consider it at first.

WM8994 - it has two FLL's but otherwise has identical register layout
for them as WM8904. The only difference is in clock source selection.

Best Regards,
Micha=B3=A0Miros=B3aw
