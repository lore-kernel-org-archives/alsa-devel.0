From: "Derek D. Martin" <ddm@pizzashack.org>
Subject: Re: alsa configure/install bug
Date: Wed, 26 Jun 2002 15:46:16 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020626154616.A1295@pizzashack.org>
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

Ok, I moved my misc directory aside, and reinstalled them in the
kernel/sound directories.  Here's some more info:


At some point hitherto, Takashi Iwai hath spake thusly:
> > > what happens if you run "depmod -ae"?
> > 
> > Well, I set the command line for configure to place them in the misc
> > directory, so everything is working now.  There is no output from
> > depmod -ae, but presumably there would be had I allowed the drivers to
> > be installed in the kernel/sound directories?

It turns out there's still no output to this command.

> kernel/sound directory must be checked by modprobe.
> all normal kernel modules are installed under kernel directory.

It seems like it's checking, partially.  After starting my X session,
gnome complains that it's unable to open /dev/mixer.  I looked at the
output of lsmod, and the only sound-related modules that got loaded
were these:

  $ lsmod
  Module                  Size  Used by    Tainted: P  
  snd-mixer-oss           8800   0 (autoclean) (unused)
  snd                    24200   0 (autoclean) [snd-mixer-oss]
  soundcore               3588   0 (autoclean) [snd]

Note the 'P' flag in the Tainted header.  I don't know what this
means, but it wasn't there when the modules were located in misc.  The
man page for lsmod is remarkably unhelpful in determining the meaning
of the 'P' that's there.  I have a vague idea that this has to do with
GPL issues, but beyond that no clue...

Also, in my logs, I see these messages:

  Jun 26 15:30:49 mercury modprobe: modprobe: Can't locate module char-major-81
  Jun 26 15:30:52 mercury modprobe: modprobe: Can't locate module sound-slot-0

Apparently, it's not loading any of the drivers in the
kernel/sound/pci directory...  Oddly, if I manually modprobe
snd-ymfpci, it loads, along with the rest of the modules.

All I can say is, WTF?

  Module                  Size  Used by    Tainted: P  
  snd-ymfpci             41444   0  (unused)
  snd-pcm                48768   0  [snd-ymfpci]
  snd-opl3-lib            5312   0  [snd-ymfpci]
  snd-timer               9760   0  [snd-pcm snd-opl3-lib]
  snd-hwdep               3456   0  [snd-opl3-lib]
  snd-mpu401-uart         2800   0  [snd-ymfpci]
  snd-rawmidi            12352   0  [snd-mpu401-uart]
  snd-seq-device          3840   0  [snd-opl3-lib snd-rawmidi]
  snd-ac97-codec         23620   0  [snd-ymfpci]
  snd-mixer-oss           8800   0  (autoclean) (unused)
  snd                    24200   0  (autoclean) [snd-ymfpci snd-pcm snd-opl3-lib s
  nd-timer snd-hwdep snd-mpu401-uart snd-rawmidi snd-seq-device snd-ac97-codec snd
  -mixer-oss]
  soundcore               3588   4  (autoclean) [snd]



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

iD8DBQE9GhoIdjdlQoHP510RAovgAJ97OLEPtEiCvABX6b3vzI2KUTbunACeLDaL
8tuWo7cttdSmb7o7bqkBD40=
=+Pp9
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by: Jabber Inc.
Don't miss the IM event of the season | Special offer for OSDN members! 
JabberConf 2002, Aug. 20-22, Keystone, CO http://www.jabberconf.com/osdn
