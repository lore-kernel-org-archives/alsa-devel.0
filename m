From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: New snd-hda warning spew
Date: Thu, 17 Mar 2016 16:25:10 +0200
Message-ID: <20160317142510.GY4329@intel.com>
References: <20160315160207.GY4329@intel.com> <s5hio0nejv3.wl-tiwai@suse.de>
 <20160316140420.GB4329@intel.com> <s5hoaad8brx.wl-tiwai@suse.de>
 <s5hk2l18a7t.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id B3C1F260789
 for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2016 15:25:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hk2l18a7t.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 17, 2016 at 03:12:22PM +0100, Takashi Iwai wrote:
> On Thu, 17 Mar 2016 14:38:42 +0100,
> Takashi Iwai wrote:
> > =

> > On Wed, 16 Mar 2016 15:04:20 +0100,
> > Ville Syrj=E4l=E4 wrote:
> > > =

> > > But now I got a lockdep spew when I enabled the HDMI video output [1]
> > > =

> > > And sure enough mplayer got stuck in the kernel when I tried to use
> > > the HDMI audio device [2]
> > > =

> > > [1]
> > > [ 1939.476458] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > [ 1939.476460] [ INFO: possible recursive locking detected ]
> > > [ 1939.476463] 4.5.0-vga+ #13 Not tainted
> > > [ 1939.476464] ---------------------------------------------
> > > [ 1939.476466] kworker/2:2/1016 is trying to acquire lock:
> > > [ 1939.476469]  (&spec->pcm_lock){+.+...}, at: [<ffffffffa020b868>] h=
dmi_present_sense+0x38/0x300 [snd_hda_codec_hdmi]
> > > [ 1939.476480] =

> > >                but task is already holding lock:
> > > [ 1939.476482]  (&spec->pcm_lock){+.+...}, at: [<ffffffffa020b868>] h=
dmi_present_sense+0x38/0x300 [snd_hda_codec_hdmi]
> > > [ 1939.476489] =

> > >                other info that might help us debug this:
> > > [ 1939.476491]  Possible unsafe locking scenario:
> > > =

> > > [ 1939.476493]        CPU0
> > > [ 1939.476495]        ----
> > > [ 1939.476496]   lock(&spec->pcm_lock);
> > > [ 1939.476499]   lock(&spec->pcm_lock);
> > > [ 1939.476502] =

> > >                 *** DEADLOCK ***
> > > =

> > > [ 1939.476504]  May be due to missing lock nesting notation
> > =

> > Unfortunately, no this is a real deadlock.
> > Let's see below: hdmi_present_sense() gets called twice because the
> > function issues a verb that does self-resume and it invokes
> > hdmi_present_sense() again in runtime resume.
> > =

> > > [ 1939.476622]  [<ffffffffa020b868>] hdmi_present_sense+0x38/0x300 [s=
nd_hda_codec_hdmi]
> > ....
> > > [ 1939.476642]  [<ffffffffa020bd6d>] generic_hdmi_resume+0x4d/0x60 [s=
nd_hda_codec_hdmi]
> > ....
> > > [ 1939.476690]  [<ffffffffa017de62>] snd_hdac_power_up_pm+0x52/0x60 [=
snd_hda_core]
> > > [ 1939.476694]  [<ffffffffa020b9c3>] hdmi_present_sense+0x193/0x300 [=
snd_hda_codec_hdmi]
> > > [ 1939.476699]  [<ffffffffa020bba0>] check_presence_and_report+0x70/0=
x90 [snd_hda_codec_hdmi]
> > > [ 1939.476703]  [<ffffffffa020bcba>] hdmi_unsol_event+0x9a/0xb0 [snd_=
hda_codec_hdmi]
> > =

> > This wasn't seen until now because the code path using i915 audio
> > notifier doesn't need to power up the codec.  Now we switched to the
> > old method for old chips, and the bug is revealed.  It's good to have
> > caught it now, because basically this hits all non-Intel chips.
> =

> ... and the fix patch is attached below.
> =

> =

> Takashi
> =

> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Fix mutex deadlock at HDMI/DP hotplug
> =

> The recent change in HD-audio HDMI/DP codec driver for allowing the
> dynamic PCM binding introduced a new spec->pcm_mutex.  One of the
> protected area by this mutex is hdmi_present_sense().  As reported by
> Intel CI tests, unfortunately, the new mutex causes a deadlock when
> the hotplug/unplug is triggered during the codec is in runtime
> suspend.  The buggy code path is like the following:
> =

>   hdmi_unsol_event() -> ...
>     -> hdmi_present_sense()
> =3D=3D>     ** here taking pcm_mutex
>       -> hdmi_present_sense_via_verbs()
>         -> snd_hda_power_up_pm() -> ... (runtime resume calls)
>           -> generic_hdmi_resume()
>             -> hdmi_present_sense()
> =3D=3D>           ** here taking pcm_mutex again!
> =

> As we can see here, the problem is that the mutex is taken before
> snd_hda_power_up_pm() call that triggers the runtime resume.  That is,
> the obvious solution is to move the power up/down call outside the
> mutex; it is exactly what this patch provides.
> =

> The patch also clarifies why this bug wasn't caught beforehand.  We
> used to have the i915 audio component for hotplug for all Intel chips,
> and in that code path, there is no power up required but the
> information is taken directly from the graphics side.  However, we
> recently switched back to the old method for some old Intel chips due
> to regressions, and now the deadlock issue is surfaced.
> =

> Fixes: a76056f2e57e ('ALSA: hda - hdmi dynamically bind PCM to pin when m=
onitor hotplug')
> Reported-by: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Yep, my ILK seems happy with this. No deadlocks, and HDMI audio works.

Tested-by: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>

> ---
>  sound/pci/hda/patch_hdmi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> =

> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index cde9746cda8e..49ee4e55dd16 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1405,7 +1405,6 @@ static bool hdmi_present_sense_via_verbs(struct hdm=
i_spec_per_pin *per_pin,
>  	bool ret;
>  	bool do_repoll =3D false;
>  =

> -	snd_hda_power_up_pm(codec);
>  	present =3D snd_hda_pin_sense(codec, pin_nid);
>  =

>  	mutex_lock(&per_pin->lock);
> @@ -1444,7 +1443,6 @@ static bool hdmi_present_sense_via_verbs(struct hdm=
i_spec_per_pin *per_pin,
>  		jack->block_report =3D !ret;
>  =

>  	mutex_unlock(&per_pin->lock);
> -	snd_hda_power_down_pm(codec);
>  	return ret;
>  }
>  =

> @@ -1522,6 +1520,10 @@ static bool hdmi_present_sense(struct hdmi_spec_pe=
r_pin *per_pin, int repoll)
>  	struct hdmi_spec *spec =3D codec->spec;
>  	int ret;
>  =

> +	/* no temporary power up/down needed for component notifier */
> +	if (!codec_has_acomp(codec))
> +		snd_hda_power_up_pm(codec);
> +
>  	mutex_lock(&spec->pcm_lock);
>  	if (codec_has_acomp(codec)) {
>  		sync_eld_via_acomp(codec, per_pin);
> @@ -1531,6 +1533,9 @@ static bool hdmi_present_sense(struct hdmi_spec_per=
_pin *per_pin, int repoll)
>  	}
>  	mutex_unlock(&spec->pcm_lock);
>  =

> +	if (!codec_has_acomp(codec))
> +		snd_hda_power_down_pm(codec);
> +
>  	return ret;
>  }
>  =

> -- =

> 2.7.3

-- =

Ville Syrj=E4l=E4
Intel OTC
