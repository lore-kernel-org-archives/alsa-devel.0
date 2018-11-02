From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: wm97xx: fix uninitialized regmap pointer problem
Date: Fri, 2 Nov 2018 16:15:48 +0100
Message-ID: <CAK8P3a0Mb3k8FAVdRWyiEwjCV4re1-LEvxG-NQXLfhEHts1ZDA@mail.gmail.com>
References: <20181102112341.753642-1-arnd@arndb.de> <20181102143817.GP16508@imbe.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181102143817.GP16508@imbe.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

On 11/2/18, Charles Keepax <ckeepax@opensource.cirrus.com> wrote:
> On Fri, Nov 02, 2018 at 12:23:08PM +0100, Arnd Bergmann wrote:

>>  static void wm9713_soc_remove(struct snd_soc_component *component)
>>  {
>> -#ifdef CONFIG_SND_SOC_AC97_BUS
>>  	struct wm9713_priv *wm9713 = snd_soc_component_get_drvdata(component);
>>
>> -	if (!wm9713->mfd_pdata) {
>> +	if (IS_ENABLED(CONFIG_SND_SOC_AC97_BUS)) {
>
> Should this one not also have an && !wm9713->mfd_pdata?

Right, good catch!. I'll send a fixed version in a bit.

       Arnd
