From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: [PATCH] ALSA: HDA: Remove unconnected PCM devices
 for	Intel HDMI
Date: Tue, 23 Nov 2010 23:15:36 +0800
Message-ID: <20101123151536.GB26749@localhost>
References: <4CDD615A.7000807@canonical.com> <s5hy68kpl6s.wl%tiwai@suse.de>
	<4CEB8968.5090205@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id B33E3103A90
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 16:15:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4CEB8968.5090205@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> >From ca84aa8edbfb66e46266677249b141b5419d6e0a Mon Sep 17 00:00:00 2001
> From: David Henningsson <david.henningsson@canonical.com>
> Date: Tue, 23 Nov 2010 10:23:40 +0100
> Subject: [PATCH] ALSA: HDA: Remove unconnected PCM devices for Intel HDMI
> 
> Some newer chips have more than one HDMI output, but usually not

Please point out the model name here (where this patch actually makes
a difference)?

> all of them are exposed as physical jacks. Removing the unused
> PCM devices (as indicated by BIOS in the pin config default) will
> reduce user confusion as they currently have to choose between
> several HDMI devices, some of them not working anyway.
> 
> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
> ---
>  sound/pci/hda/patch_hdmi.c |   41 ++++++++++++++++++++++++++++++++---------
>  1 files changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index d3e49aa..14a1087 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -905,23 +905,28 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
>  	spec->pin[spec->num_pins] = pin_nid;
>  	spec->num_pins++;
>  
> -	/*
> -	 * It is assumed that converter nodes come first in the node list and
> -	 * hence have been registered and usable now.
> -	 */
>  	return hdmi_read_pin_conn(codec, pin_nid);
>  }
>  
>  static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t nid)
>  {
> +	int i, found_pin = 0;
>  	struct hdmi_spec *spec = codec->spec;
>  
> -	if (spec->num_cvts >= MAX_HDMI_CVTS) {
> -		snd_printk(KERN_WARNING
> -			   "HDMI: no space for converter %d\n", nid);
> -		return -E2BIG;

> +	for (i = 0; i < spec->num_pins; i++)
> +		if (nid == spec->pin_cvt[i]) {
> +			found_pin = 1;
> +			break;
> +		}
> +
> +	if (!found_pin) {

Can test this instead:

        if (hda_node_index(spec->pin_cvt, nid) < 0) {


> +		snd_printdd("HDMI: Skipping node %d (no connection)\n", nid);
> +		return -EINVAL;
>  	}

The above return actually will hide the device for cvt 3:

               +---- pin 4
              /     
        cvt 2 ------ pin 5
              \
               +---- pin 6

        cvt 3

Which is the default connection for Intel ibexpeak/sandybridge codecs.
It might be a problem when the user uses dual displays (which may be
configured at runtime). I have no such a setup, so cannot assure
things will work or not work..

Thanks,
Fengguang
