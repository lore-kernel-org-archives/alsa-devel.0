From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Subject: Re: es1938 - patch trying to improve capture hw
	pointer	reads
Date: Fri, 25 Jan 2008 17:07:27 +0100
Message-ID: <20080125160727.GF9123@lemon.iwr.uni-heidelberg.de>
References: <20080123003512.GA6828@lemon.iwr.uni-heidelberg.de>
	<s5hr6g74f8d.wl%tiwai@suse.de>
	<20080124152102.GE8290@lemon.iwr.uni-heidelberg.de>
	<s5hwspz2pwd.wl%tiwai@suse.de>
	<20080125002514.GA9015@lemon.iwr.uni-heidelberg.de>
	<s5h3asm2nib.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de
	[129.206.210.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 753131038CB
	for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2008 17:07:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h3asm2nib.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 25, 2008 at 11:44:12AM +0100, Takashi Iwai wrote:
> > > Then a question arises - why DMAADDR isn't used as the primary source
> > > at all?  Is it less stable than DMACOUNT in some cases?
> > 
> > I don't know and the current implementation contains only a "don't ask why - AB"
> > comment.
> > 
> > To reiterate: My proposed patch is about minimising the chance that a
> > wrong hw pointer value is given back due to garbage read from the chip. If
> > you are interested, I can send you debugging output which shows
> > that both DMAADDR and DMACOUNT are read out as bogus values
> > from time to time - one or the another, or both. I tried some
> > status flags on the chip, but alway found cases where it's
> > not clear if and which one of the two is correct.
> 
> Yeah, it would be helpful to understand the problem more correctly.

Will put together some of the log files next week.
Up to what size could/should  I cc to the list without upsetting people ?
I guess compressing them will yield only a few KBytes.

> > So reading both of them and comparing them seems to be the
> > best way for me to detect that there has been a readout error.
> > Which one to give back is without having more information
> > about the chip internals in my opinion only a matter of taste.
> > The proposed patch allows a jitter of one byte there, but that
> > could be set to zero at the cost of a slightly increased
> > failure rate.
> 
> BTW, don't get me wrong - I'm not against your proposal.  The back-off
> is a safe option, as already mentioned.

Good to know.

> > Just to make that clear to me: If the irq handler calls
> > snd_pcm_period_elapsed() in your example, the alsa middle layer will treat
> > the first 256 byte as written completely by the chip even
> > if the pointer callback will say there is still one frame not stored
> > for that period.
> > (I see the name of the function answering my qestion, but are
> > curious how the middle layer implementation behaves in this situation)
> 
> Yes.  The return value from the pointer callback is the most trusted
> information the PCM core receives.
> 
> > That can play a role with the handling of the off-by-one bug of the chip.
> 
> What is the problem exactly?

If I interpreted my tests output correctly, the last byte of a period
is written by the DMA engine after the interrupt occurs. So the
hw pointer probably has to be decremented by one and is then
pointing to the last frame (Or even that before: Has the hw pointer to point
at the frame which is written at the moment or the one which is
guaranteed to be written completely by the hardware ?)

Have a nice weekend,
Hermann


-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
