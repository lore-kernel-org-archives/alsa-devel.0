From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: AudioScience driver - need help
Date: Fri, 2 May 2003 11:47:28 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305021145200.4749-100000@pnote.perex-int.cz>
References: <E19BQTB-0004mA-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19BQTB-0004mA-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Eliot Blennerhassett <bigblen@icqmail.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 1 May 2003, Paul Davis wrote:

> >I have got the job of making an ALSA driver, or at
> >least causing it to be made.
> >How do I go about getting help from "The ALSA
> >development team" (TADT) to write this driver?
> >
> >Is TADT just the members of this list, or a more
> >defined group of people working (more or less) full
> >time on the project?  I.e. who do I talk to?
> 
> mostly this list. at this time, only jaroslav and takashi work "full
> time" on ALSA (paid by SuSE), but there are several other people who
> can help with specific issues and questions.
> 
> the common path is to find a driver for similar device, and use it as
> a template. takashi has also written some basic information on the
> "skeleton" of a driver.
> 
> >The proposed Licence is based on the Zlib one.
> >http://www.gzip.org/zlib/zlib_license.html

It's kind of BSD licence, isn't?

> i don't believe this will work. although linus allows non-GPL'ed
> modules, he doesn't allow non-GPL'ed code into the kernel, and ALSA is
> now part of the 2.5/2.6 kernel. in addition, non-GPL'ed modules cannot
> access certain kernel symbols.

Yes, it may cause problems while integration the drivers to the kernel
tree. If it is possible, the licence might be dual (BSD/GPL or ?/GPL
etc...).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
