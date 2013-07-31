From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [patch] ASoC: dapm: using freed pointer in dapm_kcontrol_add_widget()
Date: Wed, 31 Jul 2013 20:44:17 +0200
Message-ID: <51F95B01.7040002@metafoo.de>
References: <20130731085244.GB8210@elgon.mountain> <51F8D2B5.7060504@metafoo.de> <CAOesGMgrztKFbLM4m3sr1cH=Od6FVy8p2BbEi_X=J_jDhyHBKw@mail.gmail.com> <51F9585F.8060505@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <51F9585F.8060505@metafoo.de>
Sender: kernel-janitors-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 07/31/2013 08:33 PM, Lars-Peter Clausen wrote:
> On 07/31/2013 08:17 PM, Olof Johansson wrote:
>> Hi,
>>
>> On Wed, Jul 31, 2013 at 2:02 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>> On 07/31/2013 10:52 AM, Dan Carpenter wrote:
>>>>
>>>> There is a typo here so we end up using the old freed pointer instead of
>>>> the newly allocated one.  (If the "n" is zero then the code works,
>>>> obviously).
>>>>
>>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>
>>>
>>> Thanks.
>>>
>>> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>>>
>>> Olof, can you check whether this fixes the crash you see?
>>
>> Nope.
>>
>> There's also remaining issues with the code, that patch isn't enough.
>> The structure that is krealloced() has a list_head in it, but the list
>> isn't moved from the old head to the new one. There's no safe way to
>> do that using krealloc, since the old list_head is gone by then, so
>> it's probably easest to open-code with kzalloc/memcpy/kfree.
>
> Hm, right I didn't think of that. Maybe it's better to just keep a the widget
> list in a separate pointer, so none of the other fields of the kcontrol_data
> struct are affected by the krealloc.
>

Something along the lines of this:

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d74c356..ef1db0b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -177,7 +177,7 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
  struct dapm_kcontrol_data {
  	unsigned int value;
  	struct list_head paths;
-	struct snd_soc_dapm_widget_list wlist;
+	struct snd_soc_dapm_widget_list *wlist;
  };

  static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
@@ -185,26 +185,36 @@ static int dapm_kcontrol_data_alloc(struct
  {
  	struct dapm_kcontrol_data *data;

-	data = kzalloc(sizeof(*data) + sizeof(widget), GFP_KERNEL);
-	if (!data) {
-		dev_err(widget->dapm->dev,
-				"ASoC: can't allocate kcontrol data for %s\n",
-				widget->name);
-		return -ENOMEM;
-	}
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		goto err;

-	data->wlist.widgets[0] = widget;
-	data->wlist.num_widgets = 1;
+	data->wlist = kzalloc(sizeof(*data->wlist) + sizeof(widget),
+		GFP_KERNEL);
+	if (!data->wlist)
+		goto err_free;
+
+	data->wlist->widgets[0] = widget;
+	data->wlist->num_widgets = 1;
  	INIT_LIST_HEAD(&data->paths);

  	kcontrol->private_data = data;

  	return 0;
+err_free:
+	kfree(data);
+err:
+	dev_err(widget->dapm->dev,
+			"ASoC: can't allocate kcontrol data for %s\n",
+			widget->name);
+
+	return -ENOMEM;
  }

  static void dapm_kcontrol_free(struct snd_kcontrol *kctl)
  {
  	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kctl);
+	kfree(data->wlist);
  	kfree(data);
  }

@@ -213,25 +223,25 @@ static struct snd_soc_dapm_widget_list
  {
  	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);

-	return &data->wlist;
+	return data->wlist;
  }

  static int dapm_kcontrol_add_widget(struct snd_kcontrol *kcontrol,
  	struct snd_soc_dapm_widget *widget)
  {
  	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
-	struct dapm_kcontrol_data *new_data;
-	unsigned int n = data->wlist.num_widgets + 1;
+	struct snd_soc_dapm_widget_list *new_wlist;
+	unsigned int n = data->wlist->num_widgets + 1;

-	new_data = krealloc(data, sizeof(*data) + sizeof(widget) * n,
+	new_wlist = krealloc(data, sizeof(*new_wlist) + sizeof(widget) * n,
  		GFP_KERNEL);
-	if (!new_data)
+	if (!new_wlist)
  		return -ENOMEM;

-	new_data->wlist.widgets[n - 1] = widget;
-	new_data->wlist.num_widgets = n;
+	new_wlist->widgets[n - 1] = widget;
+	new_wlist->num_widgets = n;

-	kcontrol->private_data = new_data;
+	data->wlist = new_wlist;

  	return 0;
  }

