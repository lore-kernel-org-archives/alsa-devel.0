From: Ian Munsie <darkstarsword@gmail.com>
Subject: Re: No sound from internal speaker on 2013 Macbook Air
 6, 1
Date: Tue, 10 Sep 2013 01:48:05 +1000
Message-ID: <CAH4=b6L=+_zZ0MeELKkVi_wnLDCDi1ETCCp5PH9rgXn8JgNfZg@mail.gmail.com>
References: <CAH4=b6KOs-WJ+_KVGiQ4LRC9-3J_A_xK64UcrMq6NZFxyycS_w@mail.gmail.com>
 <CAN8cciZuiRR9=iqkxYLoj==UXqYzEdVM2M85y5vg6zBYArjhSQ@mail.gmail.com>
 <CAH4=b6Km5E5v18bvKqV661kudaKkpfnHGUWNEeGEY7ngXVARnw@mail.gmail.com>
 <s5h61uabc4l.wl%tiwai@suse.de>
 <CAH4=b6+KtfWnWcY6NyP_Ls7bPGHBCnhkPJjVqDSeFUJ2Ltz=4g@mail.gmail.com>
 <s5hwqmq9vgb.wl%tiwai@suse.de>
 <CAH4=b6LM4fexo4QpFeP1Nn9X77BcGExaL8-WkQ5Q-9chioKpRQ@mail.gmail.com>
 <s5ha9jm9jeu.wl%tiwai@suse.de>
 <CAH4=b6K1d+kkbF5m72A=GALJPa59rPrg5K3FspG1_OxBcp_3dA@mail.gmail.com>
 <s5h4n9u9h3h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f175.google.com (mail-ea0-f175.google.com
 [209.85.215.175])
 by alsa0.perex.cz (Postfix) with ESMTP id A36AD2650EE
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 17:48:25 +0200 (CEST)
Received: by mail-ea0-f175.google.com with SMTP id m14so3208965eaj.6
 for <alsa-devel@alsa-project.org>; Mon, 09 Sep 2013 08:48:25 -0700 (PDT)
In-Reply-To: <s5h4n9u9h3h.wl%tiwai@suse.de>
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
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> Check the value output by
>
>    hda-verb /dev/snd/hwC0D0 0x10 SET_PIN_SENSE 0
>    hda-verb /dev/snd/hwC0D0 0x10 GET_PIN_SENSE 0
>
> before and after plugging the headphone.
> Normally, the second line should show 0x80000000 after plugging the
> jack.

Doesn't look like it:

ian@button~ [i]> sudo hda-verb /dev/snd/hwC0D0 0x10 SET_PIN_SENSE 0
nid = 0x10, verb = 0x709, param = 0x0
value = 0x0
ian@button~ [i]> sudo hda-verb /dev/snd/hwC0D0 0x10 GET_PIN_SENSE 0
nid = 0x10, verb = 0xf09, param = 0x0
value = 0x0

<plug in headphones>

ian@button~ [i]> sudo hda-verb /dev/snd/hwC0D0 0x10 SET_PIN_SENSE 0
nid = 0x10, verb = 0x709, param = 0x0
value = 0x0
ian@button~ [i]> sudo hda-verb /dev/snd/hwC0D0 0x10 GET_PIN_SENSE 0
nid = 0x10, verb = 0xf09, param = 0x0
value = 0x0

> If it shows only zero for both plug/unplug, either the headphone pin
> assignment is wrong or the jack detection is broken.  In the former
> case, you can check by adjusting the headphone volume or mute mixer
> control and see whether it really happens on the machine.

I can confirm that adjusting the headphone volume & mute with
alsamixer does correctly adjust the headphone volume, so I guess the
jack detection isn't working.

It seems that pulseaudio was doing some funny things with the mute
controls (muting any one of headphones, speakers & master would mute
all three & all would have to be individually unmuted before getting
sound again - I guess pulseaudio doesn't expect anyone to adjust the
sound card mixer directly while it is running), so I temporarily
uninstalled it again for this test.


One other weird thing I noticed while testing this is that setting the
volume to 0% and/or muting does the controls does not seem to
completely mute the sound - it is just really quiet (quiet enough not
to be an issue for me). Some observations:

__Speakers__
Master: Mute AND/OR Speakers: Mute
--> Speakers are muted.

Master: 0% AND Speakers: 0%
--> Sound still comes from speakers, but is very quiet.

Master: 0%
--> speaker control affects volume.

__Headphones__
Master: 0% AND/OR Headphones: 0%
--> Sound still comes from headphones at low volume
(if either control is 0%, the volume of the other control has no
effect - both have to be non-zero to raise the volume).

Master: Mute AND/OR Headphones: Mute
--> Sound still comes from headphones, though is fairly quiet (much
lower than 0%).

Cheers,
-Ian

-- 
http://sites.google.com/site/DarkStarJunkSpace
--
http://darkstarshout.blogspot.com/
--
Please avoid sending me Word or PowerPoint attachments.
See http://www.gnu.org/philosophy/no-word-attachments.html
