From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: RawMIDI behaviour with MidiFace 4x4
Date: Mon, 09 Mar 2015 22:47:32 +0100
Message-ID: <54FE14F4.9070704@ladisch.de>
References: <6A72E9C91650BD49A6D9B305755BC04C42D801FA@mbs1.ad.jyu.fi>,
 <54FD5D4C.3040204@ladisch.de>
 <6A72E9C91650BD49A6D9B305755BC04C42D8067A@mbs1.ad.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id A64C42614A1
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 22:48:06 +0100 (CET)
In-Reply-To: <6A72E9C91650BD49A6D9B305755BC04C42D8067A@mbs1.ad.jyu.fi>
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
>>> I have tested the system by connecting the output port to an input
>>> port on the hardware and having another program output the received
>>> bytes on stdout. My observations:
>>> - As long as the buffer size is 276 bytes or less it gets sent ok
>>> - Larger buffer sizes cause corruption and roughly 300 bytes of received.
>>
>> This sounds as if the device has a buffer size of 256 bytes, but does
>> not actually check if the buffer is full, and always accepts more data.
>>
>> Does later data overwrite data that should have been sent earlier?
>
> By looking at the receiving end bytes it looks exactly like that has happened.

This pretty much proves that this is a bug in the device firmware.

You might try contacting Miditech ...

>>> Is there a way to connect two programs via a virtual RawMIDI port so
>>> that I could test without using the hardware?
>>
>> Load the snd-virmidi module, and connect two of its ports with aconnect.
>
> I did this and by using the virtual ports the behaviour is more
> reasonable, but still not as expected. Everything works ok as long as
> the message length is less than or equal to the buffer size (4096).
> With message sizes larger than that the writing end still claims it
> has sent everything, as it should do because the port is opened in
> blocking mode. On the reading end I can see that some data is missing
> and xruns are reported.

Oops, using snd-virmidi this way also goes through the sequencer, which
does not do blocking.

There is no other way to get a virtual RawMIDI port.

However, the driver was tested with lots of other devices, and huge
SysEx messages have this problem only with your device.


Regards,
Clemens
