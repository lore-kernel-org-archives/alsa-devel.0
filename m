From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Fwd: Midiator MS-124w w/ALSA0.9.0beta12
Date: Mon, 4 Mar 2002 14:46:33 +0100 (CET)
Message-ID: <Pine.LNX.4.33.0203041445490.487-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <200203040834.58013.schwaahed@yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Darwin Marcus Johnson <schwaahed@yahoo.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "linux-audio-dev@music.columbia.edu" <linux-audio-dev@music.columbia.edu>
List-Id: alsa-devel@alsa-project.org

On Mon, 4 Mar 2002, Darwin Marcus Johnson wrote:

> Hi All,
> 
> I am trying to get my Midiator Midi interface working with ALSA0.9.0beta 12.
>  I am trying to insert the snd-serial-u16550 module. My /etc/modules.conf
>  seems to have the right options for this card.
> 
> Does anyone have a Midiator Midi interface working with the ALSA support?
> 
> Does anyone have another serial interface working with the snd-serial-u16550
> module?
> 
> Can anyone point me to any documentation on setting up the modules beside
> the 1 page in the ALSA-HOWTO that contain this info below?
> 
> Does any of this info below have some obvious over sights, mistakes, 
> omissions?
> 
> -Thanks
> Darwin
> 
> >From the ALSA-HOWTO:
> ----snip------------------------
> snd_port        - port # for UART16550A chip
> snd_irq - IRQ # for UART16550A chip, -1 = poll mode
> snd_divisor     - divisor to calculate bit rate
> 			115200bps / # - 3 = 38.4kbpsdefault
> snd_ports       - number of MIDI ports 1,2,3,4 - 1 = default
> ----snip-----------------------
> 
> # modprobe snd-serial-u16550
> 
> I get these error messages:
> ----snip-----------------------
> Note: /etc/modules.conf is more recent than
> /lib/modules/2.4.18-rc1/modules.dep
> /lib/modules/2.4.18-rc1/kernel/driver/sound/snd-serial-u16550.o: init_module:
> No such device
> Hint: insmod errors can be caused by incorrect module parameters, including
> invalid IO or IRQ parameters
> /lib/modules/2.4.18-rc1/kernel/driver/sound/snd-serial-u16550.o: insmod
> /lib/modules/2.4.18-rc1/kernel/driver/sound/snd-serial-u16550.o failed
> /lib/modules/2.4.18-rc1/kernel/driver/sound/snd-serial-u16550.o: insmod
> snd-serial-u16550 failed
> ----snip-------------------------
> 
> # setserial -a /dev/ttyS0
> /dev/ttyS0, Line 0, UART: 16550A, Port: 0x03f8, IRQ: 4
>         Baud_base: 57600, close_delay: 50, divisor: 1
>         closing_wait: 3000
>         Flags: spd_normal skip_test

You must turn the default Linux serial driver off before trying the ALSA 
driver:

setserial /dev/ttyS0 uart none

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
