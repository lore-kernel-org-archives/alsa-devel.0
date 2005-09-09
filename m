From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Re: hda-intel/ALC260: crackly playback and DC offset on recording
Date: Fri, 9 Sep 2005 09:38:09 +0930 (CST)
Message-ID: <200509090008.j89089cm025068@auster.physics.adelaide.edu.au>
References: <s5hbr36v8d5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbr36v8d5.wl%tiwai@suse.de> from "Takashi Iwai" at Sep 06, 2005 11:44:06 AM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi

> > Oops, it looks like I did the diff around the wrong way by accident - sorry
> > for the confusion.  What I mean is that the "+1" should be removed.  If the
> > "+1" was added in 1.0.10rc1 then I guess that means that it should be
> > reverted.  As mentioned below though, without the "+1" aplay output is clean
> > but not everything is fixed, so this might not be the root cause of the
> > problem.
> 
> It was necessary on my test system, but this might be the problem.
> 
> Anyway, I added the check of DMA position in the latest CVS code
> yesterday.  Please give a shot with the latest CVS version.

I did this overnight.  The CVS snapshot was taken on 7 Sept 2005 at around
1600 local time (UT+0930).  I tried it both with and without the
position_fixed module parameter.

Without the position_fixed module parameter, playback via aplay was crackly.
This is new - aplay playback under 1.0.10rc1 without the position_fixed
parameter was fine.  Playback via wavplay (OSS interface) was however *much*
worse than it used to be.  Whereas under 1.0.10rc1 it would simply be
crackly, under the CVS snapshot large chunks of audio were being skipped.  I
didn't have a change to quantify it, but it seemed to me that perhaps every
second block of data was being skipped.

Next I retried with the position_fixed=1 parameter.  Both aplay (native alsa)
and wavplay (oss emulation) produced clean signal in this case, so the
position_fixed=1 has not changed in the CVS snapshot compared to 1.0.10rc1.

Regards
  jonathan


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
