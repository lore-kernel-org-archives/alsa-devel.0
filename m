From: "Derek D. Martin" <ddm@pizzashack.org>
Subject: Re: alsa configure/install bug
Date: Wed, 26 Jun 2002 15:58:17 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020626155817.B1295@pizzashack.org>
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
> kernel/sound directory must be checked by modprobe.
> all normal kernel modules are installed under kernel directory.

Hi Takashi,

It occured to me that you're probably going to ask me what my
modules.conf file looks like, so I'll save you the trouble:

  # ALSA Sound stuff
  alias char-major-116 snd
  options snd snd_major=116 snd_cards_limit=1
  alias snd-card-0 snd-card-ymfpci
  options snd-card-ymfpci snd_index=0 snd_id="YMFPCI"
  
  alias char-major-14 soundcore
  alias sound-slot-0 snd-card-0
  post-install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -L >/dev/null 2>&1 || :
  pre-remove sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S >/dev/null 2>&1 || :
  alias sound-service-0-0 snd-mixer-oss
  alias sound-service-0-1 snd-seq-oss
  alias sound-service-0-3 snd-pcm-oss
  alias sound-service-0-12 snd-pcm-oss

Now, looking at this, and matching it up against the modules that
actually exist, I notice that the alias for snd-card-0 refers to a
module that doesn't appear to exist.  I suspect this is the culprate.
However, this is the exact same configuration that I'm using when the
modules are in the misc directory, and everything works fine.

Looking back at the documentation, I think I understand what happened.
The howto shows this in the modprobe section:

  # ALSA portion
  alias snd-card-0 snd-interwave
  alias snd-card-1 snd-card-es1370

I copied the form of the second entry, but that's not the name of the
module for the ymfpci chipset.  I've modified the alias, but I don't
actually have time to test it to see if that fixed the problem.  I
believe it will...

Gotta run.  Thanks for your help.

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

iD8DBQE9GhzZdjdlQoHP510RAkjlAKCrPcxJerxEHRhHZloUAse2MFI+4wCggHUs
IFXlX2+9RamhqjRwXXFUQU0=
=b9NM
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by: Jabber Inc.
Don't miss the IM event of the season | Special offer for OSDN members! 
JabberConf 2002, Aug. 20-22, Keystone, CO http://www.jabberconf.com/osdn
