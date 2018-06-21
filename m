From: Lukas Wunner <lukas@wunner.de>
Subject: Re: HDA controller w/o CLKSTOP and EPSS support
Date: Thu, 21 Jun 2018 11:18:59 +0200
Message-ID: <20180621091859.GA6957@wunner.de>
References: <20180620093452.GA25280@wunner.de> <s5h36xhojcn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net
 [176.9.242.62]) by alsa0.perex.cz (Postfix) with ESMTP id F33BD26760F
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 11:19:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h36xhojcn.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Henning Kuehn <prg@cooco.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 20, 2018 at 12:14:32PM +0200, Takashi Iwai wrote:
> On Wed, 20 Jun 2018 11:34:52 +0200, Lukas Wunner wrote:
> > Henning K=FChn reports that due to my commit 07f4f97d7b4b ("vga_switche=
roo:
> > Use device link for HDA controller"), the discrete GPU on his hybrid
> > graphics laptop no longer runtime suspends.
> > =

> > The root cause is that the single codec of the GPU's HDA controller
> > doesn't support CLKSTOP and EPSS.  (The "Supported Power States" are
> > 0x00000009, i.e. CLKSTOP and EPSS bits are not set, cf. page 209 of
> > the HDA spec.)
> > =

> > This means that in hda_codec_runtime_suspend() we do not call
> > snd_hdac_codec_link_down():
> > =

> > 	if (codec_has_clkstop(codec) && codec_has_epss(codec) &&
> > 	    (state & AC_PWRST_CLK_STOP_OK))
> > 		snd_hdac_codec_link_down(&codec->core);
> > =

> > If snd_hdac_codec_link_down() isn't called, the bit in the codec_powered
> > bitmask isn't cleared, which in turn prevents the controller from going
> > to PCI_D3hot in azx_runtime_idle():
> > =

> > 	if (!power_save_controller || !azx_has_pm_runtime(chip) ||
> > 	    azx_bus(chip)->codec_powered || !chip->running)
> > 		return -EBUSY;
> > =

> > The codec does runtime suspend to D3, but the PS-ClkStopOk bit in the
> > response to "Get Power State" is not set. (Response is 0x00000033,
> > cf. page 151 of the HD Audio spec.)  Hence the check above
> > "state & AC_PWRST_CLK_STOP_OK" also results in "false".
> =

> Supposing that it's AMD GPU, does a fix like below work?
[snip]
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -3741,6 +3741,11 @@ static int patch_atihdmi(struct hda_codec *codec)
>  =

>  	spec->chmap.channels_max =3D max(spec->chmap.channels_max, 8u);
>  =

> +	/* AMD GPUs have neither EPSS nor CLKSTOP bits, hence preventing
> +	 * the link-down as is.  Tell the core to allow it.
> +	 */
> +	codec->link_down_at_suspend =3D 1;
> +
>  	return 0;
>  }

In hda_intel.c:azx_probe_continue(), we currently do this:

	if (use_vga_switcheroo(hda))
		list_for_each_codec(codec, &chip->bus)
			codec->auto_runtime_pm =3D 1;

An alternative to setting the flag in patch_atihdmi() would be to
set it here.

One small nit, the code comment you're adding above is in network
subsystem style ("/*" isn't on a line by itself).

Otherwise this is
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Reported-and-tested-by: Henning K=FChn <prg@cooco.de>
Fixes: 07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=3D106957

Feel free to just copy/paste the problem description from my original
e-mail to the commit message so that you don't have additional work
there.

Thanks so much for the fast response with a working patch!

Lukas
