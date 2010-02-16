From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 12:47:43 +1300
Message-ID: <4B7B2E9F.3080809@audioscience.com>
References: <20100215192451.GA17938@tango.0pointer.de>
	<4B7A5268.5050704@ladisch.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id C10A02451F
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 00:48:36 +0100 (CET)
Received: from [192.168.1.6]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KXY008GAKSUV330@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 17 Feb 2010 12:48:32 +1300 (NZDT)
In-reply-to: <20100216224212.GA1486@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lennart Poettering wrote:
> On Tue, 16.02.10 22:39, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:
> 
>> On Tue, Feb 16, 2010 at 10:07:03PM +0100, Lennart Poettering wrote:
>>> On Tue, 16.02.10 17:29, Jaroslav Kysela (perex@perex.cz) wrote:
>>>> Basically, if I remember correctly the discussion, 0dB on all elements 
>>>> should main unchanged volume, <0dB attenuation and >0dB gain.
>>> But you need some kind of "anchor" for that. What you write above
>>> applies only for elements that have some kind of analog input and
>>> output. But the most interesting components are probably the DAC and
>>> ADC (i.e. the "innermost" elements), and it's not clear what level they
>>> output, so the "anchor" for the relative dB values is missing...
>> Typically the DACs and ADCs will have a full scale signal at line
>> reference level - it should generally be a good approximation with
>> nothing else to go on.
> 
> "line reference level"? What is that?
> 
> Lennart
> 

There are two separate issues here.
1) Incorrect dB<->linear mapping
ALSA Volume/Gain controls returning incorrect information about mapping
from linear values to dB.  E.g. adding "6dB" to the Volume controls
while subtracting 6dB in software does not result in 0dB overall gain.

For volume controls the convention is  0dB == multiply by 1.0 == no
change. Any sane digital volume control should obey this.
For analog volumes, the 0dB position is entirely arbtrary, as I discuss
below.

2) Absolute calibration of output levels.
(This is *not* required to solve Lennart's problem)
This would be required if you wanted two different (brands of) soundcard
to output the same voltage for given source pcm.

>From the perspective of a Pro audio card maker, we have another kind of
control at the analog terminals of the card. This is the Level control,
and it specifies the absolute voltage at the output for full scale
digital signal (and intermediate Volumes set to 0dB)

It has units of dBu http://en.wikipedia.org/wiki/Decibel#Voltage.
(It might as well be dBV or any other reference dB measurement).

For our cards this is adjustable, but lets say for consumer cards it is
fixed.  This information is not currently available via the ALSA API.

A hypothetical example.
[DAC>---[Variable gain>---[amplifier>---[output jack]

Lets say
the DAC produces 2Vpp (6dBVpp) for fullscale digital input (0dBFS)
and the amplifier has 6dB gain.
and the variable gain is from -40dB to 0dB
and the units of the reference level are dBVpp

Combining these we represent the DAC + gain + amplifier as a single
Level control with units of dBVpp and range -28dBVpp to +12dBVpp

or equally valid, could represent it as
a Volume with range -40dB to 0dB followed by a
a fixed level of +12dBVpp

or equally valid, could represent it as
a Volume with range 0dB to +40dB followed by a
a fixed level of -28dBVpp

i.e. the 0dB position is arbitrary, related to what is chosen as the
output reference level.

The fixed level information, would be attached to some representation of
the output connector.

Clear as mud?

regards

Eliot Blennerhassett
http://www.audioscience.com
