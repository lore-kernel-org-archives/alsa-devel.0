From: sdaau <sd-0eUWFqAKQRd/SzgSGea1oA@public.gmane.org>
Subject: Re: AudioArduino - an ALSA soundcard driver for FTDI-based Arduinos
Date: Mon, 30 May 2011 17:28:52 +0200
Message-ID: <4DE3B7B4.8000805@imi.aau.dk>
References: <4DE31FE4.4040807@imi.aau.dk> <20110530074204.GA7806@kroah.com>
Reply-To: sd-0eUWFqAKQRd/SzgSGea1oA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110530074204.GA7806-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Greg K-H,


> Very cool stuff, nice job!
>
> Any thoughts about submitting back your kernel driver changes so we can
> add them to the main kernel tree so that people don't have to build
> out-of-tree kernel drivers to use this?
>

Thanks for the encouraging and kind feedback - and of course, for all 
your (and everyone else's) work, that forms the backbone of the project!

I would, personally, be very happy to have a contribution in the kernel 
:) One reservation that I'd have, is that often times I read on mailing 
lists that the kernel is 'bloated'. And since this is a driver for a 
device not (necessarily) intended to be a soundcard - essentially, a 
(basic) academic exercise in providing an example of a working, yet 
fully open soundcard, spanning both software and hardware -  I'm fearing 
that some users may consider it a 'bloat'; but maybe that is irrelevant?


However, the bigger concern for me is how one would do it technically:

> It could just be an option to the existing ftdi_sio driver that is
> enabled somehow for a specific device, right?
>

Well, I wish it was so - but unfortunately, it is not that way currently.

The thing is, I'm not really an expert in programming, and even less in 
kernel drivers. So, for the time that I had at my disposal, the only 
thing I could have done is try to understand ALSA driver architecture a 
bit better - while the USB part is completely "abstracted".

What I mean by that, is that the main driver file (ftdi_sio-audard.c) is 
first and foremost a copy of ftdi_sio.c from 2.6.32 kernel; then it 
includes a 'snd_ftdi_audard.h' file, which is here not a traditional 
header; it simply contains additional functions which 'add' the ALSA 
interface to ftdi_sio.c.

Finally, the two architectures are connected, such that the ftdi's 
callbacks also call the ALSA related callbacks, in particular:

* ftdi_sio's ftdi_process_packet (raised on incoming USB data) calls 
ALSA-related audard_xfer_buf function (and so the audio capture 
direction is handled)
* ALSA related snd_card_audard_pcm_timer_function calls ftdi_sio's 
ftdi_write function (which controls outgoing USB data - and so the audio 
playback direction is handled).

I've just posted a diff on the SVN repository between the current 
ftdi_sio-audard.c and the original ftdi_sio.c from kernel 2.6.32:

http://sdaaubckp.svn.sourceforge.net/viewvc/sdaaubckp/audard/snd_ftdi_audard-an8m/sio2.6.32-audard.diff?revision=211&view=markup

... the link should show syntax coloring, so it maybe gets easier to see 
what's going on there.


In essence, this driver keeps everything ftdi_sio has (so you still get 
a /dev/ttyUSB0; you can still 'cat' from or 'echo' to this device node 
as usual) - except that, additionally, data is passed also to the 
ALSA-related memory structures (i.e. the dma_area of a particular ALSA 
substream).

Initially, I really wanted to essentially keep ftdi_sio as is, so that I 
wouldn't have to worry about changes to its code; but as the ALSA 
interface requires new functions, I couldn't find a way how to 
selectively #include these functions based on a driver option. One could 
use #defines, maybe, but that's still compile-time handling, not 
run-time handling. And so, I decided to focus instead on problems that I 
had a chance of solving (such as wrapping data for the ALSA ring 
buffers). And just today I discovered that the driver needs a couple of 
changes, that were implemented in ftdi_sio.c since 2.6.32, so that it 
would compile for 2.6.38 (I have now added comments related to this is 
the source file up on SVN).


However, if there is some sort of a tutorial/guide (or even a specific 
existing driver file example) that I could refer to, so as to turn the 
current architecture into an option-based one, such that I avoid messing 
with ftdi_sio.c directly -- I'd definitely love to try and do that; so 
please let me know if there is some sort of a recommended reading for this.


Thanks again for the feedback,
Cheers!













On 2011-05-30 09:42, Greg KH wrote:
> On Mon, May 30, 2011 at 06:41:08AM +0200, sdaau wrote:
>> Hi all,
>>
>> (cross-posting to alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org and
>> gmane.linux.usb.general/linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; apologies if it's
>> inappropriate)
>>
>>
>> I'd just like to inform that the AudioArduino project has been
>> posted online:
>>
>> http://imi.aau.dk/~sd/phd/index.php?title=AudioArduino
>>
>> It contains links to open-source Arduino microcontroller code, and
>> corresponding ALSA driver source code - which can demonstrate mono,
>> full-duplex, 8-bit / 44.1 kHz soundcard operation on an FTDI-based
>> Arduino.
>>
>> There is also a related post on the (new) Arduino Forum:
>> http://arduino.cc/forum/index.php/topic,62582.0.html
>
> thanks,
>
> greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
