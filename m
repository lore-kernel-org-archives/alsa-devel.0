From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: fatal oops in current CVS confirmed
Date: Mon, 10 Mar 2003 01:06:59 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303100102190.5732-100000@pnote.perex-int.cz>
References: <200303071353.h27DrnJ01476@linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200303071353.h27DrnJ01476@linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 7 Mar 2003, Paul Davis wrote:

>    in the trident case
> 	* smp-related code 

Fixed. The problem was in Takashi's Scatter-Gather DMA update. The 
driver package 0.9.0rc8d should fix this problem.

>    in the wavefront case
> 	* code within the module

I cannot fix above problem, until I know the place of this bug. The best 
way is to determine this problem is commenting/uncommenting of the 
initialization code.

> i would strongly advise against releasing 0.9.0 final when its so
> trivial to crash a system with it. and incidentally, its precisely
> this kind of waste of 3 days that explains why i haven't updated from
> ALSA CVS in a long time :)

Because it appears that all your reported problems are "local" (driver 
specific), I don't think that it's a showstoper for the final release.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
