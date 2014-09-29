From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [BUG] Bad decibel data on C-Media USB sound card
Date: Mon, 29 Sep 2014 23:41:46 +0800
Message-ID: <CAN8cciaSwf80EVw0s3QC0KENCwgBTmTSKrMw_b4ba0iTWD03tg@mail.gmail.com>
References: <CAPMSj_GXkHE6L8+X6niN2q2OSJ0_N4Rv=CYS4cGOv2cVz9WZNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f53.google.com (mail-qg0-f53.google.com
 [209.85.192.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B78B260607
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 17:41:48 +0200 (CEST)
Received: by mail-qg0-f53.google.com with SMTP id a108so930465qge.40
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 08:41:46 -0700 (PDT)
In-Reply-To: <CAPMSj_GXkHE6L8+X6niN2q2OSJ0_N4Rv=CYS4cGOv2cVz9WZNw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Allen M." <ase1592@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> >What is the value of the "Headphone Playback Volume" mixer control
> >(as shown by "amixer contents") above and below this threshold?
>
> using "amixer --device hw:Set contents"
> 36% yields "values=8,8"
> 34% yields "values=0,0"
>
> interestingly, using "alsamixer" shows that while (default) reports 36%,
> the C-media device reports 3%

Card: C-Media USB Headphone Set at usb-0000:00:12.0-1, full speed Unit: 9
Control: name="Headphone Playback Volume", index=0 Info: id=9, control=2,
cmask=0x3, channels=2, type="S16" Volume: min=-7264, max=-16, dBmin=-2837,
dBmax=-6

Unit: 10 Control: name="Auto Gain Control", index=0 Info: id=10, control=7,
cmask=0x0, channels=1, type="BOOLEAN" Volume: min=0, max=1, dBmin=0, dBmax=0

Do the automatic gain has any side effect when it normalise the volume?

Do you mean the sound card does not has 7248 steps ?

http://www.freedesktop.org/wiki/Software/PulseAudio/Backends/ALSA/Decibel/

You need to find out the value of c->res

https://bugzilla.redhat.com/show_bug.cgi?id=1065097

As you complain dB range -28.37 to -0.06 are not correct

You need to calibrate the dB range

https://bugs.freedesktop.org/show_bug.cgi?id=46236
