From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: Broken AC3 on EMU10K1 since July 2-nd
Date: Tue, 28 Sep 2004 12:24:01 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096388641.2067.7.camel@krustophenia.net>
References: <20040927160314.GA16100@lion.gg3.net>
	 <20040927162024.GA5768@lion.gg3.net>
	 <1096311039.7203.96.camel@krustophenia.net>
	 <20040928051034.GA9175@lion.gg3.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040928051034.GA9175@lion.gg3.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Georgi Georgiev <chutz@gg3.net>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-09-28 at 01:10, Georgi Georgiev wrote:
> maillog: 27/09/2004-14:50:40(-0400): Lee Revell types
> > On Mon, 2004-09-27 at 12:20, Georgi Georgiev wrote:
> > > maillog: 28/09/2004-01:03:14(+0900): Georgi Georgiev types
> > > > I checked out the CVS in my kernel source tree, and after playing with
> > > > different dates:
> > > > 
> > > > cvs up -D "1  Jul 2004" -- sound plays OK
> > > > cvs up -D "2  Jul 2004" -- sound skips heavily
> > > 
> > > I did some more checking:
> > > 
> > > cvs up -dP -D "1 Jul 2004 18:0:0" -- OK
> > > cvs up -dP -D "1 Jul 2004 19:0:0" -- BAD
> > > 
> > > Still, I cannot understand the changes made to emu10k1, so I don't know
> > > what the problem might be. I hope someone finds the fix.
> > 
> > Can you please send me the diff via private mail?  I might be able to
> > figure it out.
> 
> It's pretty big, but there it is:
> 

OK, the problem is almost certainly the introduction of pcm_indirect for
the FX8010 PCM.  Takashi-san, do you agree?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
