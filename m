From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: Intel HDA / ALC662 analog surround problem
Date: Thu, 26 Feb 2015 10:27:56 +0100
Message-ID: <54eee8cd.401a56f7.bm000@wupperonline.de>
References: <CAN8ccibytwovDrBNMtNX6aXW5pOW+5TgPGc4kb6m3ZdbwydHCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout8.wup.tal.de (mout8.wup.tal.de [195.8.233.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B796626147E
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 10:35:13 +0100 (CET)
In-Reply-To: <CAN8ccibytwovDrBNMtNX6aXW5pOW+5TgPGc4kb6m3ZdbwydHCw@mail.gmail.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond,

>> > You have to post the output of alsa-info.sh
>>
>> Please see the attached file.

> [    0.655493] sound hdaudioC1D0: autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
> [    0.655494] sound hdaudioC1D0:    speaker_outs=1 (0x15/0x0/0x0/0x0/0x0)
> [    0.655495] sound hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
> [    0.655496] sound hdaudioC1D0:    mono: mono_out=0x0
> [    0.655496] sound hdaudioC1D0:    dig-out=0x1e/0x0
> [    0.655497] sound hdaudioC1D0:    inputs:
> [    0.655498] sound hdaudioC1D0:      Front Mic=0x19
> [    0.655499] sound hdaudioC1D0:      Rear Mic=0x18
> [    0.655499] sound hdaudioC1D0:      Line=0x1a

> This is a known bug of hda_generic.c for those desktop with internal
> speaker and three audio jacks at rear panel (e.g. those lenovo thinkcenter
> with alc66x codec)

> The driver prefer to assign volume control/dac to headphone, line out and
> internal speaker instead of line out and the other two multi io jacks

> The workaround is to change the internal speaker as not connected node
> 0x15

Could you please advise how to do this? Is it possible from userland or do I
have to patch something?

Would a new fixup mode definition for the kernel help and if yes, how should
it look like, i.e. which pins should be listed? (I'm capable of submitting a
kernel patch.)

> or

> You need to increase badness of multi io so that driver select multi io as
> the best config

I've found your patch from 2013 while googling for the topic. The current
kernel already sets BAD_MULTI_IO = 0x120.

Do you mean to further increase it? If so, to what value, or is increasing
possible from userland?

Ingo
