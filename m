From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1: difference between _fx8010_ and _efx_
Date: Fri, 25 Jun 2004 17:16:58 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1088198217.23832.10.camel@mindpipe>
References: <1088106324.1591.18.camel@mindpipe>
	 <s5h7jtvfx7x.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jtvfx7x.wl@alsa2.suse.de>
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

On Fri, 2004-06-25 at 11:56, Takashi Iwai wrote:
> At Thu, 24 Jun 2004 15:45:24 -0400,
> Lee Revell wrote:
> > 
> > Hey,
> > 
> > I have been looking at the emu10k1 driver source and am confused about 
> > the use of _fx8010_ and _efx_ in variable names.  The FX8010 is the 
> > DSP used for hardware "efx" in the EMU10K1.  Can someone clarify the 
> > distinction?
> 
> No difference.  They are named differently just because they _were_
> different PCM streams before merged.
> 

Ok.  I have a patch to make the naming consistent (replacing efx with
fx8010).  This is pretty straightforward, there is only one conflict in
emuproc.c which is easily resolved by renaming the function which reads
the DSP microcode to snd_emu10k1_fx8010_read_code.

I tested this and everythng seems to work.  However it looks like there
is some other development going on in this driver so I have to
regenerate it.

Lee



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
