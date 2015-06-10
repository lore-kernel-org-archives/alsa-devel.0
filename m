From: Mihai =?UTF-8?B?RG9uyJt1?= <mihai.dontu@gmail.com>
Subject: Re: Audio crackles with 4.1-rc1
Date: Thu, 11 Jun 2015 01:12:36 +0300
Message-ID: <20150611011236.53bcd1fd@mdontu-l>
References: <s5hpp6ov1wv.wl-tiwai@suse.de>
	<s5ha8xsuxe3.wl-tiwai@suse.de>
	<20150429112859.GY10148@earth.li>
	<s5h4mnzgne6.wl-tiwai@suse.de>
	<20150430150131.GA10148@earth.li>
	<s5hd22l7dgo.wl-tiwai@suse.de>
	<20150502150513.GF10148@earth.li>
	<s5hk2w514aj.wl-tiwai@suse.de>
	<20150519161911.GD28070@earth.li>
	<s5hr3qctryf.wl-tiwai@suse.de>
	<20150519215310.GF28070@earth.li>
	<s5hd21vu9k7.wl-tiwai@suse.de>
	<20150610131755.0b906783@mdontu-l.dsd.bitdefender.biz>
	<s5h4mmfooaq.wl-tiwai@suse.de>
	<20150610134135.327e2bdc@mdontu-l.dsd.bitdefender.biz>
	<s5hvbevn8gh.wl-tiwai@suse.de>
	<20150610144551.4578ee99@mdontu-l.dsd.bitdefender.biz>
	<s5hpp53n3o9.wl-tiwai@suse.de>
	<s5hlhfrn2w9.wl-tiwai@suse.de>
	<20150610192202.0e987fd0@mdontu-l.dsd.bitdefender.biz>
	<s5hr3pjleac.wl-tiwai@suse.de>
	<20150610194303.3b82609d@mdontu-l.dsd.bitdefender.biz>
	<s5hy4jr8ltm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hy4jr8ltm.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan McDowell <noodles@earth.li>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 10 Jun 2015 20:23:01 +0200 Takashi Iwai wrote:
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Reduce click noise at power up
>=20
> Some machines suffer from click noises at power up with the recent
> kernels, and this seems triggered at the power transition and the
> immediate verb executions.  As a workaround, put a short delay (10ms)
> right after the D0 transition.
>=20
> There are a few places that have the same kind of delays, especially
> in the resume path.  I guess they can be removed (or reduced) after
> this patch.  But, since the delay is relatively small, let's do it
> later as a cleanup.
>=20
> Reported-by: Mihai Don=C8=9Bu <mihai.dontu@gmail.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/hda_codec.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> index b7782212dd64..38f5509ee52f 100644
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -3077,6 +3077,9 @@ static unsigned int hda_set_power_state(struct =
hda_codec *codec,
>  			break;
>  	}
> =20
> +	if (power_state =3D=3D AC_PWRST_D0)
> +		msleep(10);
> +
>  	return state;
>  }
> =20

I take back my previous observations. I was at work and did not have
access to headphones (one of those days). Now I'm at home, it's 1 AM,
very quiet, and I notice the following:

 * on speakers: the click reproduces but with _very_ low amplitude;
   msleep(100) is unnoticeable, but msleep(10) is, barely;
 * on headphones: the moment I plug them I hear a loud static sound
   (like an old, untuned AM radio). If I play something, the static
   disappears. If I pause, the static returns after ~15s.

--=20
Mihai Don=C8=9Bu
