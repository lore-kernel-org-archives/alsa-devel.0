From: Georgi Georgiev <chutz@gg3.net>
Subject: Re: Re: Broken AC3 on EMU10K1 since July 2-nd
Date: Tue, 28 Sep 2004 14:12:51 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040928051251.GB9175@lion.gg3.net>
References: <20040927160314.GA16100@lion.gg3.net> <20040927162024.GA5768@lion.gg3.net> <s5hmzzb1o59.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hmzzb1o59.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

maillog: 27/09/2004-21:56:50(+0200): Takashi Iwai types
> At Tue, 28 Sep 2004 01:20:24 +0900,
> Georgi Georgiev wrote:
> > 
> > maillog: 28/09/2004-01:03:14(+0900): Georgi Georgiev types
> > > I checked out the CVS in my kernel source tree, and after playing with
> > > different dates:
> > > 
> > > cvs up -D "1  Jul 2004" -- sound plays OK
> > > cvs up -D "2  Jul 2004" -- sound skips heavily
> > 
> > I did some more checking:
> > 
> > cvs up -dP -D "1 Jul 2004 18:0:0" -- OK
> > cvs up -dP -D "1 Jul 2004 19:0:0" -- BAD
> > 
> > Still, I cannot understand the changes made to emu10k1, so I don't know
> > what the problem might be. I hope someone finds the fix.
> 
> Are you using the latest alsa-lib, too?

Well, it is the latest *stable* version -- 1.0.6.

-- 
*)   Georgi Georgiev   *)  Amy: Aw, he looks like a little insane      *)
(*    chutz@gg3.net    (* drunken angel.                               (*
*)  +81(90)6266-1163   *)                                              *)


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
