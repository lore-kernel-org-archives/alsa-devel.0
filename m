From: Bob Ham <node@users.sourceforge.net>
Subject: errors with 2.5.44 and cvs
Date: Tue, 22 Oct 2002 08:17:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021022071723.GA7437@depression.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

While compiling cvs (as of about 6am, GMT) drivers, I get an absurd amount of this:

In file included from /home/node/proj/alsa/alsa-driver/include/sndversions.h:9,
                 from /home/node/proj/alsa/alsa-driver/include/adriver.h:41,
                 from /home/node/proj/alsa/alsa-driver/include/sound/driver.h:43,
                 from ../../alsa-kernel/pci/emu10k1/irq.c:28,
                 from irq.c:2:
/home/node/proj/alsa/alsa-driver/include/modules/acore__rawmidi.ver:35:1: warning: "__ver_snd_rawmidi_kernel_write" redefined
In file included from /lib/modules/2.5.44/build/include/linux/modversions.h:157,
                 from /home/node/proj/alsa/alsa-driver/include/adriver.h:40,
                 from /home/node/proj/alsa/alsa-driver/include/sound/driver.h:43,
                 from ../../alsa-kernel/pci/emu10k1/irq.c:28,
                 from irq.c:2:
/lib/modules/2.5.44/build/include/linux/modules/sound/core/rawmidi.ver:35:1: warning: this is the location of the previous definition

Not good.  After compilation and installation, I get:

insanity root # depmod -a
depmod: *** Unresolved symbols in /lib/modules/2.5.44/kernel/sound/acore/seq/snd-seq.o
depmod: *** Unresolved symbols in /lib/modules/2.5.44/kernel/sound/acore/snd.o

Bad.  Trying to modprobe, I get:

insanity root # modprobe snd-emu10k1
/lib/modules/2.5.44/kernel/sound/acore/snd.o: unresolved symbol snd_device_gid
/lib/modules/2.5.44/kernel/sound/acore/snd.o: unresolved symbol snd_device_uid
/lib/modules/2.5.44/kernel/sound/acore/snd.o: unresolved symbol snd_device_mode
/lib/modules/2.5.44/kernel/sound/acore/snd.o: unresolved symbol snd_major
/lib/modules/2.5.44/kernel/sound/acore/snd.o: insmod
/lib/modules/2.5.44/kernel/sound/acore/snd.o failed
/lib/modules/2.5.44/kernel/sound/acore/snd.o: insmod snd-emu10k1 failed

Very bad.

Bob


-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future of 
Java(TM) technology. Join the Java Community Process(SM) (JCP(SM)) 
program now. http://ad.doubleclick.net/clk;4699841;7576301;v?
http://www.sun.com/javavote
