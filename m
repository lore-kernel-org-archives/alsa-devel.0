From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
	Left_J support
Date: Mon, 8 Jun 2009 19:18:16 +0200
Message-ID: <74d0deb30906081018q903c68fuffc6c60d94ebd064@mail.gmail.com>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090606201225.GA1029@sirena.org.uk>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<20090608124045.GE7858@sirena.org.uk>
	<74d0deb30906080858m7dc52cfaxfbb6366c529fc0e2@mail.gmail.com>
	<20090608163835.GA14026@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id F12C22451E
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 19:18:16 +0200 (CEST)
Received: by ewy23 with SMTP id 23so4385982ewy.32
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 10:18:16 -0700 (PDT)
In-Reply-To: <20090608163835.GA14026@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 8, 2009 at 6:38 PM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 08, 2009 at 05:58:54PM +0200, pHilipp Zabel wrote:
>> On Mon, Jun 8, 2009 at 2:40 PM, Mark
>
>> > OOI which MUA are you using? =A0I've noticed several people with this =
very
>> > odd word wrapping the past day.
>
>> This mail was sent with the Google Mail web interface.
>
> Ah. =A0Why am I not surprised. :/
>
>> > I'm inclined to go with sample here since it seems harder for the
>> > machine drivers to get wrong but I've not really thought it through ye=
t?
>
>> I thought sample width is determined by the snd_pcm_hw_params. But
>> maybe I'm mixing up alsa sample width vs sample width on the wire?
>
> Essentially what we're doing here is providing a mechanism to specify a
> separate wire format.
>
>> I'm leaning towards set_frame_width because that's directly what I
>> want to do: override pxa_ssp_hw_params' standard decision to use
>> 32-bit frames for S16_LE stereo and set 16-bit frames instead.
>
> Hrm. =A0Now I remember what you're doing - you're trying to essentially
> send your stereo stream as mono data due to your hardware either having
> a flip flop [...]

Exactly.

>> > OTOH I don't really see much difference between the two cases - it's
>> > just an extra couple of parameters on the end of the call.
>
>> Technically there isn't. It just seems much more obvious to me to
>> write something like:
>> =A0 =A0 /* nonstandard: 16-bit frames, even for 2x 16-bit stereo */
>> =A0 =A0 if (params_format(params) =3D=3D ..._S16_LE)
>> =A0 =A0 =A0 =A0 set_frame_size(16);
>
> Thing is, I'd expect this would be just as likely to cause the CPU to
> discard every other sample since it doesn't have enough clocks to clock
> out a stereo sample in the frame.

Ah right, and it would. That's why I set up DMA to only transfer 16
bits in this case. It's the reason for the existance of this snippet
in pxa-ssp:

        /* Network mode with one active slot (ttsa =3D=3D 1) can be used
         * to force 16-bit frame width on the wire (for S16_LE), even
         * with two channels. Use 16-bit DMA transfers for this case.
         */
        if (((chn =3D=3D 2) && (ttsa !=3D 1)) || (width =3D=3D 32))
                dma +=3D 2; /* 32-bit DMA offset is 2, 16-bit is 0 */

Which makes me wonder, whether it wouldn't generally be more accurate
to calculate the DMA transfer size as ssp_framewidth *
number_of_active_slots. Decreasing the DMA transfer size instead of
throwing away half the data (whether it is due to misconfiguration or
due to a strange special case like mine) should be a sane default?

> It occurs to me that this is something that it might be better to work
> around this with a user space plugin which rewrites the sample formats
> on the way down to the driver so that it claims the stream is configured
> as mono even if it's stereo :/ =A0Not sure how practical that is or if
> there's a sensible way to do that in kernel space.

Please, don't do this to me :)
As it works the way it is now, I don't see how moving this to
userspace improves things (except that you'd get rid of the two code
lines quoted above).

>> in the machine driver instead of:
>> =A0 =A0 /* nonstandard: 16-bit frames, even for 2x 16-bit stereo
>> =A0 =A0 =A0* pxa_ssp_hw_params will check for TTSA=3D=3D1
>> =A0 =A0 =A0* and then set the frame size accordingly
>> =A0 =A0 =A0*/
>> =A0 =A0 set_tdm_slot(1,1);
>> especially as I don't really need network mode at all.
>
> Same issue with "it's a surprise it works" applies here.

See above, reducing the DMA transfer size works as expected.

> That TDM configuration ought to disable network mode if the driver
> doesn't need it.

Ok.

regards
Philipp
