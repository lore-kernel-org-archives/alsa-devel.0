From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH] ASoC: core: allow control index different
	from 0
Date: Mon, 10 Oct 2016 11:26:00 +0200
Message-ID: <75636c51-baf2-8793-b39b-5961845793c1@st.com>
References: <1475595361-12128-1-git-send-email-arnaud.pouliquen@st.com>
 <57F4A4B4.5070400@sakamocchi.jp>
 <20be7e11-aaf3-37ad-df0f-b191dfc563d3@st.com>
 <57F6592A.5030004@sakamocchi.jp>
 <b9f83da7-faea-ce1b-ba9c-33c61b6686f0@st.com>
 <b8205913-8357-ff8a-5f13-2787a1144471@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 122F02650E7
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2016 11:26:04 +0200 (CEST)
In-Reply-To: <b8205913-8357-ff8a-5f13-2787a1144471@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "kernel@stlinux.com" <kernel@stlinux.com>, Takashi Iwai <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, Moise GERGAUD <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org



On 10/09/2016 05:05 AM, Takashi Sakamoto wrote:
> Sorry to be late. I've review your driver in for-next branch of
> maintainer's tree.
> 
> On Oct 8 2016 01:41, Arnaud Pouliquen wrote:
>> Let clarify the my devs:
>>
>> 1) My original implementation is here :
>> http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/soc/sti/sti_uniperif.c?h=sound-4.9-rc1#n232
>> this does not work due to index that is overwritten
>>  Notice that my issue is not limited to iec958 control, but controls in
>> generals
>>
>> 2) In parallel, I proposed generic code to implement:
>>  IEC control + possibility to attach DAI ctrl to PCM
>> device:http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105502.html
>>
>> Right now, I propose to focus on point 1) that integrates constraints
>> for DAIs and forget the patch-set that includes IEC generic control (if
>> you interested in this code, i can rework it in a second step)
> 
> The center of discussion now becomes transformed.
> 
> Anyway, at least, this patch (ASoC: core: allow control index different
> from 0) is exaggerated to your aim. The change influences to all of
> control element sets added by implementations in ALSA SoC part. (We have
> no guarantee that all drivers already set 0 to the field of template
> before calling with the template.)
Full in line with you. this patch is already in my trash.
> 
> And please write enough information about your aim of this patch, even
> if it's a part of your work for something large. It helps reviewers.
> Additionally, if you discuss the former patchset, please rebase them to
> current upstream, then post them again with enough comments, then start
> discussion.
Sorry if my approach to treat the topic is not good. My Aim is to find a
way to support multi instances of an alsa control.
As I suppose that i'm not alone to have this kind of problematic. I am
trying to look for a generic way to do it.

> 
> On Oct 8 2016 01:41, Arnaud Pouliquen wrote:
>> Perhaps this could be handled in a generic way in control.c?
>> Today if control is identical, snd_ctl_add returns an error.
>> Instead an auto-incrementation mechanism could be implemented to
>> increase index.
> 
> Just for ALSA SoC part, something like below (not tested). This never
> work well because 0 is still assigned to the index field later.
Index is forced to 0 in snd_soc_cnew. Not updated after, please find
comment in line in your patch.

> 
> But I still oppose this idea. This idea allows drivers to add control
> element sets of different types (int/int64/bytes etc...) with the same
> name and different index number. This certainly brings confusions to
> applications.
Today is already possible using the device or subdevice field instead of
index.
> 
> In a framework of ALSA SoC part, several drivers are associated to one
> sound card instance can add their own control element sets. There's no
> mechanism to prevent my concern. This idea is bad.
Please tell me if i misunderstand. So for you, there is no real solution
to do it in a generic way. Drivers has to implement it, if they want to
support.

Another solution is to declare a card per instance of control.
This should work for my use case and for use cases with several codecs
that declare same controls. But this should not work for DPCM...
The drawback for my use case, would be that i need to declare one card
per PCM device.

Regards
Arnaud
> 
>>From 30c6abb20ca548add8cddb6e056831efde365c3e Mon Sep 17 00:00:00 2001
> From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Date: Sun, 9 Oct 2016 11:20:08 +0900
> Subject: [PATCH] hoge
> 
> ---
>  sound/soc/soc-core.c | 42 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index c0bbcd9..573ca73 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2202,15 +2202,49 @@ static int snd_soc_add_controls(struct snd_card
> *card, struct device *dev,
>  	const struct snd_kcontrol_new *controls, int num_controls,
>  	const char *prefix, void *data)
>  {
> +	struct snd_kcontrol_new template;
> +	struct snd_ctl_elem_id id;
> +	struct snd_kcontrol *elem_set;
>  	int err, i;
> 
>  	for (i = 0; i < num_controls; i++) {
> -		const struct snd_kcontrol_new *control = &controls[i];
> -		err = snd_ctl_add(card, snd_soc_cnew(control, data,
> -						     control->name, prefix));
> +		template = controls[i];
> +
> +		id.iface = template.iface;
> +		id.device = template.device;
> +		id.subdevice = template.subdevice;
> +		memcpy(id.name, template.name, sizeof(id.name));
> +
> +		/*
> +		 * Seek duplicated element sets already registered in this
> +		 * sound card to use continuous number for index field.
> +		 */
> +		while (1) {
> +			id.index = template.index;
> +
> +			elem_set = snd_ctl_find_id(card, &id);
> +			if (elem_set == NULL)
> +				break;
> +
> +			if (elem_set->id.index > UINT_MAX - elem_set->count) {
> +				dev_err(dev, "ASoC: Failed to keep %s: %d\n",
> +					template.name, err);
> +				return -ENOSPC;
> +			}
> +			template.index = elem_set->count + elem_set->id.index;
> +		}
> +
> +		elem_set = snd_soc_cnew(&template, data, template.name, prefix);
index field is forced to 0 in snd_soc_cnew so eleme_set->id.index should
be overwritten to be taken into account.
> +		if (elem_set == NULL) {
> +			dev_err(dev, "ASoC: Failed to allocate %s: %d\n",
> +				template.name, err);
> +			return -ENOMEM;
> +		}
> +
> +		err = snd_ctl_add(card, elem_set);
>  		if (err < 0) {
>  			dev_err(dev, "ASoC: Failed to add %s: %d\n",
> -				control->name, err);
> +				template.name, err);
>  			return err;
>  		}
>  	}
> 
