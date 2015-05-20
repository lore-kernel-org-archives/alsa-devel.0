From: Jonathan McDowell <noodles@earth.li>
Subject: Re: Audio crackles with 4.1-rc1
Date: Wed, 20 May 2015 21:02:35 +0100
Message-ID: <20150520200235.GN28070@earth.li>
References: <20150429112859.GY10148@earth.li>
 <s5h4mnzgne6.wl-tiwai@suse.de>
 <20150430150131.GA10148@earth.li>
 <s5hd22l7dgo.wl-tiwai@suse.de>
 <20150502150513.GF10148@earth.li>
 <s5hk2w514aj.wl-tiwai@suse.de>
 <20150519161911.GD28070@earth.li>
 <s5hr3qctryf.wl-tiwai@suse.de>
 <20150519215310.GF28070@earth.li>
 <s5hd21vu9k7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hd21vu9k7.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 20, 2015 at 07:01:12AM +0200, Takashi Iwai wrote:
> At Tue, 19 May 2015 22:53:10 +0100,
> Jonathan McDowell wrote:
> > 
> > On Tue, May 19, 2015 at 07:09:12PM +0200, Takashi Iwai wrote:
> > > At Tue, 19 May 2015 17:19:11 +0100,
> > > Jonathan McDowell wrote:
> > > > 
> > > > On Tue, May 19, 2015 at 08:15:32AM +0200, Takashi Iwai wrote:
> > > > > Does the patch below have any improvement?
> > > > 
> > > > I still get a clicking on the standby -> active transition with the
> > > > patch provided on top of 4.1-rc4.
> > > 
> > > OK, just to be sure, could you check whether changing msleep(10) to
> > > msleep(100) makes no difference?  Also put a line like
> > > 	pr_info("XXX power up %x\n", nid);
> > > after msleep() call to see which nodes are powered up dynamically.
> > 
> > Increasing the delay, if anything, makes the crackle when powering up
> > seem a little longer. dmesg log looks like:
> > 
> > [ 4206.075557] XXX power up 2
> > [ 4206.179671] XXX power up 14
> > [ 4206.291758] XXX power up 3
> 
> OK, so everything looks correct, but the codec (or the machine) seems
> leading to the noise when a branched path is activated while the pin
> was already powered up.  Then let's disable the widget power-saving
> for these codecs.
> 
> Could you confirm that the patch below works?

4.1-rc4 + patch below running all day without hearing any crackles.
Sounds good to me.

> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Disable widget power-saving for ALC292 & co
> 
> We've got reports that ALC3226 (a Dell variant of ALC292) gives click
> noises at transition from D3 to D0 when the widget power-saving is
> enabled.  Further debugging session showed that avoiding it isn't
> trivial, unfortunately, since paths are basically activated
> dynamically while the pins have been already enabled.
> 
> This patch disables the widget power-saving for such codecs.
> 
> Reported-by: Jonathan McDowell <noodles@earth.li>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/patch_realtek.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 2e246fe495f6..31f8f13be907 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -5623,7 +5623,8 @@ static int patch_alc269(struct hda_codec *codec)
>  
>  	spec = codec->spec;
>  	spec->gen.shared_mic_vref_pin = 0x18;
> -	codec->power_save_node = 1;
> +	if (codec->core.vendor_id != 0x10ec0292)
> +		codec->power_save_node = 1;
>  
>  	snd_hda_pick_fixup(codec, alc269_fixup_models,
>  		       alc269_fixup_tbl, alc269_fixups);
> -- 

J.

-- 
] http://www.earth.li/~noodles/ []     Sex, truth and jellibabies.     [
]  PGP/GPG Key @ the.earth.li   []                                     [
] via keyserver, web or email.  []                                     [
] RSA: 4096/2DA8B985            []                                     [
