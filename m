From: Carlos Pita <carlosjosepita@yahoo.com.ar>
Subject: Re: emu10k1 devices (w/correction)
Date: Sun, 26 Dec 2004 23:08:16 -0300
Message-ID: <200412262308.16924.carlosjosepita@yahoo.com.ar>
References: <200412262245.41264.carlosjosepita@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp208.mail.sc5.yahoo.com (smtp208.mail.sc5.yahoo.com [216.136.130.116])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 068D2246
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2004 03:02:03 +0100 (MET)
In-Reply-To: <200412262245.41264.carlosjosepita@yahoo.com.ar>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Even after manually correcting the device file with:

  rm /dev/snd/pcmC0D3p
  mknod /dev/snd/pcmC0D3p c 116 19
  chown root:audio /dev/snd/pcmC0D3p
  chmod 660 /dev/snd/pcmC0D3p

so the device is now:

  crw-rw----  1 root audio 116, 19 2004-12-26 22:48 /dev/snd/pcmC0D3p

I still get the same error. My card is audigy, so my driver is snd_emu10k1.
I don't know which is that device. I guess it is not my main playback device,
so I wouldn't care about avoiding it, but I don't know how to "turn if off".

Thank you again.
Regards, Carlos.

> Sorry, the error reported by portaudio is not
>   ALSA lib pcm_hw.c:1155:(snd_pcm_hw_open) open /dev/snd/pcmC0D3p failed: No such file or directory
> but
>   ALSA lib pcm_hw.c:1155:(snd_pcm_hw_open) open /dev/snd/pcmC0D3p failed: No such device
> 
> Hi!
> 
> I'm getting the following error when initializing portaudio-v19:
> 
>   ALSA lib pcm_hw.c:1155:(snd_pcm_hw_open) open /dev/snd/pcmC0D3p failed: No such file or directory
> 
> The device file is there:
> 
>   crw-rw----  1 root audio 116, 24 2004-12-24 16:55 /dev/snd/pcmC0D0c
>   crw-rw----  1 root audio 116, 16 2004-12-24 16:55 /dev/snd/pcmC0D0p
>   crw-rw----  1 root audio 116, 25 2004-12-24 16:55 /dev/snd/pcmC0D1c
>   crw-rw----  1 root audio 116, 26 2004-12-24 16:55 /dev/snd/pcmC0D2c
>   ----> crw-rw----  1 root audio 116, 26 2004-12-24 16:55 /dev/snd/pcmC0D3p  <-----
> 
> cat /proc/asound/devices:
> 
>    ----> 19: [0- 3]: digital audio playback  <-----
>   26: [0- 2]: digital audio capture
>   25: [0- 1]: digital audio capture
>   16: [0- 0]: digital audio playback
>   24: [0- 0]: digital audio capture
> 
> The device minor number is ok except for /dev/snd/pcmC0D3p, which is created
> with 26 instead of 19. This seems a bug in udev, the corresponding rule is:
> 
>   KERNEL="pcm[CD0-9cp]*", NAME="snd/%k"
> 
> which seems ok. The entry in sysfs is ok too:
> 
> cat /sys/class/sound/pcmC0D3p/dev:
>   116:19
> 
> What do you think?
> 
> Thank you in advance.
> Regards,
> Carlos
> 
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
