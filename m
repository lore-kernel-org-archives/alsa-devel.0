From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Wed, 08 Feb 2012 09:36:21 +0100
Message-ID: <4F323405.8080902@canonical.com>
References: <1328644128-32630-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1328644128-32630-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id ED5392456A
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 09:36:23 +0100 (CET)
In-Reply-To: <1328644128-32630-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 02/07/2012 08:48 PM, Mark Brown wrote:
> Create controls for jack reporting when creating a standard jack, allowing
> drivers to support both userspace interfaces via a single core interface.
> There's a couple of improvements that could be made (like using the jack
> name in the control name) but these are punted until after we remove direct
> users of snd_kctl_jack_*().
>
> Signed-off-by: Mark Brown<broonie@opensource.wolfsonmicro.com>
> ---
>   include/sound/jack.h |    2 +
>   sound/core/Kconfig   |    1 +
>   sound/core/jack.c    |   63 ++++++++++++++++++++++++++++++++++++++------------
>   3 files changed, 51 insertions(+), 15 deletions(-)
>
> diff --git a/include/sound/jack.h b/include/sound/jack.h
> index 5891657..4e50ae5 100644
> --- a/include/sound/jack.h
> +++ b/include/sound/jack.h
> @@ -58,10 +58,12 @@ enum snd_jack_types {
>
>   struct snd_jack {
>   	struct input_dev *input_dev;
> +	struct snd_card *card;
>   	int registered;
>   	int type;
>   	const char *id;
>   	char name[100];
> +	struct snd_kcontrol *ctl[SND_JACK_SWITCH_TYPES];
>   	unsigned int key[6];   /* Keep in sync with definitions above */
>   	void *private_data;
>   	void (*private_free)(struct snd_jack *);
> diff --git a/sound/core/Kconfig b/sound/core/Kconfig
> index b413ed0..e99b0171 100644
> --- a/sound/core/Kconfig
> +++ b/sound/core/Kconfig
> @@ -211,6 +211,7 @@ config SND_VMASTER
>
>   config SND_KCTL_JACK
>   	bool
> +	default y if SND_JACK
>
>   config SND_DMA_SGBUF
>   	def_bool y
> diff --git a/sound/core/jack.c b/sound/core/jack.c
> index 471e1e3..c0fe7b9 100644
> --- a/sound/core/jack.c
> +++ b/sound/core/jack.c
> @@ -24,19 +24,25 @@
>   #include<linux/module.h>
>   #include<sound/jack.h>
>   #include<sound/core.h>
> -
> -static int jack_switch_types[SND_JACK_SWITCH_TYPES] = {
> -	SW_HEADPHONE_INSERT,
> -	SW_MICROPHONE_INSERT,
> -	SW_LINEOUT_INSERT,
> -	SW_JACK_PHYSICAL_INSERT,
> -	SW_VIDEOOUT_INSERT,
> -	SW_LINEIN_INSERT,
> +#include<sound/control.h>
> +
> +static const struct {
> +	int input_type;
> +	const char *name;
> +} jack_switch_types[SND_JACK_SWITCH_TYPES] = {
> +	{ SW_HEADPHONE_INSERT, "Headphone" },
> +	{ SW_MICROPHONE_INSERT, "Microphone" },
> +	{ SW_LINEOUT_INSERT, "Line Out" },
> +	{ SW_JACK_PHYSICAL_INSERT, "Mechanical" },
> +	{ SW_VIDEOOUT_INSERT, "Video Out" },
> +	{ SW_LINEIN_INSERT, "Line In" },
>   };

I'd like these to match the names currently used in HDA, like this:

	{ SW_HEADPHONE_INSERT, "Headphone" },
	{ SW_MICROPHONE_INSERT, "Mic" },
	{ SW_LINEOUT_INSERT, "Line-Out" },
	{ SW_JACK_PHYSICAL_INSERT, "Mechanical" },
	{ SW_VIDEOOUT_INSERT, "Video-Out" },
	{ SW_LINEIN_INSERT, "Line" },

Actually, it matters less if we settle on the standard you set above, or 
what the HDA currently does, as long as the names are the same.

>
>   static int snd_jack_dev_free(struct snd_device *device)
>   {
> +	struct snd_card *card = device->card;
>   	struct snd_jack *jack = device->device_data;
> +	int i;
>
>   	if (jack->private_free)
>   		jack->private_free(jack);
> @@ -48,6 +54,10 @@ static int snd_jack_dev_free(struct snd_device *device)
>   	else
>   		input_free_device(jack->input_dev);
>
> +	for (i = 0; i<  SND_JACK_SWITCH_TYPES; i++)
> +		if (jack->ctl[i])
> +			snd_ctl_remove(card, jack->ctl[i]);
> +
>   	kfree(jack->id);
>   	kfree(jack);
>
> @@ -105,8 +115,9 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
>   		 struct snd_jack **jjack)
>   {
>   	struct snd_jack *jack;
> -	int err;
> +	int err = 0;
>   	int i;
> +	struct snd_kcontrol *kcontrol;
>   	static struct snd_device_ops ops = {
>   		.dev_free = snd_jack_dev_free,
>   		.dev_register = snd_jack_dev_register,
> @@ -116,6 +127,7 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
>   	if (jack == NULL)
>   		return -ENOMEM;
>
> +	jack->card = card;
>   	jack->id = kstrdup(id, GFP_KERNEL);
>
>   	jack->input_dev = input_allocate_device();
> @@ -128,10 +140,28 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
>
>   	jack->type = type;
>
> -	for (i = 0; i<  SND_JACK_SWITCH_TYPES; i++)
> -		if (type&  (1<<  i))
> -			input_set_capability(jack->input_dev, EV_SW,
> -					     jack_switch_types[i]);
> +	for (i = 0; i<  SND_JACK_SWITCH_TYPES; i++) {
> +		if (!(type&  (1<<  i)))
> +			continue;
> +
> +		input_set_capability(jack->input_dev, EV_SW,
> +				     jack_switch_types[i].input_type);
> +
> +		kcontrol = snd_kctl_jack_new(jack_switch_types[i].name, 0,
> +					     NULL);
> +		if (kcontrol) {
> +			err = snd_ctl_add(card, kcontrol);
> +			if (!err)
> +				jack->ctl[i] = kcontrol;
> +			else
> +				dev_warn(card->dev,
> +					 "Failed to create %s control: %d\n",
> +					 jack_switch_types[i].name, err);
> +		} else {
> +			dev_warn(card->dev, "Failed to create %s control\n",
> +				 jack_switch_types[i].name);
> +		}
> +	}
>
>   	err = snd_device_new(card, SNDRV_DEV_JACK, jack,&ops);
>   	if (err<  0)
> @@ -227,10 +257,13 @@ void snd_jack_report(struct snd_jack *jack, int status)
>
>   	for (i = 0; i<  ARRAY_SIZE(jack_switch_types); i++) {
>   		int testbit = 1<<  i;
> -		if (jack->type&  testbit)
> +		if (jack->type&  testbit) {
>   			input_report_switch(jack->input_dev,
> -					    jack_switch_types[i],
> +					    jack_switch_types[i].input_type,
>   					    status&  testbit);
> +			snd_kctl_jack_report(jack->card, jack->ctl[i],
> +					     status&  testbit);
> +		}
>   	}
>
>   	input_sync(jack->input_dev);



-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
