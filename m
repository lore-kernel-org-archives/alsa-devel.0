From: "Yon Mercury" <swirlee@stickist.com>
Subject: Echo CardBus driver
Date: Sat, 20 Nov 2004 17:49:24 -0700
Message-ID: <20041121004924.M21756@stickist.com>
References: <20041115220752.M43176@stickist.com> <XFMail.20041116091540.pochini@shiny.it> <20041116175201.M64250@stickist.com> <20041119195519.5cb49c9a.pochini@shiny.it> <20041119213839.M39036@stickist.com> <20041120112458.2ca2c054.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041120112458.2ca2c054.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Giuliano,

OK I solved the compilation problem by going straight to my laptop (I was 
testing compilation on my desktop without PCMCIA kernel support)...

I went out and picked up the Indigo IO card, installed it in Windows and 
tested it-- all OK. I compiled and installed the echo patched alsa and 
rebooted. 

I didn't edit modules.conf to add a snd-indigoio alias for ALSA, but it 
didn't seem to matter. The cardbus support loaded fine and the blue light on 
the Indigo came on (woo!). Though the driver seemed to detect an IndigoIO, 
there was an error in the DSP init:

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
  PCI: Found IRQ 10 for device 00:0f.0
  PCI: Found IRQ 10 for device 00:0f.1
  PCI: Sharing IRQ 10 with 00:0d.0
  Yenta ISA IRQ mask 0x0ab8, PCI irq 10
  Socket status: 30000820
  Yenta ISA IRQ mask 0x0ab8, PCI irq 10
  Socket status: 30000006
  cs: cb_alloc(bus 2): vendor 0x1057, device 0x3410
  PCI: Enabling device 02:00.0 (0000 -> 0002)
  cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
  cs: IO port probe 0x0800-0x08ff: clean.
  cs: IO port probe 0x0c00-0x0cff: clean.
  cs: IO port probe 0x0a00-0x0aff: clean.
  ALSA echoaudio.c:1900: Echoaudio driver starting...
  ALSA echoaudio.c:1829: chip=c8e10014
  ALSA echoaudio.c:1852: pci=cb668c00 irq=10 subdev=00a0 Init hardware...
  ALSA indigoio_dsp.c:39: init_hw() - Indigo IO
  ALSA echoaudio_dsp.c:396: load_dsp: Set bad_board to TRUE
  ALSA echoaudio_dsp.c:363: Resident loader successfully installed
  ALSA echoaudio_dsp.c:187: Read serial number 00a07ff0 00a3bb83 000398a0 
00e0df3c 007a66e1
  ALSA echoaudio_dsp.c:520: load_dsp: Set bad_board to FALSE
  ALSA echoaudio_dsp.c:738: restore_dsp_rettings
  ALSA echoaudio_dsp.c:61: wait_handshake(): Timeout waiting for DSP
  ALSA echoaudio.c:1864: init_hw err=fffffffb
  ALSA echoaudio.c:1772: Stop DSP...
  ALSA echoaudio_dsp.c:983: rest_in_peace() open=0
  ALSA echoaudio_dsp.c:943: stop_transport 0
  ALSA echoaudio_dsp.c:61: wait_handshake(): Timeout waiting for DSP
  ALSA echoaudio.c:1777: Stopped.
  ALSA echoaudio.c:1785: MMIO freed.
  ALSA echoaudio.c:1792: Chip freed.
  ALSA echoaudio.c:2075: Echoaudio soundcard not found or device busy

This is on kernel 2.4.25 from a Demudi base installation.

Not bad so far!

-Mercury



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
