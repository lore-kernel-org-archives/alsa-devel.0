From: Paul Davis <pbd@op.net>
Subject: Re: ALSA-0.9.0rc2 and RME HammerFall
Date: Wed, 04 Sep 2002 14:26:51 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17mepp-0002Py-00@usw-sf-list1.sourceforge.net>
References: <20020904180458.8061.qmail@web20810.mail.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 04 Sep 2002 11:04:58 PDT."
             <20020904180458.8061.qmail@web20810.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Shane Walton <dsrelist@yahoo.com>
Cc: ALSA Development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>         ALSA lib pcm_hw.c:579: (snd_pcm_hw_open)
>SNDRV_PCM_IOCTL_PVERSION failed:  Inappropriate ioctl
>for device
>          failed to open audio device default
>(Inappropriate ioctl for device)
> 
>snd_pcm_hw_open is looks like this:
>     snd_pcm_hw_open(pcmp, name, card, device,
>subdevice, stream, mode)
>          pcmp = 0x4022465e
>          name = 0x0
>          card = 0 
>          device = 0 
>          subdevice = -1
>          stream = SND_PCM_STREAM_CAPTURE
>          mode = 0
> 
>the line inside snd_pcm_hw_open that is failing
>contains this function call:
>     ioctl(fd, SNDRV_PCM_IOCTL_PVERSION, &ver)
>         fd = 7
>         &ver = 6

sounds to me as though you have ended up with a mixed up installation
of ALSA: you have linked against one version of alsa-lib, but are
using a non-matching version of the alsa-drivers.

--p


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
