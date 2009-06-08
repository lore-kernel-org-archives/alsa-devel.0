From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
	Left_J support
Date: Mon, 8 Jun 2009 14:12:03 +0200
Message-ID: <74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090606201225.GA1029@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 7395A2435E
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 14:12:04 +0200 (CEST)
Received: by ewy23 with SMTP id 23so4116287ewy.32
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 05:12:03 -0700 (PDT)
In-Reply-To: <20090606201225.GA1029@sirena.org.uk>
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

On Sat, Jun 6, 2009 at 10:12 PM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jun 03, 2009 at 08:33:42PM +0800, Eric Miao wrote:
>
>> +/* frame size definitions for I2S and Left_J formats - default is
>> + * 32fs, other possibilities are 48fs, 64fs and 96fs
>> + */
>> +#define PXA_SSP_FRM_32FS =A0 =A0 (0 << 16)
>> +#define PXA_SSP_FRM_48FS =A0 =A0 (1 << 16)
>> +#define PXA_SSP_FRM_64FS =A0 =A0 (2 << 16)
>> +#define PXA_SSP_FRM_96FS =A0 =A0 (3 << 16)
>> +#define PXA_SSP_FRM_WIDTH(x) (((((x) >> 16) & 0x3) + 2) << 4)
>> +
>
> I still haven't checked this on Zylonite but I wanted to mention these
> new DAI format bits just now - as previously discussed I'm not
> enthusiastic about this.

Agreed. Also, if I had to use this to configure magician with DSP_A
(right now it says I2S and LEFT_J only, but why limit it to that?),
I'd need an additional PXA_SSP_FRM_16FS.

>=A0As well as the previous issues I raised with
> this approach I also meant to mention is that the use of a bitfield will
> inevitably restrict what can be expressed, causing real problems for
> some systems. =A0For example, the WM9081 supports systems using up to 3
> stereo TDM slots and up to 32 bit samples so could be used in a system
> which needs a 192fs bit clock.
>
> If we did decide to adopt this approach then these defines should be in
> the ASoC headers rather than private to this driver - apart from
> anything else, there's every chance that additions to the standard bits
> could end up colliding with this.
>
> I'm still not sure what the best way to handle this is due to the
> interaction with TDM mode. =A0The fact that TDM mode really wants to
> always explicitly specify the frame width in order to allow the sample
> size in each slot to vary suggests that one option would be to add a
> sample width parameter to set_tdm_slot() - given the very small number
> of in tree users it'd cause little disruption. =A0A set_sample_width()
> operation could also be added.

set_sample_width or set_frame_width?
I'd prefer a separate operation over a parameter to set_tdm_slot because
in my setup I just need to force the (SSP) frame width to 16 bits.
Enabling network mode and calling set_tdm_slot(..,1,1) wouldn't be
necessary at all, then.

regards
Philipp
