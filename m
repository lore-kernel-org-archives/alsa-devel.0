From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 multichannel playback design (was Re: [PATCH] emu10k1:
 add interval timer support)
Date: Mon, 27 Sep 2004 10:35:40 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096295739.7203.81.camel@krustophenia.net>
References: <Pine.LNX.4.58.0409241546570.2289@pnote.perex-int.cz>
	 <200409241453.i8OErtVR029650@localhost.localdomain>
	 <s5hk6uj3dko.wl@alsa2.suse.de> <1096059735.11589.45.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409261335020.1744@pnote.perex-int.cz>
	 <1096245611.7203.66.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409270848040.1733@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0409270848040.1733@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-09-27 at 02:48, Jaroslav Kysela wrote:
> On Sun, 26 Sep 2004, Lee Revell wrote:
> 
> > Yes, I agree.  Right now I have the first 16 voices reserved for the
> > multichannel device.  For the default playback device voice allocation
> > starts at 16. 
> 
> I would prefer dynamic voice allocations.
> 

So would I.  This setup is just for testing.  It will allocate voices
dynamically when it's finished.

Lee 



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
