From: ikke <ikke@iki.fi>
Subject: Re: maestro3 & es1988: mic range too low
Date: Mon, 18 Aug 2008 15:30:15 +0300
Message-ID: <e3156df0808180530i63e5374aldb6774e228fd6280@mail.gmail.com>
References: <e3156df0808171207p71c685e4r40ce079fdad77f89@mail.gmail.com>
	<s5hzlna62w6.wl%tiwai@suse.de>
	<e3156df0808180528s7926ea01mb51ef0449bb5fce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 95C0424430
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Aug 2008 14:30:17 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id a29so3861159pyi.36
	for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2008 05:30:16 -0700 (PDT)
In-Reply-To: <e3156df0808180528s7926ea01mb51ef0449bb5fce@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 18, 2008 at 1:20 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sun, 17 Aug 2008 22:07:19 +0300,
>
> Note that "Mic Playback Volume" controls only the volume of analog
> playback.  It doesn't change the recording level at all.

thanks for reminding, sure.

>> the reasoning for the original patch sounds reasonable. The
>> mic volume is tunable, only at the very low range. I recall the laptop
>> came with Win98, and there was no problem then with the sound -> not a
>> HW problem. I have never got this laptop mic working with linux, so
>> this is not anything that broke recently. I see there is
>> check_volume_resolution function which tries to guess some of the
>> register ranges, but maybe it get's it wrong with this HW.
>
> Maybe, maybe not.  You should check rather ac97 registers in
> /proc/asound/card0/codec97#0/ac97#0-0+regs.  If build with
> CONFIG_SND_DEBUG=y, you can write to the register directly, too.
> See Documentaiton[/sound/alsa]/Procfile.txt.
>

I checked this file. It seems it gets the regs right for the mic
(range 0x1f). The capture range is 0xf. I don't have the specs to
compare it against, so I assume there is nothing to do more here.

It seems mic value decreases while going up to full, where as capture
increases. Another difference is maybe stereo / mono related, the
capture changes both bytes whereas mic only the other one. Also one
thing, should the mic level be around 0x40 - 0x5f, not 0x0 - 0x1f.
Here's the diff of the registers between mixing the capture and mic
from min to max:

$ diff /tmp/ac97_regs_capt_{min,full}
15c15
< 0:1c = 0000
---
> 0:1c = 0f0f

$ diff /tmp/ac97_regs_mic_{min,full}
8c8
< 0:0e = 005f
---
> 0:0e = 0040

I'll recompile it with sound debug just to test it...

Thanks,

ikke
