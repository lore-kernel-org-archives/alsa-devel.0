From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [RFC PATCH 2/7] ALSA: ac97: add an ac97 bus
Date: Tue, 03 May 2016 21:43:20 +0200
Message-ID: <87twiforl3.fsf@belgarion.home>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
	<1462050939-27940-3-git-send-email-robert.jarzmik@free.fr>
	<20160503162938.GT6292@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160503162938.GT6292@sirena.org.uk> (Mark Brown's message of
	"Tue, 3 May 2016 17:29:38 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@kernel.org> writes:

> On Sat, Apr 30, 2016 at 11:15:34PM +0200, Robert Jarzmik wrote:
>> AC97 is a bus for sound usage. It enables for a AC97 AC-Link to link=
 one
>> controller to 0 to 4 AC97 codecs.
>
>> The goal of this new implementation is to implement a device/driver
>> model for AC97, with an automatic scan of the bus and automatic
>> discovery of AC97 codec devices.
>
> I think this is basically what I was thinking of, yes.  One thing we'=
ll
> need to do is work out how to handle systems that need some explicit
> action to start clocks for the bus clock, though they were never very
> common and it's entirely possible nobody cares any more so perhaps we
> just punt and see if anyone notices for now.
You probably mean the BITCLK clock.

What is a bit pesky about this clock is that it can either be mastered =
by
digital controller and the codec is a slave, or the other way around.

So we had either the BITCLK provided by :
 - the controller
   =3D> this could be passed in ac97_digital_controller_register()
 - the codec
   =3D> this is trouble, I don't really know how to handle this case

If the bus code has this clock, it can indeed prepare and enable it.

>> +int ac97_digital_controller_register(const struct ac97_controller_o=
ps *ops,
>> +				     struct device *dev);
>> +int ac97_digital_controller_unregister(const struct device *dev);
>
> Why "digital"?
I copy-pasted this from Audio Codec '97 Revision 2.3, where in several =
places
they call the controller a "digital controller".

Quoting chapter 1.4:
    The digital link that connects the AC =E2=80=9897 Digital Controlle=
r to the AC =E2=80=9897
    Codec, referred to as AC-link, is a bi- directional, 5-wire, serial=
 time
    domain multiplexed (TDM) format interface. AC-link supports connect=
ions
    between a single Controller and up to 4 CODECs on a circuit board a=
nd/or
    riser card.

Now if you prefer "ac97_controller" or something like that, that's as y=
ou wish,
the name does not matter that much to me ;)

Cheers.

--=20
Robert
