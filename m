From: Andrei Boros <andrei@srr.ro>
Subject: Re: alsa-utils cvscompile
Date: Thu, 25 Sep 2003 06:00:10 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F725A3A.11C24B19@srr.ro>
References: <3F6EBD21.385BE9EA@srr.ro>
		<s5hd6drr2m4.wl@alsa2.suse.de>
		<3F717F41.8A481DF8@srr.ro> <s5hllsel1db.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> hmm, check whether depcomp file at the top directory is empty.
> if so, try to remove depcomp.
> it must come from automake, but the combination of the old automake
> and the new libtool can be problematic.

removed an empty depcomp and problem solved. Thanks.


> anyway, the best way would be to upgrade (or even downgrade) the all
> GNU auto-tools to the sane combination.  i'm not sure which version
> combinations are correct, though.
> 
> upgrading them to the latest version would be fine for ALSA, but it
> might not work on others occasionally.  sigh.

I don't know, I just upgraded severla weeks ago the compiler, gnu auto*,
libtool, make to the versions required to compile glibc-2.2.5, so they
are all pretty new.
It is true, however, that I downloaded the cvs tree few months ago, and
only did updates from then on, attempting to make it work.

-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
