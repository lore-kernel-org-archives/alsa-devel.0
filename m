From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: buffer/period constraint
Date: Wed, 21 Jul 2004 03:52:38 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1090396358.901.52.camel@mindpipe>
References: <Pine.HPX.4.33n.0407210857590.27864-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0407210857590.27864-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: fmoraes@nc.rr.com, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-07-21 at 03:05, Clemens Ladisch wrote:
> fmoraes@nc.rr.com wrote:
> > [...]
> > I've seen some cases where the buffer size is 1 or 2 frames bigger
> > than n*period_size,
> 
> The hardware must generate interrupts at period boundaries.  In these
> cases, the interrupts would happen at different positions in the
> buffer, over time.
> 
> > so I am not sure how the driver is supposed to handle that.
> 
> The driver mustn't allow this unless the hardware can manage it.
> 
> > Second, is there an easy way to find the current position of the
> > DMA being used?
> 
> In the good ol' times of the ISA bus, the DMA controller knew the
> current position.  On the PCI bus, the DMA is controlled by the card
> itself, so the card should have a register for the current position.
> If there isn't such a register, you have to count interrupts (and hope
> that none are lost).
> 

Look at snd_pcm_update_hw_ptr_interrupt() in
alsa-kernel/core/pcm_lib.c.  This gets called by
snd_pcm_period_elapsed(), which gets called by your interrupt handler. 
If you are trying to reverse engineer the allowed period sizes, this is
a good place to start - do something that you think should set the
period to N and then check the hw_ptr value in that function against
what you think it should be.

If you have to count interrupts, it is pretty easy to figure out whether
you are missing some.  It does happen, a lot.  I hacked the emu10k1
driver to do this, the code is pretty ugly but it does the trick.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
