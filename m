From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] sound/pci/hda: depends on instead of
	select for INPUT
Date: Mon, 15 Jan 2018 10:47:26 -0800
Message-ID: <46ccd627-a957-4b43-e51b-43b549e53bab@infradead.org>
References: <254bab8e-5629-0dc0-5a4e-9a010abf9ad8@infradead.org>
 <s5h1siref2e.wl-tiwai@suse.de> <s5hvag330yt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 15D3A266BBC
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 19:47:31 +0100 (CET)
In-Reply-To: <s5hvag330yt.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: moderated for non-subscribers <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 01/15/18 01:50, Takashi Iwai wrote:
> On Mon, 15 Jan 2018 08:50:17 +0100,
> Takashi Iwai wrote:
>>
>> On Mon, 15 Jan 2018 06:11:56 +0100,
>> Randy Dunlap wrote:
>>>
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> Drivers should not 'select' a subsystem. Instead they should depend
>>> on it. If the subsystem is disabled, the user probably did that for
>>> a purpose and one driver shouldn't be changing that.
>>>
>>> This also makes all sound/ drivers consistent w.r.t depending on INPUT
>>> instead of selecting it.
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Jaroslav Kysela <perex@perex.cz>
>>> Cc: Takashi Iwai <tiwai@suse.com>
>>> Cc: alsa-devel@alsa-project.org (moderated for non-subscribers)
>>> ---
>>>  sound/pci/hda/Kconfig |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> --- lnx-415-rc8.orig/sound/pci/hda/Kconfig
>>> +++ lnx-415-rc8/sound/pci/hda/Kconfig
>>> @@ -87,8 +87,8 @@ config SND_HDA_PATCH_LOADER
>>>  
>>>  config SND_HDA_CODEC_REALTEK
>>>  	tristate "Build Realtek HD-audio codec support"
>>> +	depends on INPUT
>>>  	select SND_HDA_GENERIC
>>> -	select INPUT
>>
>> This would break if INPUT=m and SND_HDA_CODEC_REALTEK=y.
>> Usually, we take a trick like
>>
>> 	depends on INPUT=y || INPUT=SND_HDA_CODEC_REALTEK
>>
>> But, looking at the change that introduced the dependency (commit
>> 33f4acd3b214), the code doesn't necessarily depend on INPUT at all.
>> The select above was put there just because the random build with
>> INPUT=m and SND_HDA_CODEC_REALTEK=y would break otherwise.
>>
>> The right fix in this case would be to replace IS_ENABLE(INPUT) with
>> IS_REACHABLE(INPUT) instead.
> 
> ... that is, a patch like below.
> 
> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Use IS_REACHABLE() for dependency on input
> 
> The commit ffcd28d88e4f ("ALSA: hda - Select INPUT for Realtek
> HD-audio codec") introduced the reverse-selection of CONFIG_INPUT for
> Realtek codec in order to avoid the mess with dependency between
> built-in and modules.  Later on, we obtained IS_REACHABLE() macro
> exactly for this kind of problems, and now we can remove th INPUT
> selection in Kconfig and put IS_REACHABLE(INPUT) to the appropriate
> places in the code, so that the driver doesn't need to select other
> subsystem forcibly.
> 
> Fixes: ffcd28d88e4f ("ALSA: hda - Select INPUT for Realtek HD-audio codec")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # and build-tested

Thanks.

> ---
>  sound/pci/hda/Kconfig         | 1 -
>  sound/pci/hda/patch_realtek.c | 5 +++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
> index 7f3b5ed81995..f7a492c382d9 100644
> --- a/sound/pci/hda/Kconfig
> +++ b/sound/pci/hda/Kconfig
> @@ -88,7 +88,6 @@ config SND_HDA_PATCH_LOADER
>  config SND_HDA_CODEC_REALTEK
>  	tristate "Build Realtek HD-audio codec support"
>  	select SND_HDA_GENERIC
> -	select INPUT
>  	help
>  	  Say Y or M here to include Realtek HD-audio codec support in
>  	  snd-hda-intel driver, such as ALC880.
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 440972975bd4..9a98c53e0124 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -3810,6 +3810,7 @@ static void alc280_fixup_hp_gpio4(struct hda_codec *codec,
>  	}
>  }
>  
> +#if IS_REACHABLE(INPUT)
>  static void gpio2_mic_hotkey_event(struct hda_codec *codec,
>  				   struct hda_jack_callback *event)
>  {
> @@ -3942,6 +3943,10 @@ static void alc233_fixup_lenovo_line2_mic_hotkey(struct hda_codec *codec,
>  		spec->kb_dev = NULL;
>  	}
>  }
> +#else /* INPUT */
> +#define alc280_fixup_hp_gpio2_mic_hotkey	NULL
> +#define alc233_fixup_lenovo_line2_mic_hotkey	NULL
> +#endif /* INPUT */
>  
>  static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
>  				const struct hda_fixup *fix, int action)
> 


-- 
~Randy
