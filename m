From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: Re: [PATCH] azt3328 fatal deadlock fix (very rare,
	though)
Date: Tue, 27 Jun 2006 13:28:23 +0200
Message-ID: <20060627112823.GA30790@rhlx01.fht-esslingen.de>
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

Doh, this may have been caused by my semi-broken AU8820 sharing the same
IRQ as the azt3328...
Note that I'm not quite sure whether it's the hardware or ALSA AU8820 driver
which is broken (the driver is still quite incomplete), but since the seller
said that he suspected the AU8820 card to be broken, I now have every reason
to believe that this was true.
(my AU8830 in the same machine works 100% correctly, not only "sometimes")

Sorry for the noise! (let's just hope it was noise and not a real driver bug)

Hmm, or is my driver broken on IRQ sharing? Will investigate a bit more...

Andreas

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
