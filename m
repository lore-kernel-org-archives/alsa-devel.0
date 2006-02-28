From: "Adrian McMenamin" <adrian@mcmen.demon.co.uk>
Subject: Re: PCM driver only plays tiny portion of clip
Date: Tue, 28 Feb 2006 15:14:16 -0000 (GMT)
Message-ID: <47411.217.150.108.178.1141139656.squirrel@newgolddream.dyndns.info>
References: <44054.217.150.108.178.1141056426.squirrel@newgolddream.dyndns.info>
    <20060227172601.GA446@turing.informatik.uni-halle.de>
    <40613.217.150.108.178.1141061722.squirrel@newgolddream.dyndns.info>
    <20060228073049.GA4158@turing.informatik.uni-halle.de>
    <35384.217.150.108.178.1141117853.squirrel@newgolddream.dyndns.info>
    <20060228145541.GA20876@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id C1CEB173
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2006 16:14:18 +0100 (MET)
In-Reply-To: <20060228145541.GA20876@turing.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 28 February, 2006 2:55 pm, Clemens Ladisch wrote:
> Adrian McMenamin wrote:
>> On Tue, 28 February, 2006 7:30 am, Clemens Ladisch wrote:
>> > When an interrupt occurs (that is, when it calls
>> > snd_pcm_period_elapsed()), ALSA calls the pointer callback.  A
>> different
>> > return value indicates that there is some free space in the buffer, =
so
>> > ALSA wakes up the application so that it can write more data.
>>
>> This (application writing more data) doesn't seem to be happening in m=
y
>> case.
>>
>> I am using oss emulation and a simple car command ie cat somefile.wav =
>
>> /dev/dsp - should I expect this to work, or do I really need to compil=
e
>> something like sox (does sox use the native alsa if)?
>
> Dumping something into /dev/dsp should work.  It may use the wrong
> sample format, but if the first part of the file can be heard, the rest
> should play OK, too.
>
Thanks

I am at something of a loss though.

I admit that my dma code as it is today won't work properly - the dma
transfer function tries to fill the whole of the ring buffer everytime it
is called. But it is only being called once - which is the real problem! =
I
can fix the dma issue I am sure, but it is not the blockage at the moment=
.

When the pointer callback returned incorrect values the dma function did
get called more than once and the sample was all tranferred, if in a
useless way. But now it sends the correct value (and I've tested it as
such)such) it doesn't and the playback is stuck in an endless loop merely
playing the first part of the sample.

I'm at something of a loss as to know what to do



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
