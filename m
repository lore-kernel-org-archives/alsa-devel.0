From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: status pointer's problem with dmix.
Date: Sun, 21 Sep 2003 13:43:51 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309211342560.7787@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0309201305480.16509-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0309201305480.16509-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: AthlonRob <athlonrob@data.4t3.com>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 20 Sep 2003, Clemens Ladisch wrote:

> AthlonRob wrote:
> > On Wed, 2003-09-17 at 11:52, Takashi Iwai wrote:
> >
> > > is it through the rate plugin?
> > > there was a bug about rate plugin together with dmix, which was fixed
> > > recently on cvs.
> >
> > Is the 'rate' plugin == the 'plug' plugin?
>
> No. Yes.  ;-)  Well, the "plug" plugin uses the same code as the
> "rate" plugin when converting the sample rate.

More precisely, the plug plugin uses other (more elementary) plugins for
the automatic stream conversion, but you can use the rate plugin
separately as well.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
