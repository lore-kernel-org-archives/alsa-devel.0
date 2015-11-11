From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Unregister a card from userspace?
Date: Wed, 11 Nov 2015 16:24:20 +0100
Message-ID: <alpine.DEB.2.02.1511111621350.11990@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1511041032180.1465@lnxricardw1.se.axis.com>
 <56408259.2030604@felipetonello.com>
 <alpine.DEB.2.02.1511100852180.15344@lnxricardw1.se.axis.com>
 <564319CD.3070305@felipetonello.com>
 <alpine.DEB.2.02.1511111348380.11990@lnxricardw1.se.axis.com>
 <56433E0A.20804@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 2334C26049B
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 16:24:22 +0100 (CET)
In-Reply-To: <56433E0A.20804@metafoo.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Felipe Ferreri Tonello <eu@felipetonello.com>
List-Id: alsa-devel@alsa-project.org


On Wed, 11 Nov 2015, Lars-Peter Clausen wrote:

> >> How is your architecture? If you use one card for each probe of module
> >> then each bind should create one device, right?
> > =

> > In this case, it is a device which is located on the SoC. There is only =

> > one instance of it. When the module is loaded, it loads a codec driver =

> > with its associated DAI driver, a PCM driver, snd-soc-dummy-dai, and th=
en =

> > a machine driver to tie it all together, finally registering the card w=
ith =

> > ALSA.
> > =

> > Looking in /sys/bus/platform/devices, there seems to be one device crea=
ted =

> > for the codec itself, and one for the machine driver. I don't know if =

> > that's right or wrong, the ALSA driver hierarchy works in the sense tha=
t I =

> > can capture audio from it anyway.
> =

> Which one is the module you can't unload? The module that contains the
> machine driver should only have its reference count increment when a
> playback or capture stream is active so you can't remove it when it is
> actively in use.

As it is currently I've got all drivers in the same module. Since there is =

only one possible choice for the PCM and DAI drivers when using this =

particular codec, it seemed pointless to several modules for the =

constituent parts.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
