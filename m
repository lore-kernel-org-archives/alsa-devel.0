From: Ross Vandegrift <ross@willow.seitz.com>
Subject: Re: [PATCH] envy24control widget limits, version 2
Date: Thu, 5 Jun 2003 14:21:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030605182142.GA20438@willow.seitz.com>
References: <20030602024454.GB15874@willow.seitz.com> <s5hhe76lzst.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hhe76lzst.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 04, 2003 at 03:47:46PM +0200, Takashi Iwai wrote:
> i committed your patch to cvs (with some fixes of comiplation warnings
> and addition to manpage).  please check whether it's ok for you.

I just tried to checkout the code from cvs on a Debian woody box (cvs
version 1.11.5) and a Slackware 8.1 box (cvs version 1.11.2) and both
give the error:

ross@turalyon:/usr/src$ cvs -d ':pserver:anonymous@cvs.alsa-project.org:/cvsroot/alsa' login
Logging in to :pserver:anonymous@cvs.alsa-project.org:2401/cvsroot/alsa
CVS password:
cvs [login aborted]: end of file from server (consult above messages if any)

I'm not logged in, and so checkout doesn't work.  I tried the web
interface, but it doesn't seem to have my changes.

At any rate, I'm sure your checkin was fine - but it does seem that CVS
is having some issues...


-- 
Ross Vandegrift
ross@willow.seitz.com

A Pope has a Water Cannon.                               It is a Water Cannon.
He fires Holy-Water from it.                        It is a Holy-Water Cannon.
He Blesses it.                                 It is a Holy Holy-Water Cannon.
He Blesses the Hell out of it.          It is a Wholly Holy Holy-Water Cannon.
He has it pierced.                It is a Holey Wholly Holy Holy-Water Cannon.
He makes it official.       It is a Canon Holey Wholly Holy Holy-Water Cannon.
Batman and Robin arrive.                                       He shoots them.


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
