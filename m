From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Removal of /proc/asound ?
Date: Mon, 19 May 2003 12:21:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305191215490.21997-100000@pnote.perex-int.cz>
References: <20030519200301.1c3276f7.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030519200301.1c3276f7.erikd-alsa@mega-nerd.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 19 May 2003, Erik de Castro Lopo wrote:

> On Mon, 19 May 2003 11:46:55 +0200
> Takashi Iwai <tiwai@suse.de> wrote:
> 
> > > If it was a request from the 2.5 kernel people, why is this change impacting
> > > people running 2.4 kernels.
> > 
> > i also thought of this.  in theory, it's not difficult to implement
> > the compatible layer.
> > 
> > meanwhile, it's not too hard to create device files, too.  once if you
> > made them, then the system works like before.
> > 
> > frankly saying, i'm not sure which is the really better way.
> > if there are MANY demands on the old way, we'll consider to implement
> > it back again (but not appearing in the 2.5 kernel tree :)
> 
> There are times when backward compatibility is important and other times
> when it is not.

Binary compatibility is important, but it's not our case. You can use
older libraries with newer driver without any problems. The change is only
administrative, if you create static device files, everything is ok again.
Simply, new version of driver requires to create new files, but nothing 
else. It can be viewed as "evolution", too. The system call semantics IS 
NOT CHANGED, thus binary compatibility is kept, of course.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
