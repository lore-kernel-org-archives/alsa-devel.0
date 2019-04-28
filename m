From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] ALSA: hda/realtek: Enable internal speaker
 of ASUS UX362FA with ALC294
Date: Sun, 28 Apr 2019 09:33:16 +0200
Message-ID: <20190428073316.GA25138@lenoch>
References: <CAAqJ6B_FQK=nPHsxwOq4c0YsoBrxaX7gD0QC0L1T0cUVwcAmTw@mail.gmail.com>
 <20190427175441.GA21587@lenoch>
 <CAAqJ6B9oWkpiXypV7UN-wqh9=YdAD-c-376GkcrHyXVsqqeBtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa1.perex.cz (Postfix) with ESMTP id 7FF18F80CAB
 for <alsa-devel@alsa-project.org>; Sun, 28 Apr 2019 09:33:19 +0200 (CEST)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992227AbfD1HdRqDu0V (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Sun, 28 Apr 2019 09:33:17 +0200
Content-Disposition: inline
In-Reply-To: <CAAqJ6B9oWkpiXypV7UN-wqh9=YdAD-c-376GkcrHyXVsqqeBtw@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Petr Nosek <petr.nosek@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Petr,

please keep list Cced.

On Sun, Apr 28, 2019 at 12:48:06AM +0100, Petr Nosek wrote:
> Hi Ladislav,
> 
>  it repairs both. Inernal speaker and headphones.

Ok, will adjust commit message.

>  I'm sending output of dmesg - I think it helps you to see information,
> when is computer booting. Your patch looks like good.

Assuming this part of your boot log comes from patched kernel, right?
snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC294: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
snd_hda_codec_realtek hdaudioC0D0:    inputs:
snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=0x19
snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12

>  Can I do something else to help with repair? I'm not sure, what you mean
> by the last sentence. If I have anything else to do.

I'll send v2 shortly,

Thank you,
	ladis
