From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: Re: [PATCH] USB MIDI driver
Date: Tue, 2 Jul 2002 22:40:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207022240.10455.plcl@telefonica.net>
References: <3D208C5C.36649172@ladisch.de> <s5hhejibem0.wl@alsa2.suse.de> <s5hznxarxmz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznxarxmz.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> - usb compatibility hack was moved to wrapper.h, so that it can be
>   shared with usbuadio.c
>
> - newly added virmidi registrations.
>   that means, snd-usb-midi will have its own rawmidi devices
>   automatically as /dev/snd/midiCxDx.
>   this will be good for applications which speak only with
>   rawmidi.
>
> the latter one was not tested.
> can anyone update the cvs if it works?
>

I can't compile current CVS usb drivers:

gcc -E -M -DALSA_BUILD -D__KERNEL__ -DMODULE=1 
-I/home/plc/kernelsrc/ALSA/cvstree/alsa-driver/include 
-I/lib/modules/2.4.18/build/include -O2 -mpreferred-stack-boundary=2 
-march=k6 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe  
usbaudio.c usbaudio.h usbmidi.c usbmixer.c wrapper.h > .depend
wrapper.h:1:40: missing binary operator before '<'
wrapper.h:15:40: missing binary operator before '<'
make[1]: *** [fastdep] Error 1

Pedro.



-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
