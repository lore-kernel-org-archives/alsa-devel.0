From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: The ALSA Situation
Date: Wed, 10 Nov 2004 11:09:47 -0500
Message-ID: <1100102987.3137.20.camel@krustophenia.net>
References: <200411100150.iAA1okCE029069@localhost.localdomain>
	 <001e01c4c6ce$77672eb0$0a00000a@eugenia>
	 <Pine.LNX.4.58.0411101152290.9089@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411101152290.9089@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Eugenia Loli-Queru <eloli@eugenia.co.uk>, Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net, torvalds@osdl.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-11-10 at 11:57 +0100, Jaroslav Kysela wrote:
> On Tue, 9 Nov 2004, Eugenia Loli-Queru wrote:
> 
> > 1. again with the mixing thing, browsers will stall and not load a flash 
> > webpage if another app uses the sound device. It's tragic to see firefox not 
> > loading www.macromedia.com for example, just because xmms is playing a 
> > song...
> 
> You can disable this feature - look for nonblock_open in
> Documentation/sound/alsa/OSS-Emulation.txt . We follow posix by default,
> the original OSS API does not.
> 

I would expect that most distros want to ship with this disabled.
Please look into how your distro sets this by default and file a bug
report.

<rant>

Really, it is up to the distros to ship with a sane ALSA config.  The
ALSA team provides a powerful low level API to access sound hardware; it
is the job of the distros to decide on the most useful config for their
their users and ship as such.  You cannot expect the ALSA guys to
anticipate the needs of every class of user.  This is like expecting the
kernel devs to come up with a one-size-fits-all Kconfig - the whole
reason it is configurable is because different users need different
defaults.  There is such a thing, look at the default Red Hat or Debian
kernel config, but that configuration was arrived at by combining
feedback from countless users.  They are different because those distros
have different user bases.  My point is, you can't know it a priori.

For example the muted-by-default issue - if you don't like this then
complain to Red Hat or whoever is shipping with the mixer controls
muted.  For a desktop oriented, use-it-out-of-the-box distro this _is_ a
bug.  For many other applications (like pro audio) you WANT everything
muted by default - better to have to find the volume control than
destroy 100s of ppls hearing with a blast of noise through a PA.  It's
not reasonable to expect this to be solved at the ALSA level because
there is no magic default that works for everyone.

</rant>

Lee



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
