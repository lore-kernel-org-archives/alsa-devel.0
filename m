From: Enrico Mioso <mrkiko.rs@gmail.com>
Subject: Re: Intel HDA audio on EEE PC 1101HGo
Date: Sun, 15 Jan 2017 14:14:53 +0100 (CET)
Message-ID: <alpine.LNX.2.20.1701151349380.9808@localhost.localdomain>
References: <alpine.LNX.2.20.1504082130290.1715@localhost.localdomain>
 <s5hegntl2cs.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1611230916070.5938@localhost.localdomain>
 <s5hr35s0xh2.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1612011450060.7660@localhost.localdomain>
 <s5h4m2n21ll.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1701031449090.1620@localhost.localdomain>
 <s5hlgujyyop.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1701121708560.2607@localhost.localdomain>
 <s5h1sw8w8pi.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1701131929420.17357@localhost.localdomain>
 <s5htw92hvz7.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1701141015060.19717@localhost.localdomain>
 <s5hr346ht46.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C8652654AD
 for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2017 14:14:59 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id r126so23966211wmr.3
 for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2017 05:14:59 -0800 (PST)
In-Reply-To: <s5hr346ht46.wl-tiwai@suse.de>
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
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, kailang@realtek.com
List-Id: alsa-devel@alsa-project.org

Hello Takashi.

In trying to narrow down things a little bit further, I wrote a dirty hack 
script, in an attempt to trigger the bug.
So far results seems "encouraging": I was able to trigger the same behaviour. I 
am now running with all your 2 patches applied: the single_cmd=0 one and the 
#if 0 removal of that code snippet in hda_beep.c .
My test script is stupid, and is as follows: svtest.sh .

#!/bin/sh
while [ 1 ]; do
   new_volume=$(echo $RANDOM  / 1000 | bc)
   sleep 41
   beep
   mpc volume $new_volume
   sleep 41
   new_volume=$(echo $RANDOM  / 1000 | bc)
   mpc volume $new_volume
done

Where:
- "sleep" sleeps 1 second more than the 40 secs set for power down: this way I 
stress the power down / power up of the device
- "mpc" is a Music Player Daemon client: the volume command tells the daemon to 
set the volume; alsamixer would reflect those changes. The desired effect was 
only to randomly change the volume.
- the "beep" program is used for beeping: but I intentionally switched to 
another console running the test, thus the program would emit a normal "bell" 
(e.g. an \a sequence in the shell passed to the echo command the right way).
Now the problem would be to narrow down things enough to have a trace snapshot 
in the right moment: but actually I don't know what I can do. I suspect that 
when I can see
snd_hda_codec_realtek hdaudioC0D0: Unable to sync register 0x2b8000. -5
as is the case in this moment, it would be already "too late".
I think this test was able to trigger the problem in two hours or so... Don't know.


Thank you for all Takashi, and all of you.
Have a good sunday all guys.
Enrico

On Sat, 14 Jan 2017, Takashi Iwai wrote:

> Date: Sat, 14 Jan 2017 10:46:01
> From: Takashi Iwai <tiwai@suse.de>
> To: Enrico Mioso <mrkiko.rs@gmail.com>
> Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, kailang@realtek.com
> Subject: Re: [alsa-devel] Intel HDA audio on EEE PC 1101HGo
> 
> On Sat, 14 Jan 2017 10:20:16 +0100,
> Enrico Mioso wrote:
>>
>> Hello Takashi,
>> thank you very much again for your kindness and patience...
>>
>> I'll enable the tracepoint.
>> Discrepancies in the single_cmd value are derived from the fact that I am still using the hackish version of the patch, since I didn't reboot... otherwise I should have started from scratch some very-long operations.
>> But the value has remained to 0, and the fallback didn't happen, as expected.
>>
>> Ok, reading note.rst now.
>> I was wondering, but I may well be wrong: in the past that fallback code brought my system to single cmd mode after polling... Now it crashes, and as I said before, the switching from polling to last_cmd is kind-of immediate most of the times these days (e.g.: on this kernel).
>> May be something goes wrong in the fallback path? Or is this caused by an invalid verb ?
>> Guessing verb = something like a command...
>
> Yes, maybe the fallback to single cmd got broken somehow.  I'd need to
> check with a fault injection.
>
> In anyway, the verb is DIGI_CONVERT_2, and the only possible place is
> the beep setup.
>
> Could you try the below to see whether it makes any difference?
>
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
> index c397e7da0eac..07930e69812a 100644
> --- a/sound/pci/hda/hda_beep.c
> +++ b/sound/pci/hda/hda_beep.c
> @@ -228,9 +228,11 @@ int snd_hda_attach_beep_device(struct hda_codec *codec, int nid)
> 		return -ENOMEM;
> 	snprintf(beep->phys, sizeof(beep->phys),
> 		"card%d/codec#%d/beep0", codec->card->number, codec->addr);
> +#if 0
> 	/* enable linear scale */
> 	snd_hda_codec_write_cache(codec, nid, 0,
> 		AC_VERB_SET_DIGI_CONVERT_2, 0x01);
> +#endif
>
> 	beep->nid = nid;
> 	beep->codec = codec;
>
