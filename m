From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: Re: [PATCH] azt3328 fatal deadlock fix (very rare,
	though)
Date: Wed, 21 Jun 2006 13:48:20 +0200
Message-ID: <20060621114820.GA11212@rhlx01.fht-esslingen.de>
References: <20060621083234.GA25022@rhlx01.fht-esslingen.de>
	<s5hk67aer2z.wl%tiwai@suse.de>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hk67aer2z.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, Jun 21, 2006 at 12:33:08PM +0200, Takashi Iwai wrote:
> At Wed, 21 Jun 2006 10:32:34 +0200,
> Andreas Mohr wrote:
> > 
> > Hi all,
> > 
> > while listening to my 315th MP3 file played on this soundcard I had the
> > extreme mispleasure of experiencing a complete lockup of my box right
> > during shutdown of this file's playback, not even Magic SysRq worked
> > (characteristic sign of spinlock conflicts).
> > 
> > I determined that it must have been the combination of not doing the _irqsave()
> > variant in the playback trigger function and then having another IRQ occur
> > (which tried to spinlock again, against the active lock in the playback trigger
> > function). By always doing _irqsave() everywhere we also don't need separate
> > locking in the IRQ handler any more (managed to reduce CPU load, too).
> 
> I don't understand this.  The local irq is already disabled in either
> snd_pcm_lib_write1() or snd_pcm_lib_read1() that are the sole callers
> of snd_pcm_start().  Ditto for snd_pcm_stop().

Argh, then I'm not sure what's wrong.
Facts:
- my fix is a best guess about the crash cause, not true knowledge
- there's no way to prove that my fix corrected the problem (very rare bug)
- the system locked up *directly* during closing of this MP3 file's playback
  (this would strongly point towards trigger functions)
- Magic SysRq didn't work -> locking problem. Hmm, or does an IRQ storm also
  block SysRq processing totally? If so, then that may have been the problem here
  (maybe there's an interrupt reason which I'm not properly ACKing yet)

Andreas
