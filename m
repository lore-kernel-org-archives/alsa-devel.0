From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: audiophile not working
Date: Mon, 4 Mar 2002 13:06:27 +0100 (CET)
Message-ID: <Pine.LNX.4.33.0203041304580.487-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA01406
	for <alsa-devel@alsa-project.org>; Mon, 4 Mar 2002 13:06:53 +0100
In-Reply-To: <wolfgang-1020304124340.A469435@loopback>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Wolfgang Hamann <hamann.w@t-online.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 4 Mar 2002, Wolfgang Hamann wrote:

> Hi,
> 
> I just installed linux (Suse 7.3 package) and upgraded to alsa 0.9beta11 in order to
> run some of my own code. 
> The hardware is recognized:
> 
> # cat /proc/asound/card0/ice1712
> ICE1712
> 
> EEPROM:
>   Subvendor        : 0x121434d6
>   Size             : 29 bytes
>   Version          : 1
>   Codec            : 0x10
>   ACLink           : 0x80
>   I2S ID           : 0x72
>   S/PDIF           : 0x3
>   GPIO mask        : 0x4
>   GPIO state       : 0xfe
>   GPIO direction   : 0xfb
>   AC'97 main       : 0x0
>   AC'97 pcm        : 0x0
>   AC'97 record     : 0x0
>   AC'97 record src : 0x44
>   DAC ID #0        : 0x4
>   DAC ID #1        : 0x0
>   DAC ID #2        : 0x0
>   DAC ID #3        : 0x0
>   ADC ID #0        : 0x4
>   ADC ID #1        : 0x0
>   ADC ID #2        : 0x0
>   ADC ID #3        : 0x0
>   Extra #28        : 0x1
> 
> However there does not seem to be a proper sequencer - modprobing the snd-ice1712
> does not load sequencer modules as I would normally expect, and if I load them manually,
> there still is no "hw" sequencer to use
> 
> # amixer
> ALSA lib control.c:601:(snd_ctl_open_noupdate) Invalid CTL default
> amixer: Mixer attach default error: No such file or directory
> # pmidi -l
> Could not open sequencer No such file or directory
> ALSA lib control.c:601:(snd_ctl_open_noupdate) Invalid CTL hw:0
> # alsactl store
> /tmp/alsactl: get_controls:432: snd_ctl_open error: No such file or directory
> 
> I hope anyone can shed some light on that

It looks like that /dev/snd/* devices are not accessible. Try 'snddevices' 
script in alsa-driver.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
