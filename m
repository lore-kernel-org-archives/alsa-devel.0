From: Arcady Genkin <agenkin@thpoon.com>
Subject: Re: Re: Audigy 2 support - update
Date: Sat, 24 May 2003 14:47:15 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <86el2ouqq4.fsf@tea.thpoon.com>
References: <20030523051240.GA10831@www.angiotech.com>
	<1053675028.18540.70.camel@rivendell.home.local>
	<yw1xznlevz8l.fsf@zaphod.guide>
	<1053747556.6906.4.camel@rivendell.home.local>
	<20030524165935.GB17884@www.angiotech.com>
Reply-To: agenkin-dated-1055009935.e7788b@thpoon.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Stephen Hassard <steve@hassard.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Stephen Hassard <steve@hassard.net> writes:

> On that note, does anyone know if you can purchase a digital IO
> module for the Audigy2 separate from the Platinum package? I
> wouldn't mind finding one that sits over a PCI slot in my chassis. I
> don't like cables that hang out the front of my case.

Have a look at Audigy2 Platinum EX.  Essentially, it's the same as the
regular platinum (i.e. it comes with an internal PCI card), but
instead of the LiveDrive there is an external module full of I/O
connectors.

I have the Audigy2 Platinum Ex, which I purchased for the same reason
as you.  However, I still could not get Alsa's emu10k1 driver to work
with it (neither the recent CVS version, nor the 0.9.3 series). :(  I
get the following error.  SB's emu10k1 driver works, though.

,----[ modprobe output ]
| ice alsa-driver # modprobe snd-emu10k1
| /lib/modules/2.4.20/kernel/sound/pci/emu10k1/snd-emu10k1.o: \
|   init_module: No such device
| Hint: insmod errors can be caused by incorrect module parameters, \
|   including invalid IO or IRQ parameters.
|       You may find more information in syslog or the output from dmesg
| /lib/modules/2.4.20/kernel/sound/pci/emu10k1/snd-emu10k1.o: insmod \
|   /lib/modules/2.4.20/kernel/sound/pci/emu10k1/snd-emu10k1.o failed
| /lib/modules/2.4.20/kernel/sound/pci/emu10k1/snd-emu10k1.o: insmod \
|   snd-emu10k1 failed
`----

,----[ dmesg output ]
| PCI: Found IRQ 11 for device 02:05.0
| PCI: Sharing IRQ 11 with 00:1f.3
| PCI: Sharing IRQ 11 with 02:01.0
| ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:2089: AC'97 0:0 does not respond - RESET
| EMU10K1/Audigy soundcard not found or device busy
`----
-- 
Arcady Genkin

guilt is the cause of more disauders
than history's most obscene marorders (E.E. Cummings)


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
