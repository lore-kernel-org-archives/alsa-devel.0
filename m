From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: simple-audio-card vs. platform question
Date: Tue, 27 Jan 2015 17:31:58 +0100
Message-ID: <alpine.DEB.2.02.1501271730110.11532@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1501271301400.11532@lnxricardw1.se.axis.com>
 <54C7848F.6070903@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E3A12608BC
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 17:32:00 +0100 (CET)
In-Reply-To: <54C7848F.6070903@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Tue, 27 Jan 2015, Lars-Peter Clausen wrote:

> On 01/27/2015 01:01 PM, Ricard Wanderlof wrote:
> >
> > I'm trying to set up a simple device tree framework so I can do some
> > development on an I2S driver. I'm trying to use simple-audio-card, but I
> > keep running into the problem that once soc_bind_dai_link() gets called,
> > dai_link->platform is set to NULL (because it is not initialized by
> > simple-card.c when there is a DT node), while dai_link->platform_of_node
> > has been set to dai_link->cpu_of_node in asoc_simple_card_parse_of().
> >
> [...]
> >
> > I can't figure out either how to set up a platform (=3DDMA) driver in t=
his
> > environment. Perhaps the case of having a CPU DAI, DMA driver and codec
> > DAI is not supported by simple-audio-card?
> [...]
> =

> Usually in such a setup the CPU DAI driver also register the platform =

> component. Which then as the same of_node as the CPU DAI and so the match=
ing =

> works. There are plenty of examples e.g. check the drivers using =

> devm_snd_dmaengine_pcm_register().

Thanks for the hint, that helps me back on track!

Curious though, wouldn't it be more natural to bind it all together in the =

simple-audio-card DT entry, having a "simple-audio-card,platform" =

specification? Or is the idea that normally the CPU DAI driver is fairly =

tightly coupled to the PCM driver so it makes more sense to make that =

connection in the code?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
