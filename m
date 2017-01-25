From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: workqueue lockup due to process_unsol_events stuck in
 azx_rirb_get_response
Date: Wed, 25 Jan 2017 18:03:38 +0100
Message-ID: <798b5572-f02b-e58d-9996-f3ecb4f15e1a@suse.cz>
References: <855fe8a9-4167-e193-d3d1-45e9d39630b1@suse.cz>
 <s5ha8afmbpu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ha8afmbpu.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 01/25/2017 03:54 PM, Takashi Iwai wrote:
> On Wed, 25 Jan 2017 13:28:11 +0100,
> Vlastimil Babka wrote:
>>
>> Hi,
>>
>> my desktop randomly experiences workqueue lockups on boot with
>> openSUSE Tumbleweed kernels 4.9.x, installed around
>> Christmas. Previously I had a (badly maintained) Gentoo installation
>> with 4.4 IIRC, so I can't say if the kernel has regressed, or the
>> major userspace changes exposed different timing of stuff.
>
> If the lockup can be reproduced easily, could you check whether the
> old kernel shows the issue?  I don't remember of any big changes in
> ca0132 driver in 4.x kernels.  It'd be helpful even just checking
> an openSUSE Leap 42.1 or 42.2 kernel.
>
>> This is how the workqueue lockup looks like:
> (snip)
>> kernel:  [<ffffffffc0c20501>] dspio_read+0x51/0x70 [snd_hda_codec_ca0132]
>> kernel:  [<ffffffffc0c20566>] ca0132_process_dsp_response+0x46/0x160
>> [snd_hda_codec_ca0132]
>> kernel:  [<ffffffffc0c02fe5>] call_jack_callback.isra.1+0x25/0xa0 [snd_hda_codec]
>> kernel:  [<ffffffffc0c033c6>] snd_hda_jack_unsol_event+0x66/0x80 [snd_hda_codec]
>> kernel:  [<ffffffffc0bfd077>] hda_codec_unsol_event+0x17/0x20 [snd_hda_codec]
>> kernel:  [<ffffffffc0b86193>] process_unsol_events+0x63/0x70 [snd_hda_core]
>
> This is the code path that runs when the codec chip (CA0132) receives
> an unsolicited event with a specific tag (0x16).  It means the DSP
> communication going.

Oh, so it is actually the unused Creative card after all. Wonder what "jack" 
event it processes, since no jack is plugged in...

> Possibly the bug is due to the recursive runtime PM handling.  Could
> you check the patch below?

Hmm, so the issue didn't happen when rebooting with this patch on top of current 
kernel-source stable branch (i.e. 4.9.5). But then I did a full poweroff by 
mistake, and now I can't reproduce it even with the original kernel. Before the 
poweroff it persisted over each reboot today, so perhaps the card was in some 
specific state and now it's not... Might be also related to dual boot with Win10 
and whatever its driver does to it and it persists over reboot? I'll keep using 
the nonpatched kernel until I hit the problem again and then try to test the 
patched kernel more times. Thanks so far!

Vlastimil

>
> thanks,
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> @@ -4417,12 +4417,14 @@ static void ca0132_process_dsp_response(struct hda_codec *codec,
>  	struct ca0132_spec *spec = codec->spec;
>
>  	codec_dbg(codec, "ca0132_process_dsp_response\n");
> +	snd_hda_power_up_pm(codec);
>  	if (spec->wait_scp) {
>  		if (dspio_get_response_data(codec) >= 0)
>  			spec->wait_scp = 0;
>  	}
>
>  	dspio_clear_response_queue(codec);
> +	snd_hda_power_down_pm(codec);
>  }
>
>  static void hp_callback(struct hda_codec *codec, struct hda_jack_callback *cb)
>
