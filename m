From: Ronny Standtke <Ronny.Standtke@gmx.net>
Subject: Re: How to debug?
Date: Fri, 2 Feb 2007 21:44:47 +0100
Message-ID: <200702022144.47885.Ronny.Standtke@gmx.net>
References: <200701302251.28880.Ronny.Standtke@gmx.net>
	<s5habzwjujs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5habzwjujs.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Thank you very much for your reply.

> How did you set index options?

Here is what I did just now:

I removed all customizations from /etc/modprobe.d/alsa-base and reloaded alsa. 
Then all my soundcards are visible:

-----------
dhcppc0:~# cat /proc/asound/cards
 0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
                      Intel 82801DB-ICH4 with AD1980 at 0xeb000000, irq 217
 1 [Headset        ]: USB-Audio - Logitech USB Headset
                      Logitech Logitech USB Headset at usb-0000:00:1d.0-2, 
full speed
 2 [U0x46d0x8ce    ]: USB-Audio - USB Device 0x46d:0x8ce
                      USB Device 0x46d:0x8ce at usb-0000:00:1d.7-4, high speed
dhcppc0:~# cat /sys/module/snd_intel8x0/parameters/index
-1
dhcppc0:~# cat /sys/module/snd_usb_audio/parameters/index
-1,-1,-1,-1,-1,-1,-1,-1
-----------

The many "-1" indices for the snd_usb_audio module look strange. Is this 
normal?

Then I appended the following lines at the end of /etc/modprobe.d/alsa-base:
-----------
alias snd-card-0 snd-intel8x0
options snd-intel8x0 index=0
alias snd-card-1 snd-usb-audio
options snd-usb-audio index=-2
alias snd-card-2 snd-usb-audio
options snd-usb-audio index=-2
options snd cards_limit=3
-----------

Then I looked at the visible soundcards and the passed index options. 
Unfortunately the on-board soundcard is gone again!

-----------
dhcppc0:~# /etc/init.d/alsa reload
Unloading ALSA sound driver modules: snd-usb-audio snd-usb-lib snd-rawmidi 
snd-seq-device snd-hwdep snd-intel8x0 snd-ac97-codec snd-ac97-bus snd-pcm-oss 
snd-mixer-oss snd-pcm snd-timer snd-page-alloc.
Loading ALSA sound driver modules: snd-usb-audio snd-usb-lib snd-rawmidi 
snd-seq-device snd-hwdep snd-intel8x0 snd-ac97-codec snd-ac97-bus snd-pcm-oss 
snd-mixer-oss snd-pcm snd-timer snd-page-alloc.
dhcppc0:~# cat /proc/asound/cards
 0 [U0x46d0x8ce    ]: USB-Audio - USB Device 0x46d:0x8ce
                      USB Device 0x46d:0x8ce at usb-0000:00:1d.7-4, high speed
 1 [Headset        ]: USB-Audio - Logitech USB Headset
                      Logitech Logitech USB Headset at usb-0000:00:1d.0-2, 
full speed
dhcppc0:~# cat /sys/module/snd_intel8x0/parameters/index
0
dhcppc0:~# cat /sys/module/snd_usb_audio/parameters/index
-2,-1,-1,-1,-1,-1,-1,-1
-----------

So what can I do next? I would really like to help fixing this issue.

Greetings and Thank you again!

Ronny

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
