From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [BUG] alsa-lib leaves sound device open for child
 processes
Date: Sat, 8 Feb 2003 20:53:14 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302082051580.1141-100000@pnote.perex-int.cz>
References: <20030208204557.5f8de78f.sebastian_kapfer@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030208204557.5f8de78f.sebastian_kapfer@web.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sebastian Kapfer <sebastian_kapfer@web.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "rankincj@yahoo.com" <rankincj@yahoo.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 8 Feb 2003, Sebastian Kapfer wrote:

> On Sat, 8 Feb 2003 12:50:01 +0100 (CET)
> Jaroslav Kysela <perex@suse.cz> wrote:
> 
> > > All of the remaining applications should be
> > > considering what will happen to their resources on
> > > exec(), and I see no reason why careless programmers
> > > should have a few of their bugs swept under the rug
> > > for them.
> > 
> > I fully agree here.
> 
> Can anyone comment on exactly how an alsa-lib client app should make
> sure that exec'd processes don't inherit file handles? I can't find a
> way to know the FD number which alsa-lib uses. snd_pcm_file_descriptor
> is gone. What replaced it?

The applications should use snd_pcm_close() function (or related one 
snd_*_close()). Note that more complex plugins can use more file 
descriptors so the application is not able to enumerate them.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
