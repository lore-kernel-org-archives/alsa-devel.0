From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 effect processor
Date: Sun, 26 Sep 2004 22:16:23 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096251382.7203.74.camel@krustophenia.net>
References: <Pine.LNX.4.58.0409262037130.2760@pat.dumaisnet.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0409262037130.2760@pat.dumaisnet.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa@dumaisnet.ca
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2004-09-26 at 20:46, Patrick Dumais wrote:
> Hi,
> 
> Could any one point me out where I could find information on how to
> control the integrated effect processor on the Live card with an alsa
> programming interface? and possibily how to make my own modules? I know
> there is an assembler for that, I found a couple of links. I just want to
> know if someone has a specific link to recommend.
> 
> But I am mostly looking for specification of how to use emu10k1 effect
> within my alsa application
> 

Check out Peter Zubaj's ld10k1, http://ld10k1.sf.net.  It now has a GUI,
qlo10k1, and a C library interface to the emu10k1 DSP.  It is still
under development and is not as advanced as the kX DSP, yet.

The other emu10k1 utilities are for the OSS driver, ld10k1 is the one
you should use.  They might have some features that aren't yet in
ld10k1, this project could always use more developers.  Currently the
Windows emu10k1 hacker community is much bigger than Linux, due to the
kX drivers being better than the ALSA driver.  I am one of the people
working on this.

Lee





-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
