From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dmix bugs. sounds very broken up.
Date: Tue, 2 Sep 2003 17:19:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309021716040.1769@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0309010807230.14319-100000@pnote.perex-int.cz>
 <3F53D15B.3090507@superbug.demon.co.uk> <Pine.LNX.4.53.0309021232410.29300@pnote.perex-int.cz>
 <3F54992B.1060800@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F54992B.1060800@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2 Sep 2003, James Courtier-Dutton wrote:

> Jaroslav Kysela wrote:
> >
> > (2)
> >
> > Problem with uninitialized pcm->info value is fixed in CVS.
> >
> >
> It seems to be impossible to get anything from the sf.net anonymous cvs.
> Just try to follow the "CVS Web interface" link from the alsa web page.
> I never appears. That is the same interface the anonymouse cvs user
> would use.

Yes, I hate the SF latest policy to update anonymous CVS trees once per
day. But CVS Web interface works for me. I am seriously thinking to move
the master CVS repository back to the ALSA server after next software
update.

> I use kernel 2.6test4.
> Would it be possible to create a nightly patch file, that would compare
> the alsa cvs, with the kernel 2.6test4, and create a patch file for us
> to download. It would be ideal if the patch was a progressive patch, in
> that with each change to the cvs, it just adds a new section of the
> patch file, instead of creating a unified patch of all the cvs checkins.
> In this way, if I used the first patch, and then the cvs gets updated, I
> could download the latest patch, do a diff between it and the previous
> one I applied, and be left with just the new patches I needed.

Please, subscribe our cvslog mailing list. There are full patches up to
20000 lines now (plus commit logs).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
