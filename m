From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Boss GT-001
Date: Thu, 08 Oct 2015 12:51:54 +0100
Message-ID: <53501158.2GJHLGgpfJ@kamdesktop>
References: <1481883.Y22cmGKEIB@kamdesktop> <4911294.P8gonaEuuA@kamdesktop>
 <alpine.DEB.2.02.1510080849080.30181@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id CFDE526171B
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 13:51:56 +0200 (CEST)
Received: by wiclk2 with SMTP id lk2so21430314wic.1
 for <alsa-devel@alsa-project.org>; Thu, 08 Oct 2015 04:51:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1510080849080.30181@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Ricard Wanderlof <ricard.wanderlof@axis.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 08 Oct 2015 09:02:22 Ricard Wanderlof wrote:

> When the Isochronous Synch Type is Asynchronous, there must be a feedback
> channel where the USB device reports back information so that it can
> adjust the output sampling rate
> (http://wiki.osdev.org/Universal_Serial_Bus#Asynchronous_Endpoints).
> 
> I might be barking up the wrong tree here as I'm new to this, but it looks
> as if endpoint 0x8e is providing the feedback data, and there doesn't seem
> to be any other isochronous endpoint defined in the lsusb dump which could
> be used for the actual capture cdata.
> 
> I'm not sure what 'Implicit feedback Data' means exactly though - is the
> feedback data multiplexed with the capture data perhaps?

I'm quite new to this too, but here is my interpretation.

Implicit feedback means "assumed" and, hence, there is actually no feedback 
channel. That would be "explicit feedback".

This seems to be backed up by the article you linked:

"Asynchronous source endpoints imply their data rate by the number of samples 
produced per (micro)frame. "

In this case the endpoint is an IN (with respect to the host) and so the rate 
is controlled by the GT-001's clock, and communicated to the host via the 
samples per microframe (wMaxPacketSize?) and it is the host's job to keep up 
with that.

On the other hand, playback data is different. According to the article:

"Asynchronous sink endpoints must provide explicit feedback to the source 
endpoint. When the source endpoint is the host, it is the responsibility of 
the device driver to process the explicit feedback properly. This feedback 
allows the host and device to make slight adjustments to the data rate in 
order to compensate for any clock drift."

So async playback (OUT) devices *do* seem to need explicit feedback.

My reading of the Interface descriptor data for the GT-001 is as follows:

Interface 1 has an OUT (playback) endpoint number 13 which is Isochronous and 
Asynchronous. The implications is explicit feedback is required from the 
device to the host to control the output rate.

Interface 2 has an IN (record) endpoint number 14 which is Isochronous and 
Asynchronous and uses implicit feedback, so no feedback channel is required.

Interface 3 is MIDI, comprising IN and OUT bulk data endpoints and IN and OUT 
interrupt endpoints. Note that this is a Roland MIDI Interface which has a 
specific quirk, where the endpoints contain multiple MIDI channels as 
specified by the Vendor specific CS_INTERFACE data:

** UNRECOGNIZED:  06 24 f1 02 03 03

This can be read as:
Field               Value   Description
bLength             0x06    Size of this descriptor in bytes
bDescriptorType     0x24    CS_INTERFACE
bDescriptorSubtype  0xf1    Roland specific
UNKNOWN             0x02    MIDI channels
UNKNOWN             0x03    Number of input MIDI channels
UNKNOWN             0x03    Number of output MIDI channels

So, in this case, there are 3 In and 3 OUT MIDI channels associated with this 
Interface.

However, these definitions don't seem to fully align with my configuration 
and, when I used those definitions in the quirk, playback didn't work. I guess 
it's entirely possible the attributes in the descriptor are complete rubbish.

I have some usbmon dumps which I will try to find time to analyze.

Cheers,

Keith
