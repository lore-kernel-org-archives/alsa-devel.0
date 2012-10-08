From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Constant noise on HDA ALC275
Date: Mon, 08 Oct 2012 16:39:35 +0200
Message-ID: <5072E5A7.9040701@canonical.com>
References: <87obl7bg02.fsf@dex.adm.naquadah.org>
 <s5h4nmrbln3.wl%tiwai@suse.de> <87wqznim1k.fsf@dex.adm.naquadah.org>
 <s5hzk4ja5hz.wl%tiwai@suse.de> <87pq5fiklg.fsf@dex.adm.naquadah.org>
 <s5hwqzna4pn.wl%tiwai@suse.de> <87haqrijiz.fsf@dex.adm.naquadah.org>
 <s5htxura31x.wl%tiwai@suse.de> <87d31fii3v.fsf@dex.adm.naquadah.org>
 <s5hmx0ja08z.wl%tiwai@suse.de> <874nmried6.fsf@dex.adm.naquadah.org>
 <s5hfw6bpen9.wl%tiwai@suse.de> <87vcf7gyl5.fsf@dex.adm.naquadah.org>
 <s5h6277pdfi.wl%tiwai@suse.de> <87r4pvgxvx.fsf@dex.adm.naquadah.org>
 <87r4pepcgo.fsf@dex.adm.naquadah.org> <s5h1uh9jfxq.wl%tiwai@suse.de>
 <87zk3xku73.fsf@dex.adm.naquadah.org> <s5hwqz1i0y0.wl%tiwai@suse.de>
 <87fw5pktos.fsf@dex.adm.naquadah.org> <s5hr4p9hzw0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B23526173F
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2012 16:39:35 +0200 (CEST)
In-Reply-To: <s5hr4p9hzw0.wl%tiwai@suse.de>
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
Cc: Julien Danjou <julien@danjou.info>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/08/2012 03:11 PM, Takashi Iwai wrote:
> At Mon, 08 Oct 2012 14:57:23 +0200,
> Julien Danjou wrote:
>>
>> On Mon, Oct 08 2012, Takashi Iwai wrote:
>>
>>> It's interesting.  So, _unmuting_ the input from NID 0x1d removes the
>>> noise?  (0x80 means the channel is muted.)
>>
>> Yes, that's it.
>>
>> (I just unloaded and reloaded the module and rechecked).
>
> OK, then could you try the patch below?
>
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 8568aee..42dd605 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -5988,10 +5988,22 @@ static void alc269_fixup_mic2_mute(struct hda_codec *codec,
>   	}
>   }
>
> +static void alc275_fixup_vaio_mixer(struct hda_codec *codec,
> +				    const struct alc_fixup *fix, int action)
> +{
> +	/* _UN_muting the input from NID 0x1d fixes the mysterious speaker
> +	 * noise on Sony VAIO Z
> +	 */
> +	if (action == ALC_FIXUP_ACT_INIT)
> +		snd_hda_codec_write(codec, 0x0b, 0,
> +				    AC_VERB_SET_AMP_GAIN_MUTE,
> +				    AMP_IN_UNMUTE(4));
> +}

Hmm, isn't it easier just to toggle "Beep Playback Switch"?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
