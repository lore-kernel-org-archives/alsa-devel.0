From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Don't be too specific for
 conflicting boost ctl names
Date: Thu, 19 Dec 2013 06:34:59 +0100
Message-ID: <52B28583.3050909@canonical.com>
References: <1387388362-1005-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E0382261A7F
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 06:35:01 +0100 (CET)
In-Reply-To: <1387388362-1005-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/18/2013 06:39 PM, Takashi Iwai wrote:
> When a boost control influences on multiple input paths, we shouldn't
> pick up the name string specific to one input but rather choose a more
> generic name.  A problem seen often is that a single mic boost
> controls both internal and external mics although the driver picks up
> the very first name randomly like "Internal Mic Boost".  This should
> have been "Mic Boost", instead.
> 
> This patch tries to correct that behavior: when a boost control is
> available, check whether it conflicts with other inputs.  If it does,
> use a common string ("Mic", "Line") as long as possible, or take a
> generic name "Input".

Hrm. I thought today "Mic Boost" is quite common, and meaning the mic
boost of the non-internal mic. So I agree there is a problem - and thank
you for trying to fix it - but isn't this just changing one problem for
another? Now we don't know if a "Mic Boost" control controls the
internal mic or not.

> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/hda_generic.c | 44 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
> index 8cebdcfdcfdc..e3f934703aa2 100644
> --- a/sound/pci/hda/hda_generic.c
> +++ b/sound/pci/hda/hda_generic.c
> @@ -3651,6 +3651,8 @@ static int parse_mic_boost(struct hda_codec *codec)
>  	struct hda_gen_spec *spec = codec->spec;
>  	struct auto_pin_cfg *cfg = &spec->autocfg;
>  	struct hda_input_mux *imux = &spec->input_mux;
> +	static const char *input_type_labels[3] = { "Mic", "Line", "Input" };
> +	int input_type_idxs[3] = {};
>  	int i;
>  
>  	if (!spec->num_adc_nids)
> @@ -3659,7 +3661,9 @@ static int parse_mic_boost(struct hda_codec *codec)
>  	for (i = 0; i < imux->num_items; i++) {
>  		struct nid_path *path;
>  		unsigned int val;
> -		int idx;
> +		int idx, type, j;
> +		bool conflict;
> +		const char *pfx;
>  		char boost_label[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
>  
>  		idx = imux->items[i].index;
> @@ -3678,11 +3682,43 @@ static int parse_mic_boost(struct hda_codec *codec)
>  		if (!val)
>  			continue;
>  
> +		/* check whether conflicting with other input paths */
> +		type = cfg->inputs[idx].type;
> +		conflict = false;
> +		for (j = i + 1; j < imux->num_items; j++) {
> +			int idx_next = imux->items[i].index;
> +			int type_next;
> +			struct nid_path *path_next;
> +			if (idx_next >= imux->num_items)
> +				continue;
> +			type_next = cfg->inputs[idx_next].type;
> +			if (type_next > AUTO_PIN_LINE_IN)
> +				continue;
> +			path_next = get_input_path(codec, 0, j);
> +			if (!path_next)
> +				continue;
> +			/* conflicting value? */
> +			if (look_for_boost_amp(codec, path_next) == val) {
> +				conflict = true;
> +				if (type != type_next) {
> +					type = 2; /* generic input */
> +					break;
> +				}
> +			}
> +		}
> +
>  		/* create a boost control */
> +		if (!conflict) {
> +			pfx = spec->input_labels[idx];
> +			idx = spec->input_label_idxs[idx];
> +		} else {
> +			pfx = input_type_labels[type];
> +			idx = input_type_idxs[type]++;
> +		}
> +
>  		snprintf(boost_label, sizeof(boost_label),
> -			 "%s Boost Volume", spec->input_labels[idx]);
> -		if (!add_control(spec, HDA_CTL_WIDGET_VOL, boost_label,
> -				 spec->input_label_idxs[idx], val))
> +			 "%s Boost Volume", pfx);
> +		if (!add_control(spec, HDA_CTL_WIDGET_VOL, boost_label, idx, val))
>  			return -ENOMEM;
>  
>  		path->ctls[NID_PATH_BOOST_CTL] = val;
> 



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
