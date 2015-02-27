From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: Intel HDA / ALC662 analog surround problem
Date: Fri, 27 Feb 2015 19:55:44 +0100
Message-ID: <54f0bf96.460db348.bm000@wupperonline.de>
References: <CAN8cciZ4=UXVLFgykv2V67e9+K5OwnYo3tq-cDUDJd2xgqszBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout8.wup.tal.de (mout8.wup.tal.de [195.8.233.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E5362608EC
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 20:06:03 +0100 (CET)
In-Reply-To: <CAN8cciZ4=UXVLFgykv2V67e9+K5OwnYo3tq-cDUDJd2xgqszBw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Raymond,

>> > [    0.655493] sound hdaudioC1D0: autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
>> > [    0.655494] sound hdaudioC1D0:    speaker_outs=1 (0x15/0x0/0x0/0x0/0x0)
>> > [    0.655495] sound hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
>> > [    0.655496] sound hdaudioC1D0:    mono: mono_out=0x0
>> > [    0.655496] sound hdaudioC1D0:    dig-out=0x1e/0x0
>> > [    0.655497] sound hdaudioC1D0:    inputs:
>> > [    0.655498] sound hdaudioC1D0:      Front Mic=0x19
>> > [    0.655499] sound hdaudioC1D0:      Rear Mic=0x18
>> > [    0.655499] sound hdaudioC1D0:      Line=0x1a
>>
>> > This is a known bug of hda_generic.c for those desktop with internal
>> > speaker and three audio jacks at rear panel (e.g. those lenovo
>> > thinkcenter with alc66x codec)
>>
>> > The driver prefer to assign volume control/dac to headphone, line out and
>> > internal speaker instead of line out and the other two multi io jacks

Thanks to your kind help, I was able to try out several things.

First I tried the multi_io hint

  echo "multi_io = yes" > /sys/class/sound/hwC1D0/hints
  echo 1 > /sys/class/sound/hwC1D0/reconfig

without success.

Then I tried init_verbs

  echo "0x15 0x707 0" > /sys/class/sound/hwC1D0/init_verbs
  echo 1 > /sys/class/sound/hwC1D0/reconfig

again without success.

I went without early patching.

> or You need to increase BAD_MULTI_IO from 0x120 to 0x4120 since
> BAD_NO_DAC 0x4000 for the driver to select config with mio=1

This was successful! But, although I'm very happy with the result and
although I don't mind adding this to my private kernel patches, I'm wondering
whether there isn't a better way, i.e. a way that could help others using the
same or a similar motherboard.

> The driver seem to avoid the playback volume control shared by internal
> speaker, headphone and line out, this may mean that you need a suitable
> name for this volume control

I don't get the meaning of that. Will I miss a volume control or do I have
one with an inappropriate name?

> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/hda_generic.c?id=03ad6a8c93b6df2d65c305b5b5f9474068b45bfb
>
> This patch has side effect on your configuration with three DAC as it
> create "Master playback volume" at node 0x02 and "Speaker+LO Playback
> switch at node 0x14 line out jack

This patch further improves things. I have now the following new controls:

  Headphone    (isn't new, but now only a toggle control, no volume control)
  Speaker+LO   toogle control
  Surround     volume control
  Center       volume control
  LFE          volume control
  Channel Mode allowing 2ch, 4ch, 6ch

>> > Do "pcm playback volume" affect the volume after you change channel mode
>> > from 2ch to 6 ch so that mic and line in jacks are retasked as output ?

The master volume control affects the line out volume (which is named PCM,
btw), but no other output. Muting the master, however, affects all outputs.

After changing to 4ch or 6ch, the PCM (line out) volume control acts as a
"master" for surround and center/lfe.

A quick check seemed to show that all jacks or working input and output, so
thank you very much indeed for your help.

Ingo
