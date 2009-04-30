From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: Disable DACs in analog
	loopback
Date: Thu, 30 Apr 2009 13:28:48 +0300
Message-ID: <200904301328.48853.peter.ujfalusi@nokia.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F63E05BA@dlee07.ent.ti.com>
	<200904301146.49080.peter.ujfalusi@nokia.com>
	<2C7D3DF36ADFFC479B44490D912B616705F63E05BE@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 44C271038AB
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Apr 2009 12:29:46 +0200 (CEST)
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705F63E05BE@dlee07.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 30 April 2009 12:53:20 ext Lopez Cruz, Misael wrote:
> At least, the digital filters (configured in OPTION reg) are
> enabled when the corresponding DAC is enabled, can we attach
> them to a DAC somehow? Could it be a valid approach?

The digital filters corresponding to the Stereo path (ATXL1_EN, ATXR1_EN, =

ARXL2_EN, ARXR2_EN) can be enabled dynamically, when the:
- Playback is running (enable only the ARXL2_EN, ARXR2_EN bits)
- Capture is running (enable only the ATXL1_EN, ATXR1_EN bits)
- Digital loopback is enabled (in pairs the ATXL1_EN/ARXL2_EN or  =

ATXR1_EN/ARXR2_EN bits - the first pair is for left digital loopback, the =

second is for the right digital loopback).

>
> > But I'm afraid, this patch does break the Digital loopback,
> > which needs the DACs to be powered, in case when the capture
> > path is set in analog mode the ADC(s) also need to be powered.
>
> I think that digital loopback should mix TX with RX only when
> both digital paths are enabled, i.e. in a full-duplex scenario.

Well, yes... short of. You can still enable the digital loopback without =

active stream. The TWL codec will be in the same state as it if you are usi=
ng =

full duplex mode. The only difference is that the CPU dai is not running.
The analog loopback also mixing the RX and TX data, but in the analog domai=
n.
If you have only the loopback enabled (analog or digital) the RX path is =

silent in both cases...

While we are here with the loopbacks: When only the analog loopback is enab=
led =

the PLL can be disabled for the codec (APLL_CTL:APLL_EN =3D 0). I have some =

preliminary implementation for this, but it needs some more tuning... =


> I don't expect it to automatically enable DACs for me, although
> maybe I'm wrong and my argument breaks what digital loopback
> means :( Please clarify.

You have to specifically flip the user control to enable the digital loopba=
ck, =

it is not done automatically.

>
> > Both analog and digital loopback connects to 'Analog XY
> > Playback Mixer', which turns on/off the physical DAC on
> > the given route.
>
> That was a part of the audio map that doesn't make much sense
> to me, joining analog and digital loopback.

It was like that, because the TRM has no information on these loopback at a=
ll, =

so I have chosen this safe path (I have got the digital loopback implemente=
d =

first) and marked for myself to revisit it later. =


>
> > I have been thinking of - as a part of a big
> > clean up - to separate these, since as you have pointed out,
> > the DACs are not needed for the analog loopback.

-- =

P=E9ter
