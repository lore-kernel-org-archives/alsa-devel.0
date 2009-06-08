From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and
	add	Left_J support
Date: Mon, 8 Jun 2009 17:38:35 +0100
Message-ID: <20090608163835.GA14026@rakim.wolfsonmicro.main>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090606201225.GA1029@sirena.org.uk>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<20090608124045.GE7858@sirena.org.uk>
	<74d0deb30906080858m7dc52cfaxfbb6366c529fc0e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D8039103877
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 18:38:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <74d0deb30906080858m7dc52cfaxfbb6366c529fc0e2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 08, 2009 at 05:58:54PM +0200, pHilipp Zabel wrote:
> On Mon, Jun 8, 2009 at 2:40 PM, Mark

> > OOI which MUA are you using? =A0I've noticed several people with this v=
ery
> > odd word wrapping the past day.

> This mail was sent with the Google Mail web interface.

Ah.  Why am I not surprised. :/

> > I'm inclined to go with sample here since it seems harder for the
> > machine drivers to get wrong but I've not really thought it through yet?

> I thought sample width is determined by the snd_pcm_hw_params. But
> maybe I'm mixing up alsa sample width vs sample width on the wire?

Essentially what we're doing here is providing a mechanism to specify a
separate wire format.

> I'm leaning towards set_frame_width because that's directly what I
> want to do: override pxa_ssp_hw_params' standard decision to use
> 32-bit frames for S16_LE stereo and set 16-bit frames instead.

Hrm.  Now I remember what you're doing - you're trying to essentially
send your stereo stream as mono data due to your hardware either having
a flip flop or an entertainingly non-standard CODEC which needs a frame
sync per sample rather than per frame.

> > OTOH I don't really see much difference between the two cases - it's
> > just an extra couple of parameters on the end of the call.

> Technically there isn't. It just seems much more obvious to me to
> write something like:
>     /* nonstandard: 16-bit frames, even for 2x 16-bit stereo */
>     if (params_format(params) =3D=3D ..._S16_LE)
>         set_frame_size(16);

Thing is, I'd expect this would be just as likely to cause the CPU to
discard every other sample since it doesn't have enough clocks to clock
out a stereo sample in the frame.

It occurs to me that this is something that it might be better to work
around this with a user space plugin which rewrites the sample formats
on the way down to the driver so that it claims the stream is configured
as mono even if it's stereo :/  Not sure how practical that is or if
there's a sensible way to do that in kernel space.

> in the machine driver instead of:
>     /* nonstandard: 16-bit frames, even for 2x 16-bit stereo
>      * pxa_ssp_hw_params will check for TTSA=3D=3D1
>      * and then set the frame size accordingly
>      */
>     set_tdm_slot(1,1);
> especially as I don't really need network mode at all.

Same issue with "it's a surprise it works" applies here.

That TDM configuration ought to disable network mode if the driver
doesn't need it.
