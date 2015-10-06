From: Panu Matilainen <pmatilai@laiskiainen.org>
Subject: Re: Zoom R16/24 playback slient
Date: Tue, 6 Oct 2015 10:16:58 +0300
Message-ID: <5613756A.9080209@laiskiainen.org>
References: <alpine.DEB.2.02.1509292156390.6263@lnxricardw1.se.axis.com>
 <560B8481.1080304@laiskiainen.org>
 <alpine.DEB.2.02.1510060834060.19610@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a68.g.dreamhost.com (sub5.mail.dreamhost.com
 [208.113.200.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 0242926067B
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 09:17:04 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1510060834060.19610@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 10/06/2015 09:47 AM, Ricard Wanderlof wrote:
>
> On Wed, 30 Sep 2015, Panu Matilainen wrote:
>
>>>>>> At Sat, 29 Nov 2014 21:35:04 +0200,
>>>>>> Panu Matilainen wrote:
>>>>>>>
>>>>> The descriptors for interface 0 are garbage but what is there would seem
>>>>> to map to logical elements by subtype and terminaltype, after those the> > data doesn't seem to add up (eg number of input/output channels
>>>>> missing/wrongly placed etc):
>>>>>
>>>>> ** UNRECOGNIZED:  0b 24 01 00 01 35 00 03 01 02 03
>>>>>       -> Header?
>>>>> ** UNRECOGNIZED:  0c 24 02 05 01 01 00 02 03 00 00 00
>>>>>       -> USB streaming input terminal?
>>>>> ** UNRECOGNIZED:  09 24 03 08 01 03 00 05 00
>>>>>       -> Speaker output terminal?
>>>>> ** UNRECOGNIZED:  0c 24 02 09 01 02 00 08 00 00 00 00
>>>>>       -> Microphone input terminal?
>>>>> ** UNRECOGNIZED:  09 24 03 0c 01 01 00 09 00
>>>>>       -> USB streaming output terminal?
>>>>>
>>>>> Anything there that might ring a bell, or other ideas where to start
>>>>> poking at this thing?
>>>>
>>>> Yeah, most of these look almost sane, so any off-by-one firmware
>>>> issue?
>
> I was looking at this, and comparing it to the corresponding output from
> my Edirol UA-5, which is a class-complient (in its standard mode) 2 in / 2
> out device. The descriptors look suspiciously similar on both devices,
> especially considering that the R16 has 8 channels of input instead of 2
> and a MIDI interface which the UA-5 lacks.
>
> I'm not sure exactly which version of the USB audio standard they
> correspond to, looking at the specifications for versions 1 and 2 it
> didn't seem to make sense, but they do happen to correspond very much to
> the descriptions in the following document:
>
> https://www.silabs.com/Support%20Documents/TechnicalDocs/AN295.pdf
>
> The fact that lsusb doesn't recognize them I would think boils down to the
> fact that it simply doesn't know about USB audio; it appears that the ALSA
> USB driver can make sense of the information, which is why the resulting
> entry in the quirks table doesn't need a FIXED_ENDPOINT quirk.

lsusb knows about USB audio alright, the problem is all these stupid 
vendors tagging their devices and their interfaces as vendor specific, 
even if when actually are class compliant. Which is why the quirks-table 
is needed: QUIRK_AUDIO_STANDARD_INTERFACE just tells the driver to parse 
the descriptor as a standard audio interface despite it claiming to be 
vendor specific. But lsusb doesn't have access to the quirks table.

	- Panu -

>
> /Ricard
>
