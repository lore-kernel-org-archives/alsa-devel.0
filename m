From: Manush Dodunekov <manush@stendahls.net>
Subject: unitor8/amt8 driver for alsa 0.9.0rc1
Date: Wed, 1 May 2002 01:09:27 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0205010047120.23423-100000@pulse.stendahls.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


The following patch:

	http://fett.net/m/alsa/alsa-0.9.0rc1-unitor8.patch

implements a driver for the Emagic Unitor family of multiport MIDI 
interfaces. Only serial connection is supported. You need to rerun the 
autoconf toolchain after applying the patch.

The driver is heavily based on serial-u16550.c, which may be the wrong
concept. A more correct concept seems to have a generic-serial.c and
generic-usb.c, which only implement a communication channel. The interface
drivers could then load&use them and only implement their own
init/port-select/whatever dialect. Lots of MIDI interfaces come with both
USB and serial connectors nowadays. Any thoughts on this?

The driver might or might not work for you. It works with my AMT8, using 
the following line in modules.conf:

options snd-unitor8 snd_id=AMT8 snd_enable=1 snd_port=0x03f8 snd_irq=4 
snd_speed=115200 snd_ports=8

snd_port and snd_irq for your port are displayed by the kernel at bootup.

You also need to:

# setserial /dev/ttyS0 uart none

in order to use this driver. Replace ttyS0 with the actual com port your 
midi interface is hooked to.

The driver does not yet put the interface into "computer mode" while
active. The current patch remains active when one or more ports are
opened.

The driver does not yet support send-to-all output port and catch-all 
input port (port 0 in the windows driver).

Comments and suggestions are highly welcome.

regards,
Manush


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
