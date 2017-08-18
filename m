From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v4 1/9] ASoC: rt5514: Avoid legacy dai naming
Date: Fri, 18 Aug 2017 23:03:46 +0800
Message-ID: <599701D2.5080001@rock-chips.com>
References: <20170818031147.16810-1-jeffy.chen@rock-chips.com> <20170818031147.16810-2-jeffy.chen@rock-chips.com> <20170818114544.szfxl5pbul7gwgxg@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170818114544.szfxl5pbul7gwgxg@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de, briannorris@chromium.org, mka@chromium.org, dianders@chromium.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 08/18/2017 07:45 PM, Mark Brown wrote:
> On Fri, Aug 18, 2017 at 11:11:39AM +0800, Jeffy Chen wrote:
>> Currently we are using devm_snd_soc_register_component, which would
>> use legacy dai naming when dai drv id is zero.
>>
>> Set a non-zero dai drv id to use dai drv name for dai name.
>
> Why?  This is clearly not good, we shouldn't be expecting all devices
> with a single DAI to set the DAI number to 1 and the changelog doesn't
> articulate any reason why anything cares what the name is.
>

i was trying to avoid legacy dai naming, because snd_soc_find_dai will 
try to match the dai name:

struct snd_soc_dai *snd_soc_find_dai(
         const struct snd_soc_dai_link_component *dlc)
{
...

                 list_for_each_entry(dai, &component->dai_list, list) {
                         if (dlc->dai_name && strcmp(dai->name, 
dlc->dai_name))
                                 continue;

                         return dai;


if match failed, it would break soc_bind_dai_link:

static int soc_bind_dai_link(struct snd_soc_card *card,
         struct snd_soc_dai_link *dai_link)
{
...
         /* Find CODEC from registered CODECs */
         codec_dais = rtd->codec_dais;
         for (i = 0; i < rtd->num_codecs; i++) {
                 codec_dais[i] = snd_soc_find_dai(&codecs[i]);
                 if (!codec_dais[i]) {
                         dev_err(card->dev, "ASoC: CODEC DAI %s not 
registered\n",
                                 codecs[i].dai_name);
                         goto _err_defer;
                 }




when using legacy dai naming, the dai->name for rt5514-spi would be the 
dev name, which is spi2.0 with my local 4.4 kernel, and would be 
spi32765.0 with upstream kernel.
