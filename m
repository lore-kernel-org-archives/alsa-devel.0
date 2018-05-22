From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: Intel: cht_bsw_nau8824: Fix
 jack_type to include SND_JACK_MICROPHONE
Date: Tue, 22 May 2018 10:12:46 +0800
Message-ID: <5B037C9E.4060707@nuvoton.com>
References: <20180521124251.10535-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C71DE267628
 for <alsa-devel@alsa-project.org>; Tue, 22 May 2018 04:12:52 +0200 (CEST)
In-Reply-To: <20180521124251.10535-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 5/21/2018 8:42 PM, Hans de Goede wrote:
> The nau8824 codec can detect whether a headset or plain headphones is
> inserted (as well as button presses on the headset) as such the jack_type
> passed to snd_soc_card_jack_new() should include SND_JACK_MICROPHONE.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  sound/soc/intel/boards/cht_bsw_nau8824.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/intel/boards/cht_bsw_nau8824.c b/sound/soc/intel/boards/cht_bsw_nau8824.c
> index 072e94b69e57..30c46977d53c 100644
> --- a/sound/soc/intel/boards/cht_bsw_nau8824.c
> +++ b/sound/soc/intel/boards/cht_bsw_nau8824.c
> @@ -120,7 +120,7 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
>        * KEY_VOLUMEUP
>        * KEY_VOLUMEDOWN
>        */
> -     jack_type = SND_JACK_HEADPHONE | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
> +     jack_type = SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
>               SND_JACK_BTN_2 | SND_JACK_BTN_3;
>       ret = snd_soc_card_jack_new(runtime->card, "Headset", jack_type, jack,
>               cht_bsw_jack_pins, ARRAY_SIZE(cht_bsw_jack_pins));

It's good for me.


===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
