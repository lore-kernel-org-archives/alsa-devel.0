From: "Derek D. Martin" <ddm@pizzashack.org>
Subject: Re: alsa configure/install bug
Date: Wed, 26 Jun 2002 15:20:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020626152042.T13917@pizzashack.org>
References: <20020624143111.B1332@pizzashack.org> <s5hit477jta.wl@alsa2.suse.de> <20020625140206.B13917@pizzashack.org> <s5hwusm5pfi.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline; filename="msg.pgp"
In-Reply-To: <s5hwusm5pfi.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

At some point hitherto, Takashi Iwai hath spake thusly:
> > The problem is that if the alsa modules are not installed in
> > /lib/modules/<KVER>/misc, modprobe can't find them to load them.  Once
> > they are installed there, everything works fine.  This is as it was
> > with the 0.9.something beta something that I was using before this,
> > also...  meaning that when I installed the beta drivers previously,
> > they installed in the misc directory (with out me telling them to do
> > so specifically, as far as I can remember), and everything worked
> > fine.
>  
> can you check where the files are copied to?
> just look at what "make install-modules" shows.

Well, as I said, they're copied to the kernel/sound directory in the
correct place for my running kernel.  Specifically,
/lib/modules/2.4.17ddm-mercury-1/kernel/sound/*.  There are no
symlinks, and that is the actual path used by make install.

Actually, I'll just include the output, so you can see it for
yourself (compilation parts snipped out):


rm -f /lib/modules/2.4.17ddm-mercury-1/kernel/sound/snd*.o /lib/modules/2.4.17ddm-mercury-1/kernel/sound/persist.o /lib/modules/2.4.17ddm-mercury-1/kernel/sound/isapnp.o
make[1]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/acore'
mkdir -p /lib/modules/2.4.17ddm-mercury-1/kernel/sound/acore
cp snd-hwdep.o snd-pcm.o snd-rawmidi.o snd-timer.o snd.o /lib/modules/2.4.17ddm-mercury-1/kernel/sound/acore
make  -C oss modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/acore/oss'
mkdir -p /lib/modules/2.4.17ddm-mercury-1/kernel/sound/acore/oss
cp snd-mixer-oss.o snd-pcm-oss.o /lib/modules/2.4.17ddm-mercury-1/kernel/sound/acore/oss
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/acore/oss'
make  -C seq modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/acore/seq'
mkdir -p /lib/modules/2.4.17ddm-mercury-1/kernel/sound/acore/seq
cp snd-seq-device.o snd-seq-instr.o snd-seq-midi-emul.o snd-seq-midi-event.o snd-seq-midi.o snd-seq.o /lib/modules/2.4.17ddm-mercury-1/kernel/sound/acore/seq
make  -C instr modules_install
make[3]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/acore/seq/instr'
mkdir -p /lib/modules/2.4.17ddm-mercury-1/kernel/sound/acore/seq/instr
cp snd-ainstr-fm.o /lib/modules/2.4.17ddm-mercury-1/kernel/sound/acore/seq/instr
make[3]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/acore/seq/instr'
make  -C oss modules_install
make[3]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/acore/seq/oss'
mkdir -p /lib/modules/2.4.17ddm-mercury-1/kernel/sound/acore/seq/oss
cp snd-seq-oss.o /lib/modules/2.4.17ddm-mercury-1/kernel/sound/acore/seq/oss
make[3]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/acore/seq/oss'
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/acore/seq'
make[1]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/acore'
make[1]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/i2c'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/i2c'
make[1]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/drivers'
make  -C mpu401 modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/drivers/mpu401'
mkdir -p /lib/modules/2.4.17ddm-mercury-1/kernel/sound/drivers/mpu401
cp snd-mpu401-uart.o /lib/modules/2.4.17ddm-mercury-1/kernel/sound/drivers/mpu401
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/drivers/mpu401'
make  -C opl3 modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/drivers/opl3'
mkdir -p /lib/modules/2.4.17ddm-mercury-1/kernel/sound/drivers/opl3
cp snd-opl3-lib.o snd-opl3-synth.o /lib/modules/2.4.17ddm-mercury-1/kernel/sound/drivers/opl3
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/drivers/opl3'
make[1]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/drivers'
make[1]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa'
make  -C ad1816a modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa/ad1816a'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa/ad1816a'
make  -C ad1848 modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa/ad1848'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa/ad1848'
make  -C cs423x modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa/cs423x'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa/cs423x'
make  -C es1688 modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa/es1688'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa/es1688'
make  -C gus modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa/gus'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa/gus'
make  -C opti9xx modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa/opti9xx'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa/opti9xx'
make  -C sb modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa/sb'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa/sb'
make  -C wavefront modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa/wavefront'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa/wavefront'
make[1]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/isa'
make[1]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/synth'
make  -C emux modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/synth/emux'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/synth/emux'
make[1]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/synth'
make[1]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci'
make  -C ac97 modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/ac97'
mkdir -p /lib/modules/2.4.17ddm-mercury-1/kernel/sound/pci/ac97
cp snd-ac97-codec.o /lib/modules/2.4.17ddm-mercury-1/kernel/sound/pci/ac97
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/ac97'
make  -C ali5451 modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/ali5451'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/ali5451'
make  -C cs46xx modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/cs46xx'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/cs46xx'
make  -C emu10k1 modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/emu10k1'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/emu10k1'
make  -C korg1212 modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/korg1212'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/korg1212'
make  -C nm256 modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/nm256'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/nm256'
make  -C pdplus modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/pdplus'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/pdplus'
make  -C rme9652 modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/rme9652'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/rme9652'
make  -C trident modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/trident'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/trident'
make  -C ymfpci modules_install
make[2]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/ymfpci'
mkdir -p /lib/modules/2.4.17ddm-mercury-1/kernel/sound/pci/ymfpci
cp snd-ymfpci.o /lib/modules/2.4.17ddm-mercury-1/kernel/sound/pci/ymfpci
make[2]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci/ymfpci'
make[1]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/pci'
make[1]: Entering directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/usb'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/local/src/Alsa/alsa-driver-0.9.0rc2/usb'
/sbin/depmod -a 2.4.17ddm-mercury-1 -F /lib/modules/2.4.17ddm-mercury-1/build/System.map

> > Is it possible that this is due to the version of modutils that I
> > have, and not related to the kernel at all?  This is with Red Hat's
> > modutils-2.4.13-0.7.1 rpm...
>  
> this looks fine.

Ok...

One thing I note from the output above:  I see you're creating a new
System.map file, and leaving it in the modules directory.  Red Hat
(at least) seems to expect this to be in /boot, where the kernel
images are kept.  Should I move the file there?  Is this likely to
make a difference?  I believe that file just contains symbol offsets,
doesn't it?

> > > what happens if you run "depmod -ae"?
> > 
> > Well, I set the command line for configure to place them in the misc
> > directory, so everything is working now.  There is no output from
> > depmod -ae, but presumably there would be had I allowed the drivers to
> > be installed in the kernel/sound directories?
>  
> kernel/sound directory must be checked by modprobe.
> all normal kernel modules are installed under kernel directory.

Well, it isn't.  :)  Or perhaps it is, but if so it's not looking in
the subdirectories under that where the modules actually live.
However, as I said before, installing the modules in the misc
directory makes them work fine.


- -- 
Derek Martin               ddm@pizzashack.org    
- ---------------------------------------------
I prefer mail encrypted with PGP/GPG!
GnuPG Key ID: 0x81CFE75D
Retrieve my public key at http://pgp.mit.edu
Learn more about it at http://www.gnupg.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9GhQKdjdlQoHP510RAuGiAJ0RtvFaEGWPAe3tFIJ8Y5E337BiNQCgiIMC
SUntK3VDLp27c9WJRJJ3x14=
=6g94
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by: Jabber Inc.
Don't miss the IM event of the season | Special offer for OSDN members! 
JabberConf 2002, Aug. 20-22, Keystone, CO http://www.jabberconf.com/osdn
