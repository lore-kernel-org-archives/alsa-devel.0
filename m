From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: simple-audio-card vs. platform question
Date: Thu, 29 Jan 2015 18:05:19 +0100
Message-ID: <alpine.DEB.2.02.1501291758460.11532@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1501271301400.11532@lnxricardw1.se.axis.com>
 <54C7848F.6070903@metafoo.de>
 <alpine.DEB.2.02.1501271730110.11532@lnxricardw1.se.axis.com>
 <54C7D4D8.9020301@metafoo.de>
 <alpine.DEB.2.02.1501290938240.11532@lnxricardw1.se.axis.com>
 <54CA37B0.2040503@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id B6C722604BD
 for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2015 18:05:22 +0100 (CET)
In-Reply-To: <54CA37B0.2040503@metafoo.de>
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
Cc: =?ISO-8859-15?Q?Ricard_Wanderl=F6f?= <ricardw@axis.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Thu, 29 Jan 2015, Lars-Peter Clausen wrote:

> >>>
> >>> Curious though, wouldn't it be more natural to bind it all together i=
n the
> >>> simple-audio-card DT entry, having a "simple-audio-card,platform"
> >>> specification? Or is the idea that normally the CPU DAI driver is fai=
rly
> >>> tightly coupled to the PCM driver so it makes more sense to make that
> >>> connection in the code?
> ...
> > I'm not necessarily saying it would be better with a platform descripti=
on
> > in the DT, all things considered, just trying to understand why it may =
not
> > be.
> =

> If you can make a compelling case that it should be added and that it =

> describes the hardware that you have accurately I shouldn't be a problem =
to =

> add it.
> =

> But in my opinion and experience the model where you have platform, CPU D=
AI, =

> CODEC DAI is antiquated and does not match the modern hardware very well. =

> We've started to restructure the ASoC framework to better accommodate the =

> requirements of modern systems. And I'm hoping that once this restructuri=
ng =

> is complete there will be no need for snd_soc_platform anymore.

Well, your experience definitely greatly outweighes mine for sure. At =

this stage I'm mostly trying to get my head around why things are the =

way they are.

My experience so far has basically been with a single SoC. It does fit the =

platform - CPU DAI - CODEC DAI paradigm quite well though, as there is one =

PCM =3D platform driver to handle the DMA, an on-chip I2S DAI, and an =

off-chip codec. In what way do 'modern systems' differ?

One thing I could imagine is that if the DMA driver is implemented in the =

kernel DMA framework as a DMA engine, then a single generic platform =

driver will be able to handle multiple 'platforms' which would eventually =

make the concept obsolete. But I don't if that is the issue here.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
