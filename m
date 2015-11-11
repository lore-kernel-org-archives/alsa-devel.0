From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Unregister a card from userspace?
Date: Wed, 11 Nov 2015 16:33:17 +0100
Message-ID: <alpine.DEB.2.02.1511111625180.11990@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1511041032180.1465@lnxricardw1.se.axis.com>
 <56408259.2030604@felipetonello.com>
 <alpine.DEB.2.02.1511100852180.15344@lnxricardw1.se.axis.com>
 <564319CD.3070305@felipetonello.com>
 <alpine.DEB.2.02.1511111348380.11990@lnxricardw1.se.axis.com>
 <564355A9.9020704@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id EDA702604D6
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 16:33:18 +0100 (CET)
In-Reply-To: <564355A9.9020704@felipetonello.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Wed, 11 Nov 2015, Felipe Ferreri Tonello wrote:

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
> > =

> =

> What exactly do you want? If it is driver that register and unregister =

> cards based on the user interaction of probing and removing that module =

> from user-space, then you are not looking for a driver. What you are =

> looking for is just a kernel module. The only way of interacting with it =

> is dealing with module_init and module_exit.

What I was aiming for was that when I load this particular module, it =

ultimately calls snd_soc_register_card in its probe function, so that the =

device in question becomes available for ALSA once the module has been =

loaded. And then if I want to remove the driver I simply unload the module =

which allows it to go away.

The underlying reason for this rigmarole is rather complex, suffice to say =

at this stage that part of the hardware can be used for other mutually =

exclusive tasks.

> On the other hand, if in fact you want a driver, then check
> sound/drivers/dummy.c for an example. You can also read the
> Documentation/driver-model/platform.txt for more info.

Thanks for the pointers Filipe, I'll have a look there.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
