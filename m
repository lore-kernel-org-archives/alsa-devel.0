From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Bt87x Audio Capture
Date: Fri, 10 Mar 2006 16:08:50 +0100
Message-ID: <20060310150850.GA15828@turing.informatik.uni-halle.de>
References: <440F4F06.4030904@kmit.sk>
 <20060309074930.GA993@turing.informatik.uni-halle.de>
 <440FF003.5050106@kmit.sk>
 <20060309131146.GA4299@turing.informatik.uni-halle.de>
 <441163B2.4060407@kmit.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <441163B2.4060407@kmit.sk>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ondrej Ivani?? <ondrej@kmit.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ondrej Ivani?? wrote:
> card 1: Bt878 [Brooktree Bt878], device 0: Bt87x Digital [Bt87x Digital]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 1: Bt878 [Brooktree Bt878], device 1: Bt87x Analog [Bt87x Analog]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> 
> $ arecord -Dhw:1,1 -f S16_LE -r 119466 -d 20 /tmp/out.wav
> 
> Output file contains only wav header and 0x7fff values.

It seems the analog input pin of the Bt878 chip isn't connected to the
tuner.

I guess the digital input isn't connected, either.

> BTW, it's possible to create interconnect between sound card and capture 
> device in TV card?

It would be possible to write an application that records from one of
the Bt878 input devices and then immediately plays the data to the sound
card.  There would be some milliseconds of latency, and it wouldn't work
in most cases because few vendors bother to connect the audio input pins
(as you've seen).


Regards,
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
