From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Zoom R16/24 playback slient
Date: Tue, 6 Oct 2015 10:16:05 +0200
Message-ID: <alpine.DEB.2.02.1510060933160.19610@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1509292156390.6263@lnxricardw1.se.axis.com>
 <560B8481.1080304@laiskiainen.org>
 <alpine.DEB.2.02.1510060834060.19610@lnxricardw1.se.axis.com>
 <5613756A.9080209@laiskiainen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id B6ADC264F4B
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 10:16:07 +0200 (CEST)
In-Reply-To: <5613756A.9080209@laiskiainen.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Panu Matilainen <pmatilai@laiskiainen.org>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Tue, 6 Oct 2015, Panu Matilainen wrote:

> >>>>>> At Sat, 29 Nov 2014 21:35:04 +0200,
> >>>>>> Panu Matilainen wrote:
> >>>>>>>
> >>>>> ** UNRECOGNIZED:  0b 24 01 00 01 35 00 03 01 02 03
> >>>>>       -> Header?
> >>>>> ** UNRECOGNIZED:  0c 24 02 05 01 01 00 02 03 00 00 00
> >>>>>       -> USB streaming input terminal?
> >>>>> ** UNRECOGNIZED:  09 24 03 08 01 03 00 05 00
> >>>>>       -> Speaker output terminal?
> >>>>> ** UNRECOGNIZED:  0c 24 02 09 01 02 00 08 00 00 00 00
> >>>>>       -> Microphone input terminal?
> >>>>> ** UNRECOGNIZED:  09 24 03 0c 01 01 00 09 00
> >>>>>       -> USB streaming output terminal?
> >>>>>
> =

> lsusb knows about USB audio alright, the problem is all these stupid =

> vendors tagging their devices and their interfaces as vendor specific, =

> even if when actually are class compliant. Which is why the quirks-table =

> is needed: QUIRK_AUDIO_STANDARD_INTERFACE just tells the driver to parse =

> the descriptor as a standard audio interface despite it claiming to be =

> vendor specific. But lsusb doesn't have access to the quirks table.

That makes sense, however, I seem to recall (will double check tonight) =

that lsusb still output UNRECOGNIZED for the corresponding descriptors =

even when the UA-5 was set to its class complient mode.

I'd have to do more research, but it would seem that the above decriptors =

match something other than the USB audio version 1 or 2 specs, whatever =

that might be.

Part of the decoding I found was:
(partly with reference to
https://www.silabs.com/Support%20Documents/TechnicalDocs/AN295.pdf)


** UNRECOGNIZED:  0b 24 01 00 01 35 00 03 01 02 03
                        -- ----  ----- -- --------
                        |  |       |    |     +---- device nos (cap,pb,midi)
                        |  |       |    +---------- no of devices
		        |  |       +--------------- total descriptors length
                        |  +----------------------- bcdADC (0x0001) ?
                        +-------------------------- subtype HEADER

** UNRECOGNIZED:  0c 24 02 05 01 01 00 02 03 00 00 00
                        -- -- -----    -- -----
                        |  |   |       |     +------ channel placement (L,R)
                        |  |   |       +------------ no of channels
                        |  |   +-------------------- terminal type? (output)
                        |  +------------------------ terminal ID (5)
                        +--------------------------- streaming terminal des=
cr.
                                   =

** UNRECOGNIZED:  09 24 03 08 01 03 00 05 00

** UNRECOGNIZED:  0c 24 02 09 01 02 00 08 00 00 00 00
                        -- -- -----    -- -----
                        |  |   |       |     +------ channel placement (non=
e)
                        |  |   |       +------------ no of channels
                        |  |   +-------------------- terminal type? (input)
                        |  +------------------------ terminal ID (9)
                        +--------------------------- streaming terminal des=
cr.

** UNRECOGNIZED:  09 24 03 0c 01 01 00 09 00

and further down in the dump (after the interface descriptor for the output
interface)

** UNRECOGNIZED:  07 24 01 05 01 01 00
                        -- -- -- -----
                        |  |  |    +-------- format tag (0x0100 =3D PCM)
                        |  |  +------------- bDelay
                        |  +---------------- terminal link?
                        +------------------- subtype AS_GENERAL
                           =

** UNRECOGNIZED:  14 24 02 01 02 04 18 04 44 ac 00 80 bb 00 88 58 01 00 77 =
01
                           -- -- -- -- -- -------- -------- -------- ------=
--
                           |  |  |  |  |  44.1 kHz  48 kHz  88.2 kHz  96 kHz
                           |  |  |  |  |
                           |  |  |  |  +--- no of sample rate specifications
                           |  |  |  +------ bit resolution (24 bits)
                           |  |  +--------- subframe size (4 bytes)
                           |  +------------ no of channels (2)
                           +--------------- format type (TYPE_I)

and for the input interface:

** UNRECOGNIZED:  07 24 01 0c 01 01 00
                        -- -- -- -----
                        |  |  |    +-------- format tag (0x0100 =3D PCM)
                        |  |  +------------- bDelay
                        |  +---------------- terminal link?
                        +------------------- subtype AS_GENERAL

** UNRECOGNIZED:  14 24 02 01 08 04 18 04 44 ac 00 80 bb 00 88 58 01 00 77 =
01
                           -- -- -- -- -- -------- -------- -------- ------=
--
                           |  |  |  |  |  44.1 kHz  48 kHz  88.2 kHz  96 kHz
                           |  |  |  |  |
                           |  |  |  |  +--- no of sample rate specifications
                           |  |  |  +------ bit resolution (24 bits)
                           |  |  +--------- subframe size (4 bytes)
                           |  +------------ no of channels (8)
                           +--------------- format type (TYPE_I)

What doesn't make sense to me here is that certain subtypes seem to be =

reused for different purposes even with the same descriptor type, for =

instance descriptor type 24 has subtype 02 being used to specify terminal =

type and also the data format. Perhaps the length is also a part of the =

type specifier?

While this could all be vendor specific based on a standard but only =

loosely following it, when attempting the same interpretation on the =

corresponding lsusb -v output from the Edirol UA-5, they correspond =

perfectly, given the differences in the devices (for instance, the UA-5 =

only runs at a single sample rate governed by a front panel switch, and in =

its class-complient mode uses 2 bytes per sample with 16 bit resolution, =

and in its advanced mode uses 3 bytes per sample with 24 bit resolution) =

so apparently they are based on the same standard, whatever that may be.

Perhaps someone can point in the right direction to some standards =

document, for now, my main interest is getting the playback streaming =

going, and since QUIRK_AUDIO_STANDARD_INTERFACE seems to suffice in order =

to grab the format information, it is apparent that the ALSA USB layer =

understands the information at least sufficiently for its purpose, so I =

don't really intend to dive deeper into the descriptor interpretation for =

now. Most importantly, it confirms that the correct audio format is 24 =

bits in a 32 bit word.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
