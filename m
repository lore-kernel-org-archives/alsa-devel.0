From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [Jackit-devel] usx2y jack driver
Date: Sat, 25 Sep 2004 20:13:35 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096157614.3697.26.camel@krustophenia.net>
References: <200409222228.38243.annabellesgarden@yahoo.de>
	 <32827.192.168.1.5.1096065064.squirrel@192.168.1.5>
	 <1096078552.1407.1.camel@krustophenia.net>
	 <200409251555.59384.annabellesgarden@yahoo.de>
	 <32983.192.168.1.5.1096125029.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <32983.192.168.1.5.1096125029.squirrel@192.168.1.5>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Martin Langer <martin-langer@gmx.de>, Werner Schweer <ws@seh.de>, alsa-devel <alsa-devel@lists.sourceforge.net>, jackit-devel <jackit-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-09-25 at 11:10, Rui Nuno Capela wrote:
> Karsten Wiese wrote:
> > erm, but I'd rather make some sounds with this stuff before i dig into
> > that deeper. And there is still that ohci issue.
> >
> 
> FYI, on my laptop, that OHCI issue is still a serious showstopper. I am
> collecting some log/trace data to file and append on alsa's bugtracker
> (bug #0000425).

One other idea.  Do you have CONFIG_DEBUG_SPINLOCK_SLEEP enabled?  If
this problem is indeed related to the sleeping in PCM start/stop
callbacks, and you enable this option, then I believe you would get a
"Bad: scheduling while atomic" error in the syslog before the machine
hangs.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
