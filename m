From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-audio syncronisation problem
Date: Fri, 22 Feb 2008 14:57:22 +0100
Message-ID: <47BED4C2.4020501@ladisch.de>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>	
	<47BEC97A.3030507@ladisch.de>
	<43e8c7320802220545m6ccf8c7fr13a9390563d7df7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 51184245E0
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 14:55:36 +0100 (CET)
In-Reply-To: <43e8c7320802220545m6ccf8c7fr13a9390563d7df7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Stancu <adrian.stancu.82@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adrian Stancu wrote:
> Using the original module, the momentary frequency is always stalled
> at 48000Hz during playback:
> vader:~# while sleep 0.3; do grep "Momentary freq"
> /proc/asound/card1/stream0; done
>     Momentary freq = 48000 Hz (0x6.0000)
>     Momentary freq = 48000 Hz (0x6.0000)
>     Momentary freq = 48000 Hz (0x6.0000)
>     Momentary freq = 48000 Hz (0x6.0000)
>     Momentary freq = 48000 Hz (0x6.0000)
>
>  note: I started playback after issuing the command.
> So maybe this particular type of interface does not report back
> correctly, thus confusing the driver?

This is possible.  Please try to put printk's into
retire_playback_sync_urb(_hs) to see whether these functions ever get
called, and whether the line "subs->freqm = f;" is reached.

Please show the entire contents of /proc/asound/card1/stream0 while the
device is playing.


Regards,
Clemens
