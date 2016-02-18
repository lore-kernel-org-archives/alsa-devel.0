From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA: hda - hdmi get jack from
 hda_jack_tbl when not dyn_pcm_assign
Date: Thu, 18 Feb 2016 06:16:29 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1904667A3F@shsmsx102.ccr.corp.intel.com>
References: <1455773102-135817-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id D81D026067A
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2016 07:16:40 +0100 (CET)
In-Reply-To: <1455773102-135817-1-git-send-email-libin.yang@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I submitted the patch which can fix a regression involved from my
jack patch:
commit 25e4abb33df3aafa7d1efba8f82f9178268efab1
Author: Libin Yang <libin.yang@linux.intel.com>
Date:   Tue Jan 12 11:13:27 2016 +0800

    ALSA: hda - hdmi jack created based on pcm

I'm sorry for the inconvenience. 

As the dyn pcm patches are merged into the for-next branch, I'm asking
our QA to do the full test on it. They said they can start the stress test
from next week.

Regards,
Libin


> -----Original Message-----
> From: libin.yang@linux.intel.com [mailto:libin.yang@linux.intel.com]
> Sent: Thursday, February 18, 2016 1:25 PM
> To: alsa-devel@alsa-project.org; tiwai@suse.de
> Cc: Lin, Mengdong; Yang, Libin; Libin Yang
> Subject: [PATCH] ALSA: hda - hdmi get jack from hda_jack_tbl when not
> dyn_pcm_assign
> 
> From: Libin Yang <libin.yang@linux.intel.com>
> 
> On Intel platform, if !dyn_pcm_assign, spec->pcm_rec[].jack is not
> NULL even after snd_hda_jack_tbl_clear() is called to free snd_jack.
> This may cause access invalid memory when calling snd_jack_report.
> 
> Please see more detail from:
> https://bugs.freedesktop.org/show_bug.cgi?id=94079
> 
> Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> ---
>  sound/pci/hda/patch_hdmi.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index f4443b5..3b47101 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1962,6 +1962,7 @@ static void sync_eld_via_acomp(struct
> hda_codec *codec,
>  {
>  	struct hdmi_spec *spec = codec->spec;
>  	struct hdmi_eld *eld = &spec->temp_eld;
> +	struct hda_jack_tbl *jack_tbl;
>  	struct snd_jack *jack = NULL;
>  	int size;
> 
> @@ -1989,10 +1990,21 @@ static void sync_eld_via_acomp(struct
> hda_codec *codec,
>  	/* pcm_idx >=0 before update_eld() means it is in monitor
>  	 * disconnected event. Jack must be fetched before update_eld()
>  	 */
> -	if (per_pin->pcm_idx >= 0)
> +	/* if !dyn_pcm_assign, get jack from hda_jack_tbl
> +	 * in !dyn_pcm_assign case, spec->pcm_rec[].jack is not
> +	 * NULL even after snd_hda_jack_tbl_clear() is called to
> +	 * free snd_jack. This may cause access invalid memory
> +	 * when calling snd_jack_report
> +	 */
> +	if (per_pin->pcm_idx >= 0 && spec->dyn_pcm_assign)
>  		jack = spec->pcm_rec[per_pin->pcm_idx].jack;
> +	else {
> +		jack_tbl = snd_hda_jack_tbl_get(codec, per_pin-
> >pin_nid);
> +		if (jack_tbl)
> +			jack = jack_tbl->jack;
> +	}
>  	update_eld(codec, per_pin, eld);
> -	if (jack == NULL && per_pin->pcm_idx >= 0)
> +	if (jack == NULL && per_pin->pcm_idx >= 0 && spec-
> >dyn_pcm_assign)
>  		jack = spec->pcm_rec[per_pin->pcm_idx].jack;
>  	if (jack == NULL)
>  		goto unlock;
> --
> 1.9.1
