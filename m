From: "Derek D. Martin" <ddm@pizzashack.org>
Subject: Re: alsa configure/install bug
Date: Tue, 25 Jun 2002 14:02:06 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020625140206.B13917@pizzashack.org>
References: <20020624143111.B1332@pizzashack.org> <s5hit477jta.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline; filename="msg.pgp"
In-Reply-To: <s5hit477jta.wl@alsa2.suse.de>
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

Hi Takashi, and thanks for replying.

At some point hitherto, Takashi Iwai hath spake thusly:
> > b) When modules are installed in the above directories, modprobe can't
> > find them.  Is this distribution specific?  Is there a way to
> > configure this behavior?  I'm running RH 7.1 on a Toshiba Satellite.
> > I'll also note that with a recent beta of the 0.9 code, modules were
> > installed in the misc directory.
> 
> iirc rh7.1 has already 2.4 kernel system, so it must be ok.

It shipped with 2.4.2 IIRC, though I've updated it to stock 2.4.17.

> most likely the configuration of alsa driver doesn't match with your
> current kernel config.

Not sure what you mean here...  I only have kernel sources for my
running 2.4.17 kernel, if that's what you mean.  So it's not possible
that they don't match, if that is what you mean...  And both configure
and make output indicate it's being compiled for the right kernel, in
the right location, aside from the fact that it's installing them in
kernel/sound, as opposed to misc.

> please elaborate your prolbem.  what says modprobe?

The problem is that if the alsa modules are not installed in
/lib/modules/<KVER>/misc, modprobe can't find them to load them.  Once
they are installed there, everything works fine.  This is as it was
with the 0.9.something beta something that I was using before this,
also...  meaning that when I installed the beta drivers previously,
they installed in the misc directory (with out me telling them to do
so specifically, as far as I can remember), and everything worked
fine.

Is it possible that this is due to the version of modutils that I
have, and not related to the kernel at all?  This is with Red Hat's
modutils-2.4.13-0.7.1 rpm...

> what happens if you run "depmod -ae"?

Well, I set the command line for configure to place them in the misc
directory, so everything is working now.  There is no output from
depmod -ae, but presumably there would be had I allowed the drivers to
be installed in the kernel/sound directories?

If you feel that it would be helpful, I could always blow away my
modules, and install them in the other location.


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

iD8DBQE9GLAedjdlQoHP510RAtaXAJ4kmSCmoy2SDtoaKMk+72QBPFoghwCgjLUe
4AJ0Hg9aGYnyIAO0fEwo0Lw=
=kKL+
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by: Jabber Inc.
Don't miss the IM event of the season | Special offer for OSDN members! 
JabConf 2002, Aug. 20-22, Keystone, CO http://www.jabberconf.com/osdn
