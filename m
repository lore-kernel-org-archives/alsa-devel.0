From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-devel] Re: ALSA / emu10k1 / SPDIF / surround?
Date: Mon, 29 Aug 2005 15:55:14 -0400
Message-ID: <1125345314.4598.58.camel@mindpipe>
References: <1124755115.5763.3.camel@hostmaster.org>
	 <1125166820.22285.68.camel@hostmaster.org>
	 <1125168446.25011.68.camel@mindpipe>
	 <1125173150.22285.103.camel@hostmaster.org>
	 <1125174445.25011.76.camel@mindpipe>
	 <1125177706.22285.144.camel@hostmaster.org>
	 <1125178767.25011.86.camel@mindpipe>
	 <1125181627.22285.155.camel@hostmaster.org>
	 <1125183623.25011.102.camel@mindpipe>
	 <1125195487.2684.8.camel@hostmaster.org>
	 <1125196132.25011.111.camel@mindpipe>  <s5hbr3h3xxy.wl%tiwai@suse.de>
	 <1125325907.4598.23.camel@mindpipe>
	 <1125342246.21560.2.camel@hostmaster.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <1125342246.21560.2.camel@hostmaster.org>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>, ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-08-29 at 21:04 +0200, Thomas Zehetbauer wrote:
> On Mon, 2005-08-29 at 10:31 -0400, Lee Revell wrote:
> > As I understand the emu10k1 driver, after initializing the AC97, it's
> > supposed to rename the "Wave" control to "PCM".  Why is this user
> > getting both?
> 
> No, they are definitely different controls. From what I have seen "Wave"
> appears to be handled by the EMU10K1 and attenuates the PCM data stream
> for both digital (SPDIF) and analog output. "PCM" appears to control the
> DAC of the Sigmatel STAC9708T AC97 codec.

OK, thanks.  As Takashi-san pointed out I was confused by the difference
between the Audigy and Live! mixers.

I still think these are poor choices for mixer control names.  The kX
driver solves this problem nicely by separating the AC97 mixer controls
from the ones implemented with EMU10K1 DSP microcode.  I guess to have
this option on Linux, we'd need some way for driver to report which
controls are part of the AC97 codec.

Lee

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
