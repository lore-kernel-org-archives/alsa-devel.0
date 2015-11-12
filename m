From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Unregister a card from userspace?
Date: Thu, 12 Nov 2015 15:02:29 +0100
Message-ID: <alpine.DEB.2.02.1511121409050.11990@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1511041032180.1465@lnxricardw1.se.axis.com>
 <56408259.2030604@felipetonello.com>
 <alpine.DEB.2.02.1511100852180.15344@lnxricardw1.se.axis.com>
 <564319CD.3070305@felipetonello.com>
 <alpine.DEB.2.02.1511111348380.11990@lnxricardw1.se.axis.com>
 <564355A9.9020704@felipetonello.com>
 <alpine.DEB.2.02.1511111625180.11990@lnxricardw1.se.axis.com>
 <56446A9E.6040004@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id CC42F265961
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2015 15:02:31 +0100 (CET)
In-Reply-To: <56446A9E.6040004@felipetonello.com>
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
Cc: =?ISO-8859-15?Q?Ricard_Wanderl=F6f?= <ricardw@axis.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Thu, 12 Nov 2015, Felipe Ferreri Tonello wrote:

> > What I was aiming for was that when I load this particular module, it =

> > ultimately calls snd_soc_register_card in its probe function, so that t=
he =

> > device in question becomes available for ALSA once the module has been =

> > loaded. And then if I want to remove the driver I simply unload the mod=
ule =

> > which allows it to go away.
> =

> You said that the framework that handles the module had the counter to 2
> so your unregister card function was never been called, right? I don't
> understand that part, since it doesn't make sense to load your module
> into the kernel more then once.

No, I don't understand why the usage count goes to 2 either.

What the driver does is this:

At module_init time, it registers:
a) a platform driver for the actual hardware (in essence, codec)
b) a platform device representing the hardware itself, and
c) a platform driver which is the ALSA machine driver for the device in que=
stion.

The registering of a) and b) cause the device driver for the codec to be =

initialized by it's probe function getting called. Apart from various =

hardware initializations, it registers the corresponding PCM driver via
snd_soc_register_platform(), and then registers the codec using
snd_soc_register_codec() (registering both the codec itself and its DAI, =

although the latter actually doesn't contain any implementation as the =

communication is handled directly via DMA rather than over some link =

like I2S).

In the case of c), there is a device tree entry which corresponds to the =

device. This in turn causes the the machine driver probe function to be =

called, which does snd_soc_register_card(), binding together the codec =

driver, the PCM driver with its DAI, and a dummy CPU DAI.

The final outcome of this is that ALSA outputs a "<codec dai> <-> =

snd-soc-dummy-dai ampping ok" message in the kernel log.

The device now works as intended. I can arecord from it and get what I
expect in the resulting output file.

Doing an lsmod at this point shows a usage count ('Used by') of 2. I don't =

know if that is just due to snd_soc_register_card, or there is some =

internal usage count due to the fact that there are a couple of drivers =

registered at the same time. Certainly there are two hardware devices: one =

representing the ALSA machine driver, specified in the device tree, and =

one representing the actual hardware, which is registered at the machine =

driver probe time.

Unbinding the driver, which is done by doing =


cd /sys/bus/platform/drivers/<machine-driver-name>

followed by

echo -n <device-name> > unbind

causes the machine driver 'remove' function to be called, which in turn =

does snd_soc_unregister_card.

A lot of the complexity is done to fit into the ALSA SoC driver model, =

where we have

ALSA <-> PCM (DMA) driver <-> CPU DAI <-> CODEC DAI <-> CODEC

even though in this case there are no actual DAI's and the PCM driver =

simply reads the data directly from the CODEC in memory. In the past I've =

tried simplifying the hierarchy for a similar system, but it seems all the =

components have to be there in some form. The only simplification is that =

the CPU DAI can be snd-soc-dummy-dai, and that the only implementation =

needed for CODEC DAI is the specification of things like the limitation of =

the number channels, rates, and formats.

> Try to write just a simple module that register/unregister a card on
> module_init/module_exit, respectively. That should work just fine.

Since the driver uses information from the device tree, it seems that I =

would need to follow the paradigm of registering a driver, which the Linux =

device framework then associates with the corresponding device specified =

in the device tree, in turn calling the probe function. At the moment this =

driver is the ALSA machine driver.

An alternative would be to let the device tree entry correspond to the =

codec device, avoiding the need to explicitly create a codec device in the =

initialization code. I don't know if that would buy much in the end, but =

it would allow me to do snd_soc_register card() at module init rather than =

at probe time.

The problem as I see it is that with a usage count !=3D 0, rmmod will not =

even attempt to unload the driver, hence the module exit function will =

never be called. =


/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
