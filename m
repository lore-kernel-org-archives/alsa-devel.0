From: "Adrian Stancu" <adrian.stancu.82@gmail.com>
Subject: Re: snd-usb-audio syncronisation problem
Date: Fri, 22 Feb 2008 15:45:07 +0200
Message-ID: <43e8c7320802220545m6ccf8c7fr13a9390563d7df7@mail.gmail.com>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>
	<47BEC97A.3030507@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 155D2245DC
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 14:45:11 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id u3so281987tia.8
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 05:45:09 -0800 (PST)
In-Reply-To: <47BEC97A.3030507@ladisch.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

Thank you very much for helping me!

Using the original module, the momentary frequency is always stalled
at 48000Hz during playback:
vader:~# while sleep 0.3; do grep "Momentary freq"
/proc/asound/card1/stream0; done
    Momentary freq = 48000 Hz (0x6.0000)
    Momentary freq = 48000 Hz (0x6.0000)
    Momentary freq = 48000 Hz (0x6.0000)
    Momentary freq = 48000 Hz (0x6.0000)
    Momentary freq = 48000 Hz (0x6.0000)

 note: I started playback after issuing the command.
So maybe this particular type of interface does not report back
correctly, thus confusing the driver?

After playing with subs->freqm in init_substream_urbs(,,,), the
situation improved dramatically for me, but this is no general fix...
In this case, I get:
Momentary freq = 48001 Hz (0x6.0007) and I get a single little pop
once about 90 seconds, but this is nothing compared to the horrible
sound I normally get when the buffer gets empty.


On Fri, Feb 22, 2008 at 3:09 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Adrian Stancu wrote:
>  > I'm using an E-MU 0404 USB interface with the snd-usb-audio module
>  > from alsa 1.0.16, operating in isochronous asynchronous mode. This
>  > interface was producing very annoying click/pop sounds at regular
>  > intervals during playback. Eventually I discovered that the
>  > syncronisation mechanism telling the driver to send audio data faster
>  > or slower to match the interface's consumption speed does not work as
>  > expected, for some reason.
>
>  The momentary frequency as requested by the device is shown in
>  /proc/asound/card?/stream? (if CONFIG_SND_VERBOSE_PROCFS is enabled).
>
>  Try something like:
>
>  while sleep 0.3; do grep "Momentary freq" /proc/asound/card0/stream0; done
>
>  In theory, once the device has determined its own speed relative to
>  the computer, this value should be nearly constant.  (When a stream has
>  just been started, the requested frequency usually is higher because the
>  device's buffer is empty.)
>
>
>  Regards,
>  Clemens
>
