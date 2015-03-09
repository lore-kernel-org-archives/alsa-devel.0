From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: RawMIDI behaviour with MidiFace 4x4
Date: Mon, 09 Mar 2015 09:43:56 +0100
Message-ID: <54FD5D4C.3040204@ladisch.de>
References: <6A72E9C91650BD49A6D9B305755BC04C42D801FA@mbs1.ad.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 2B2242605C4
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 09:43:59 +0100 (CET)
In-Reply-To: <6A72E9C91650BD49A6D9B305755BC04C42D801FA@mbs1.ad.jyu.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Kalvas, Taneli" <taneli.v.m.kalvas@jyu.fi>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Kalvas, Taneli wrote:
> writing to the midi port with snd_rawmidi_write() seems to broken. The
> function accepts any size of data block and claims to have sent
> everything. In reality only a part of the message is sent.
>
> My hardware is Miditech Midiface 4x4, a USB midi interface:
>  1 [MIDI4x4        ]: USB-Audio - MIDI4x4
>                       MIDIPLUS MIDI4x4 at usb-0000:00:14.0-1, full speed

snd_rawmidi_write() never accepts more data than it can handle (in
blocking mode, it waits until the buffer is empty enough).  The
snd-usb-audio driver waits until the device has accepted the data.

Are there any messages in the system log when this happens?

Please show the output of "lsusb -d 1acc:1a0b -v".

> I have tested the system by connecting the output port to an input
> port on the hardware and having another program output the received
> bytes on stdout. My observations:
> - As long as the buffer size is 276 bytes or less it gets sent ok
> - Larger buffer sizes cause corruption and roughly 300 bytes of received.

This sounds as if the device has a buffer size of 256 bytes, but does
not actually check if the buffer is full, and always accepts more data.

Does later data overwrite data that should have been sent earlier?

> Is there a way to connect two programs via a virtual RawMIDI port so
> that I could test without using the hardware?

Load the snd-virmidi module, and connect two of its ports with aconnect.


Regards,
Clemens
