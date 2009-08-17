From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 2/3] ASoC: pxa-ssp.c,
	Automatically set TDM when needed
Date: Mon, 17 Aug 2009 17:35:48 +0200
Message-ID: <20090817153548.GB19257@buzzloop.caiaq.de>
References: <1249570519-32622-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249570519-32622-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20090812181724.GZ19257@buzzloop.caiaq.de>
	<1250266661.18028.249.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AC7624780
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 17:35:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250266661.18028.249.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 14, 2009 at 01:17:41PM -0300, Daniel Ribeiro wrote:
> Em Qua, 2009-08-12 =E0s 20:17 +0200, Daniel Mack escreveu:
> > =

> > 	snd_soc_dai_set_tdm_slot(cpu_dai, 3, 3, 2, 16);
> > =

> > Which translates into "give me 2 slots with 16 bits each, and distribute
> > them over the timeline as a 0-1-0-1 pattern". Which is exactly what I
> > need, right?
> =

> No. in an ideal world, set_tdm_slot(3, 3, 2, 16) shoud give you 2x16
> bits slots, on a 1-1 timeline, and shouldn't be a valid network mode
> configuration, in this case, one should use a frame width of 32bits and
> _not_ use network mode.
> =

> 0-1-0-1 should be 4 slots, with slots 2 and 4 active, but I think that
> what you want is 1-0-1-0 =3D set_tdm_slot(5, 5, 4, 16). But... See below.

Maybe we should first decide which TDM mode _should_ be correct for the
mode I'm working on, and then amend the actual implementation? And
provide some documentation once the API is decided.

> > But unfortunately, the code didn't make the SSP port do that. I ended up
> > having a asynchronous clock and the data somewhere where I wouldn't have
> > expected them: http://caiaq.de/download/tmp/1.png
> =

> I think that the source of the problem is that we can't assert SFRM past
> the end of the first slot, and DMYSTOP changes the slot_width on the
> wire.

Yes, I've seen this, too.

(Just a sidenote: one way to debug that engine is to interrupt the
execution using Marvell's XDB tool and then manually modify the register
set while the PXA keeps on playing the same DMA buffer over and over
again. You'll get ~1/2 sec of audio in a loop - enough to judge whether
it's playing at the correct speed.)

> Consider that PXA is _slave_ of SFRM: (SFRMDIR=3D1)
> =

> * SFRMWDTH is ignored.
> * Only one edge (set by SFRMP) is considered.
> =

> =

> And when PXA is _master_ of SFRM: (SFRMDIR=3D0)

As Mark pointed out already, this implementation details should be
hidden behind the API. Users really shouldn't need to care.

> * SFRMWDTH is needed for I2S.
> * SFRMWDTH can't be asserted past the end of DMYSTOP.
> * DMYSTOP changes the slot width, as it generates extra cycles after the
> last bit of data.
> * DMYSTOP only changes the _active_ slots width. (this is what causes
> async SFRM).
> * DMYSTOP is restricted to 0-3 on PXA2XX
> * DMYSTOP must be cleared in network mode, or when FSRT is set.

Well, for this last point: that's not actually true. The configuration
I'm currently working with _does_ have the MOD bit set which indicates
a 'network' mode (whatever the PXA's implementation does with that
particular information) and DMYSTOP _does_ matter. Which is a
contradiction to the specs, yes, but that's what it's like.

> We want to write 2x16bit samples with 1-0-1-0 pattern for I2S, so we
> can:
> =

> * set_tdm_slot(5, 5, 4, 16) if pxa is slave of SFRM.

Wouldn't 1-0-1-0 rather be 0xa?

> * use SFRMWDTH(16) | DMYSTOP(16) if pxa is master of SFRM. (pxa3 only)
> * use DMYSTOP(16) if pxa is slave of SFRM. (pxa3 only)

> =

> > I did some minor modifications to the patches 2/3 and 3/3 which made it
> > work for me eventually - find them inline.
> > =

> > Not sure whether I got the theory about the API right, and of course I
> > didn't test on any other hardware than the one I have.
> > =

> > =

> =

> > > -	cpu_dai->dma_data =3D ssp_get_dma_params(ssp,
> > > -			((chn =3D=3D 2) && (ttsa !=3D 1)) || (width =3D=3D 32),
> > > +	cpu_dai->dma_data =3D ssp_get_dma_params(ssp, slot_width > 16,
> > >  			substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK);
> > =

> > The condition for the width4 parameter needs to be
> > (slot_width * slots) > 16 for me. With that parameter set to 0, audio
> > plays at half speed on my system.
> =

> Consider that you have real network mode, and you are using 2 slots of
> 16 bit mono audio. You want to ignore 16bit for each 16bit of data. ie,
> only one channel active. You really don't want 32bit DMA in this case.

I can just say that in case the DMA material is _not_ 32bit, audio will
play at half speed. So the mode I'm using seems to need the double amout
of PCM data. For whatever reason.

> I agree that this should be (slot_width * number_of_active_slots) > 16
> tough.

Ok. And that won't break your use case?

> > > +			sspsp |=3D SSPSP_DMYSTOP(
> > > +					(slot_width * slots) / 2 - width - 1);
> > > +			sspsp |=3D SSPSP_SFRMWDTH((slot_width * slots) / 2);
> > =

> > These two calculations are wrong my case. What works here is
> > =

> > 	sspsp |=3D SSPSP_DMYSTOP(
> > 			(slot_width * slots * chn) / 2 - width - 1);
> > 	sspsp |=3D SSPSP_SFRMWDTH((slot_width * slots * chn) / 2);
> > =

> > ... which is another multiplication by factor 2. But I'm not sure if I
> > got the wrong variable with value 2 :)
> =

> DMYSTOP itself should be accounted for slot_width, but this will only
> work if all slots are active otherwise you will get asynchronous SFRM.
> Something like:

[...]

Care to send modified patches? I'd be lucky to test them.

> This should be able to deal with I2S when pxa is slave, on both pxa2xx
> and pxa3xx, with set_tdm_slot(5, 5, 4, 16).
> =

> Or when pxa is master, on pxa3xx only, with set_tdm_slot(3, 3, 2, 16).

Again - shouldn't we care for a consistent calling convention here and
handle the special cases in the implementation rather than feeding
nebulous integer arguments to it, which vary depending on the clocking
directions?

> This still violates the "DMYSTOP must be clear on network mode" rule,
> but as all slots are active its not really network mode. And it seems to
> work for you, so... ;)

Yeah, that makes no sense at all. I think we should ignore that comment.
It seems to be simply wrong, or we're not in network mode afterall, even
though we selected it. I don't know.

Thanks,
Daniel
