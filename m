From: "Jack O'Quin" <joq@io.com>
Subject: Re: snd_ prefix for module options
Date: 09 Oct 2002 12:31:18 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87smzfmsd5.fsf@sulphur.joq.us>
References: <s5hfzvh2fid.wl@alsa2.suse.de>
	<DAELIEGDPLDDCIJPAICBEENLCDAA.annabellesgarden@yahoo.de>
	<s5hwuor29tv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwuor29tv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> <snip>  (proposal to remove snd_ prefix for each module option)

Takashi Iwai <tiwai@suse.de> writes:

> a convenient method is to check and rewrite /etc/modules.conf
> automatically when alsa-driver is installed.  (btw, in the case of
> debian, do we need to check another path, too?)

Yes.  

I'm a recent (happy) convert to Debian 3.0, Woody.  I'm working at
learning it, but not an expert.  I recently studied the packaging of
ALSA, which is quite complex, and I believe this is correct...

Debian installs pieces of modules.conf in the /etc/modutils
subdirectory on a per-package basis.  The install scripts run
"update-modules" to combine these files into /etc/modules.conf.  In
the case of ALSA, /etc/modutils/alsa is actually a symlink to either
/etc/alsa/modutils/0.9 or /etc/alsa/modutils/0.5 since both ALSA
versions are supported and the contents are incompatible.

Debian has a policy of handling user-editable configuration files
*very* carefully.  When installing an update, the package scripts are
expected to preserve user edits and somehow deal with any format
changes, too.  When a package is removed, the config files are left in
place so user changes will not be lost in case the package is
re-installed in the future.  To actually erase config files, one must
use the --purge option.  In general, every package is expected to be
capable of upgrading both its previous version and the one before
that.

These are far higher standards of compatibility than ALSA has so far
tried to achieve.  My impression is that the Debian maintainers have
been working very hard to deal with ALSA's perennial instability.

> i'm not sure whether it's good manner or not, though.

Best to leave this alone.  Anything else causes many people to hassle
with fixing something that's not broken in the first place.

Regards,
-- 
  Jack O'Quin
  Austin, Texas, USA


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
