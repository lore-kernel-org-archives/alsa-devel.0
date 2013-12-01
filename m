From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [pulseaudio-discuss] What-did-you-plugin-dialog
Date: Sun, 1 Dec 2013 13:49:15 +0800
Message-ID: <CAN8ccibLpVXqcHHdJwfv=_FF8z2hE6frsY8Gg6NRNQibsu2Okw@mail.gmail.com>
References: <52947A6E.6010302@canonical.com>
 <1385470453.2226.26.camel@tkkaskin-mobl2.ger.corp.intel.com>
 <52949CCA.2060601@canonical.com>
 <1385473638.2226.48.camel@tkkaskin-mobl2.ger.corp.intel.com>
 <52951347.9000200@canonical.com> <5295A121.2010202@gmail.com>
 <5295A7C2.2090100@canonical.com>
 <CAN_LGv1F4cTB2cK+rL30N3nbbwyxi23cLYHR6emMC5CbNLP4jQ@mail.gmail.com>
 <CAN_LGv0y2WcYMn8M5rjT1d-2jahh_u-W2D_LnRkMsXXD=ENzdA@mail.gmail.com>
 <CAN8cciZ-y397dLGV_xC3xibo3PY9aE-RYQEB4_dkwRtzN+JnqQ@mail.gmail.com>
 <CAN_LGv02cPydDkvP-AZ+EzkF9TVvm1ij0-6vjzp0YWbieg7_fQ@mail.gmail.com>
 <CAN8cciYnQZQzyRmz_=gLLF6w7p3CZbZPKwYZtJpTHEaN3UOt_Q@mail.gmail.com>
 <CAN_LGv0F6g6L41Se72zdaq4u0DAPJzRc4ZwCMqPPJ06TCFS=qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id D58CE260859
 for <alsa-devel@alsa-project.org>; Sun,  1 Dec 2013 06:49:16 +0100 (CET)
Received: by mail-ie0-f169.google.com with SMTP id e14so19125866iej.28
 for <alsa-devel@alsa-project.org>; Sat, 30 Nov 2013 21:49:15 -0800 (PST)
In-Reply-To: <CAN_LGv0F6g6L41Se72zdaq4u0DAPJzRc4ZwCMqPPJ06TCFS=qA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>>

> >> Before retasking:
> >>
> >>
> http://www.alsa-project.org/db/?f=fd97b8194e205b4f91127bca74ad7c9b2cd93ab9
> >>
> >> After retasking blue line in, pin ID 0x1a as Line out (Side):
> >>
> >>
> http://www.alsa-project.org/db/?f=d56f9a6d0692c9a8d5c88f43100a6cb78407c163
> >>
> >> Note that retasking did not work: attempting to play a 8-channel wav
> >> file through hw:1,0 resulted in an "Invalid argument" error.
> >>
> >> FWIW, here is what hdajackretask printed to the console:
> >>
> >> 0x11 0x99430130
> >> 0x12 0x4037c540
> >> 0x14 0x01014010
> >> 0x15 0x01011012
> >> 0x16 0x01016011
> >> 0x17 0x411111f0
> >> 0x18 0x01a19050
> >> 0x19 0x02a19060
> >> 0x1a 0x01014413
> >> 0x1b 0x02214020
> >> 0x1c 0x411111f0
> >> 0x1d 0x4045e601
> >> 0x1e 0x01452140
> >> 0x1f 0x411111f0
> >> 1
> >>
> >
> > you need root privilege for hdajackretask to write the firmware file to
> > /lib/firmware and modify /etc/modprobe.d/alsa-lbase.conf to use the
> firmware
> > file
> >
> > can you try the patch which add "channel mode" control which allow you to
> > switch from 6ch to 8ch
>
> I have tested the patch. In 8ch mode, it works without any overrides
> in the sense that the side channels go to the blue jack if I choose
> 8ch mode. In the 6ch mode, the line input also works (tested by using
> headphones as a very bad microphone-like source).
>
> Here is alsa-info in the 6ch mode:
>
> http://www.alsa-project.org/db/?f=d152698d4b2d9589d4c5f14e0c8e6d4978c8fbd0
>
> And in 8ch mode:
>
> http://www.alsa-project.org/db/?f=4d5d14fbb559819fd82e7731e656be7efcfab439
>
> Pulseaudio is not smart enough to decide by itself that it can toggle
> the control and add 7.1 profiles. If I toggle the control manually and
> restart pulseaudio, they appear.
>
> If the role of the "Line jack" control is still unclear, just say so
> and tell me what to do to figure it out.
>
>
http://cgit.freedesktop.org/pulseaudio/pulseaudio/plain/src/modules/alsa/mixer/paths/analog-input-linein.conf

pulseaudio use "Line Jack" to determine whether line in is available or not

In 8ch mode, do the "Line jack" return true when you plugged "Side Speaker"
?

pactl list

should "line in" list as not available when channel mode changed to "8 ch" ?


Should changes in "channel mode" , "Headphone Mic jack mode" or "Mic Jack
Mode" trigger an event so that pulseaudio server probe the sound card again
?

There is still bug in the patch

should check (cfg->line_out + spec->multi_ios) >= 3 instead of
spec->multi_ios > 0 so that the channel mode is not added for notebook with
line out and mic jack
