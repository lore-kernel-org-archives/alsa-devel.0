From: Massimo Del Fedele <max@veneto.com>
Subject: Re: Fix for Asus G75 notebook subwoofer
Date: Wed, 07 Nov 2012 14:37:33 +0100
Message-ID: <509A641D.8070501@veneto.com>
References: <k6rkr2$usv$1@ger.gmane.org> <s5hy5ifgmbq.wl%tiwai@suse.de>
 <k7ajdq$42u$1@ger.gmane.org> <s5hsj8ngkxe.wl%tiwai@suse.de>
 <k7b68h$epd$1@ger.gmane.org> <s5h390m95d5.wl%tiwai@suse.de>
 <509947A7.9080406@veneto.com> <s5h7gpxhjtz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 041C0264FEA
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 14:37:44 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1TW5pH-0000Qk-OJ
 for alsa-devel@alsa-project.org; Wed, 07 Nov 2012 14:37:51 +0100
Received: from host184-250-dynamic.0-87-r.retail.telecomitalia.it
 ([87.0.250.184]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 07 Nov 2012 14:37:51 +0100
Received: from max by host184-250-dynamic.0-87-r.retail.telecomitalia.it with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 07 Nov 2012 14:37:51 +0100
In-Reply-To: <s5h7gpxhjtz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Il 07/11/2012 09:56, Takashi Iwai ha scritto:
> At Tue, 06 Nov 2012 18:23:51 +0100,
> Massimo Del Fedele wrote:
>>
>> Il 06/11/2012 15:24, Takashi Iwai ha scritto:
>>> At Tue, 06 Nov 2012 15:18:58 +0100,
>>> Massimo Del Fedele wrote:
>>>> Il 06/11/2012 10:06, Takashi Iwai ha scritto:
>>>>
>>>>> Could you attach to ML too?
>>>> I tried, but they're too big
>>> Did you compress it?
>> No, but I'm doing now... in compressed file are both info
> Could you post also alsa-info.sh output before applying your patch,
> too?
>
>>>>>> BTW, did you see the above patch (error in via_auto_fill_dac_nids) ?
>>>>>> My patch isn't correct either (fails when the 'continue' path is taken)
>>>>>> but it's better than now. I guess that code should be rewritten, it's
>>>>>> quite weird in respect to dac numbering.
>>>>> Could you elaborate a bit more?
>>>>>
>>>> Ok. here the original functions :
>>> Hmm... could you give a "diff -up" output instead?
>> Ok... here is te diff (with whole asus patch). I cleaned up the part of via_auto_fill_dac_nids,
>> it should be correct now in all parts, even for skipped nids.
> Actually the only place to be fixed is the assignment of
> spec->private_dac_nids[].  spec->out_path[] should correspond to
> cfg->line_out_pins[].  That is, the patch below should suffice (in
> addition to pin default changes and connection overrides for VT1802).
>
>
> thanks,
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
> index 72a2f60..1c1367b 100644
> --- a/sound/pci/hda/patch_via.c
> +++ b/sound/pci/hda/patch_via.c
> @@ -1825,7 +1825,7 @@ static int via_auto_fill_dac_nids(struct hda_codec *codec)
>   					    &spec->out_mix_path))
>   			dac = spec->out_mix_path.path[0];
>   		if (dac) {
> -			spec->private_dac_nids[i] = dac;
> +			spec->private_dac_nids[dac_num] = dac;
>   			dac_num++;
>   		}
>   	}
>
>
>
Hi...  not tested, but IMHO your patch won't  be enough; you're not updating the spec->multiout.num_dacs inside the loop,
which means that is_empty_dac(codec, conn[i]) inside __parse_output_path() will not detect used DACs as used :

static bool is_empty_dac(struct hda_codec *codec, hda_nid_t dac)
{
     struct via_spec *spec = codec->spec;
     int i;

     for (i = 0; i < spec->multiout.num_dacs; i++) { <---- HERE, using spec->multiout.num_dacs as loop end
         if (spec->multiout.dac_nids[i] == dac)
             return false;
     }
     if (spec->hp_dac_nid == dac)
         return false;
     return true;
}

You need to update spec->multiout.num_dacs INSIDE scan loop, NOT at end.

Ciao

Max
