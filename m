From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: backwards incompatible ALSA api change?
Date: Wed, 11 Sep 2002 22:25:53 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209112221180.607-100000@pnote.perex-int.cz>
References: <200209111842.LAA19003@cmn29.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200209111842.LAA19003@cmn29.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Takashi Iwai <tiwai@suse.de>, "Jackit-devel@lists.sourceforge.net" <Jackit-devel@lists.sourceforge.net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 11 Sep 2002, Fernando Pablo Lopez-Lezcano wrote:

> > If the API change is desirable and _has_ to be made there
> > should be an announcement (to alsa-dev which is where I assume
> > is where all developers of alsa applications are subscribed
> > to), and the library version should be increased so that an
> > application compiled with the old version will not just
> > segfault when run under the new drivers...
> 
> Correct me if I'm wrong but bumping the library version number
> from .so.2 to .so.3 with api changes would also enable orderly
> migration _if_ the interface between the library and the
> drivers does not change. I would be able to have both a .so.2
> and a .so.3 in the system, so that old, not yet converted
> programs would work fine and new programs using the .so.3
> library would also work. Eventually, when all programs are
> updated and recompiled to use .so.3, the .so.2 could be just
> erased and would be history. Am I dreaming?

Nope. I'll do that (it's already on my HDD), but I'll have to change more 
snd_pcm_hw_params_* functions to unify the access and let recognize
the error code to applications.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
In remembrance
www.osdn.com/911/
