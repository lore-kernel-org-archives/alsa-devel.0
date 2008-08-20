From: ikke <ikke@iki.fi>
Subject: Re: maestro3 & es1988: mic range too low
Date: Wed, 20 Aug 2008 13:42:57 +0300
Message-ID: <e3156df0808200342u5b32149bs2fc3ff0ca6d261a0@mail.gmail.com>
References: <e3156df0808171207p71c685e4r40ce079fdad77f89@mail.gmail.com>
	<s5hzlna62w6.wl%tiwai@suse.de>
	<e3156df0808180528s7926ea01mb51ef0449bb5fce@mail.gmail.com>
	<s5hod3qze7x.wl%tiwai@suse.de>
	<e3156df0808182203p1e1cebd0g1efb08c58aa1807b@mail.gmail.com>
	<s5hy72tw9t9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 8EE36103867
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Aug 2008 12:42:58 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m28so93528wag.8
	for <alsa-devel@alsa-project.org>; Wed, 20 Aug 2008 03:42:57 -0700 (PDT)
In-Reply-To: <s5hy72tw9t9.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 19, 2008 at 1:58 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 19 Aug 2008 08:03:14 +0300,
> ikke wrote:
>>
>> ac97_codec.c:
>> AC97_SINGLE("Mic Capture Switch", AC97_REC_GAIN_MIC, 15, 1, 1),
>> AC97_SINGLE("Mic Capture Volume", AC97_REC_GAIN_MIC, 0, 15, 0)
>>
>> That is 4 bits (15, f), not 5 bits (31, 1f). But if this is really
>> only volume control for mic playback, not capture, then I assume it
>> doesn't matter. Could you please still confirm this?
>
> Hm, I thought Allegro has no mic-capture volume (0x1e) but only the
> standard capture volume (0x1c).  Are you sure that it's 0x1e?
>

sorry, I was too hasty and got stuck to wrong lines while looking the
code. The original patch was indeed patching the mic volume, not
capture volume above. The original patch:

-AC97_SINGLE("Mic Playback Volume", AC97_MIC, 0, 15, 1),
+AC97_SINGLE("Mic Playback Volume", AC97_MIC, 0, 31, 1),

You are right, it's 1c, like seen from the diffs I sent. Sorry for the
confusion.  Is there anything you would suggest for me  to do anymore,
other than buying better HW and to shut up ;) ? I compiled the kernel
again with snd debug option, and was able to write the regs via
proc...

  -i
