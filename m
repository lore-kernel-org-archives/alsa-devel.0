From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
	Left_J support
Date: Mon, 8 Jun 2009 17:58:54 +0200
Message-ID: <74d0deb30906080858m7dc52cfaxfbb6366c529fc0e2@mail.gmail.com>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090606201225.GA1029@sirena.org.uk>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<20090608124045.GE7858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DFD810384F
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 17:58:56 +0200 (CEST)
Received: by ewy23 with SMTP id 23so4329476ewy.32
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 08:58:55 -0700 (PDT)
In-Reply-To: <20090608124045.GE7858@sirena.org.uk>
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

On Mon, Jun 8, 2009 at 2:40 PM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 08, 2009 at 02:12:03PM +0200, pHilipp Zabel wrote:
>> On Sat, Jun 6, 2009 at 10:12 PM, Mark
>> Brown<broonie@opensource.wolfsonmicro.com> wrote:
>
> OOI which MUA are you using? =A0I've noticed several people with this very
> odd word wrapping the past day.

This mail was sent with the Google Mail web interface.

>> > of in tree users it'd cause little disruption. ?A set_sample_width()
>> > operation could also be added.
>
>> set_sample_width or set_frame_width?
>
> I'm inclined to go with sample here since it seems harder for the
> machine drivers to get wrong but I've not really thought it through yet?

I thought sample width is determined by the snd_pcm_hw_params. But
maybe I'm mixing up alsa sample width vs sample width on the wire?
I'm leaning towards set_frame_width because that's directly what I
want to do: override pxa_ssp_hw_params' standard decision to use
32-bit frames for S16_LE stereo and set 16-bit frames instead.

>> I'd prefer a separate operation over a parameter to set_tdm_slot because
>> in my setup I just need to force the (SSP) frame width to 16 bits.
>> Enabling network mode and calling set_tdm_slot(..,1,1) wouldn't be
>> necessary at all, then.
>
> OTOH I don't really see much difference between the two cases - it's
> just an extra couple of parameters on the end of the call.

Technically there isn't. It just seems much more obvious to me to
write something like:
    /* nonstandard: 16-bit frames, even for 2x 16-bit stereo */
    if (params_format(params) =3D=3D ..._S16_LE)
        set_frame_size(16);
in the machine driver instead of:
    /* nonstandard: 16-bit frames, even for 2x 16-bit stereo
     * pxa_ssp_hw_params will check for TTSA=3D=3D1
     * and then set the frame size accordingly
     */
    set_tdm_slot(1,1);
especially as I don't really need network mode at all.

>=A0That said,
> it'd be much nicer if the driver were able to just do the right thing
> for DSP mode unless explicitly configured, there's not the issue you
> have with I2S where extra clocks would change the offset of the second
> channel within a stereo frame so it's much easier.

Yes. Only for strange nonstandard setups like a flip-flop in the LRCLK
line even DSP mode has to be told that we need two frame clock pulses
per stereo sample.

regards
Philipp
