From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Control renaming for EMU10k1
Date: Sat, 26 Jun 2004 15:33:31 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1088278410.24275.48.camel@mindpipe>
References: <40DD8775.2@jfalk.easynet.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40DD8775.2@jfalk.easynet.de>
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

On Sat, 2004-06-26 at 10:25, Joachim Falk wrote:
> With AC97 Sigmatel 9708/11. The names for the AC97 controls from
> ac97_codec.c do not match how they are used on the Live.
> So I have done some Control renaming in the emumixer.c
> But the "AC97 Surround Playback control" is a stereo control
> but is used for the Live as control for Center and LFE.
> 
> So my question is how can i best rename this control to have two
> different names matching the functionality for the right and left
> channel of the stereo channel ?
> 
> Or is driver hacking here foolish and there exists a better mechanisme
> for this kind of stuff in userspace ?

This is definitely an issue to be solved in userspace.  Many
configurations do not use a center/LFE, and those that do may want to
use a different pair of outputs.  Other configurations will have a
full-range speaker (or a bass amp) connected to the LFE channel and will
want to use a crossover/lowpass filter.

The mixer for the EMU10K1 is actually an FX8010 DSP microcode program
that is currently hardcoded in the driver.  Eventually this will be
controlled by a userspace DSP patch loader/unloader.  Peter Zubaj has
written such a program, ld10k1 (http://ld10k1.sourceforge.net).  It is
"alpha-quality", but it can (for example) clear the DSP microcode and
recreate the mixer configuration hardcoded in the driver.  The more
people test it, the faster it will stabilize.

I highly recommend you try the (Windows) driver from the kX Project
(http://www.kxproject.com), or at least look at the screenshots and the
docs.  They also distribute an SDK, the header files are interesting
reading.  This should give you some idea of some of the amazing things 
this hardware is capable of and how far the ALSA driver has to go.  The
ALSA driver is not as advanced as the kX driver yet, but this is being
worked on.

> My longterm goal is to improve the mixer for SB Lives.

The best way you can help is to install ld10k1 and test it.  If you try
the kX drivers then you will see that a stable DSP patch loader is
required to do anything interesting with this card.  For the center/LFE
issue, rather than tweaking the hardcoded DSP mixer code in the driver,
this should let you make the changes to the 'mixer' DSP patch, then you
can just load it in place of the default mixer.  The kX drivers use a
patch called 'Surrounder' for this.

Finally, I do not speak for ALSA or the author of ld10k1, I just like to
hack the driver.  The above is just my opinion.

Lee



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
