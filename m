From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: poll() and select()
Date: Thu, 16 Oct 2003 19:54:20 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310161950530.1221@pnote.perex-int.cz>
References: <20031013105324.637917b0.rpav@mephle.com> <s5h4qycup1q.wl@alsa2.suse.de>
 <20031014113031.7fde9794.rpav@mephle.com> <20031015010559.GA15113@dbz.icequake.net>
 <20031014194105.469f8da7.rpav@mephle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031014194105.469f8da7.rpav@mephle.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Pavlik <rpav@mephle.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 14 Oct 2003, Ryan Pavlik wrote:

> On Tue, 14 Oct 2003 20:06:00 -0500
> Ryan Underwood <nemesis-lists@icequake.net> wrote:
>
> > Silly question, but is 'npfd' the file descriptor you are polling + 1?
>
> I AM DUMB.
>
> I totally overlooked this.  Simple fix, and it works great.
> Thanks. :-)  You'd think I had never done this before.
>
> So the select() version works fine, with the bridge from the poll()
> file structure.  This should integrate with ruby just fine then.

Don't use select() if possible. You don't know which direction is required
for a file descriptor. You must use snd_seq_poll_descriptors_revents()
which mangles the used direction and reports the correct one to
the application (and yes, it might be an opposite or both
directions in real if we implementing some complex devices behind this
API).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
