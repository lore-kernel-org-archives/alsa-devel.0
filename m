From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: hdsp9652+alsamixer -> kernel panic
Date: Sat, 31 May 2003 13:30:56 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305311329200.28435-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0305311412450.856-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0305311412450.856-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 31 May 2003, Kai Vehmanen wrote:

> On Thu, 29 May 2003, Paul Davis wrote:
> 
> >>> ah. are you running on an SMP system with current ALSA CVS? if so, its
> >>> broken within the "core" of ALSA. you will need to back up to April
> >>Hmm, anyway to easily and reliably reproduce the bug?
> > run jack? :))
> 
> Well, I've done a lot of testing during the last few days (including 
> running jack :)), sometimes with both soundcards running at the same time, 
> and still no oopses (system uptime now 5days). So ALSA+SMP seems to work 
> fine at least on some systems.
> 
> Btw; kernel is 2.4.19 with ll-patches.

Thanks for this report. Also many thanks for Takashi's verification of 
new pcm link code (and broken spinlocks fixes).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
