From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: backwards incompatible ALSA api change?
Date: Wed, 11 Sep 2002 11:42:04 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209111842.LAA19003@cmn29.stanford.edu>
References: <Pine.LNX.4.44.0209101958360.29024-100000@cmn37.stanford.edu>
	<s5hy9a9oro6.wl@alsa2.suse.de>
	<200209111759.KAA18952@cmn29.stanford.edu>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200209111759.KAA18952@cmn29.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: nando@ccrma.Stanford.EDU, perex@suse.cz, Jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> If the API change is desirable and _has_ to be made there
> should be an announcement (to alsa-dev which is where I assume
> is where all developers of alsa applications are subscribed
> to), and the library version should be increased so that an
> application compiled with the old version will not just
> segfault when run under the new drivers...

Correct me if I'm wrong but bumping the library version number
from .so.2 to .so.3 with api changes would also enable orderly
migration _if_ the interface between the library and the
drivers does not change. I would be able to have both a .so.2
and a .so.3 in the system, so that old, not yet converted
programs would work fine and new programs using the .so.3
library would also work. Eventually, when all programs are
updated and recompiled to use .so.3, the .so.2 could be just
erased and would be history. Am I dreaming?

-- Fernando

PS: I realize migration between versions is probably not a
priority at all for most people, but it is for me...


-------------------------------------------------------
In remembrance
www.osdn.com/911/
