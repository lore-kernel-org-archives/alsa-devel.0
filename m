From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Problem getting USB DAC to work
Date: Mon, 11 Jul 2016 16:42:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1607111639100.17766-100000@netrider.rowland.org>
References: <loom.20160711T211905-595@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <loom.20160711T211905-595-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: John Westwood <westwood.1976-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 11 Jul 2016, John Westwood wrote:

> I think the MTP stuff is a red herring. I checked syslog when I use a DAC that
> works (Audiolab MDAC) and that has the MTP lines too, but it doesn't have the
> warning line about Unlikely big volume range.
> 
> In addition, the working DAC has the following lines which are not present the
> non-working DAC:
> 
> Jul 11 19:56:35 atlas kernel: [83940.049124] input: Lakewest Audio Audiolab
> M-DAC as /devices/pci0000:00/0000:00:1d.1/usb7/7-2/7-2:1.0/0003:0451:
> ADAC.0002/input/input12
> Jul 11 19:56:35 atlas kernel: [83940.104367] hid-generic 0003:0451:ADAC.0002:
> input,hiddev0,hidraw1: USB HID v1.11 Device [Lakewest Audio Audiolab M-DAC] on
> usb-0000:00:1d.1-2/input0
> 
> With the non-working DAC I get these lines instead:
> 
> Jul 11 19:56:25 atlas kernel: [83930.079063] usb 7-2: Warning! Unlikely big
> volume range (=65535), cval->res is probably wrong.
> Jul 11 19:56:25 atlas kernel: [83930.079067] usb 7-2: [2] FU [PCM Playback
> Volume] ch = 1, val = -32768/32767/1
> 
> 
> I think maybe the problem is similar to this one:
> 
> https://groups.google.com/forum/#!topic/linux.debian.kernel/HwwkRkbL5aY
> 
> Is my problem a bug in snd-usb-audio? Or am I doing something wrong? I would
> really appreciate some thoughts on this, I feel like I'm talking to myself :-(

Considering that you're not really doing anything, you're probably not 
doing something wrong.  :-)

On the other hand, you're likely to get more of a response if you 
direct your questions to the person who solved the problem mentioned in 
that Debian bug report, and if you CC: the sound developers' mailing 
list rather than the general USB list.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
