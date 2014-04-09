From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: 2.1 audio not working in Kubuntu 13.10
Date: Wed, 9 Apr 2014 10:28:43 +0800
Message-ID: <CAN8cciZhGuEbjmgOAHmYAY75iZeDBEfXDiD0UvryDtzofZiWcQ@mail.gmail.com>
References: <CAL8wzGRtAVhL2dioHRL-7rtZjSCRduBfWpdpZHTxEnp22i=ftA@mail.gmail.com>
 <CAN8cciYEA3zo3KzqCrZwOZi+COc6itBpAnsD+8OiegXiBT9ryQ@mail.gmail.com>
 <CAL8wzGRodjLPznk8VTtMDgpuq4XcMSfgw6t66VDhsxNbkTyhFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f51.google.com (mail-qg0-f51.google.com
 [209.85.192.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 27B7B2656F7
 for <alsa-devel@alsa-project.org>; Wed,  9 Apr 2014 04:28:46 +0200 (CEST)
Received: by mail-qg0-f51.google.com with SMTP id q108so1693730qgd.38
 for <alsa-devel@alsa-project.org>; Tue, 08 Apr 2014 19:28:43 -0700 (PDT)
In-Reply-To: <CAL8wzGRodjLPznk8VTtMDgpuq4XcMSfgw6t66VDhsxNbkTyhFw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomas Black <tomas.black@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

z

>
>
> thanks for your answer.
>
> I checked the Dell thread and the Realtek datasheet. I see it's possible
> to connect to external 5.1 (or 2.1) sound system.
>
> However I want to make it work with the *internal *2 speakers + *internal
> *subwoofer.
>
> I've read tons of links and similar threas, it seems it is not possible
> under linux :-(
>
>
how did you test 2.1 speakers ?


http://voices.canonical.com/david.henningsson/2011/11/29/turn-your-mic-jack-into-a-headphone-jack/

have you try hda-jack-retask to fix the pin default of missing subwoofer ?


do you mean surround21 setup does not work ?

http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=48f1b308cc66152eb6db66742dd0d08d888cda8d

https://launchpadlibrarian.net/90274068/Card0.Codecs.codec.0.txt


if node 0x17 does not work, you need to try the other unconnected stereo
pin complex (e.g. node 0x16 , 0x18, 0x21)

0x99130111

using hda-emu with pin fixup,

do you mean no sound when the two headphone jack share the same volume
control ?


autoconfig: line_outs=2 (0x15/0x17/0x0/0x0/0x0) type:speaker
   speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
   hp_outs=2 (0x1b/0x19/0x0/0x0/0x0)
   mono: mono_out=0x0
   dig-out=0x1e/0x0
   inputs:
     Internal Mic=0x12
     Mic=0x1a


==> Best config: lo_type=1, wired=1, mio=1
multi_outs = 15/17/0/0 : 3/2/0/0 (type SP)
  out path: depth=3 :03:0d:15
  out path: depth=3 :02:0f:17
hp_outs = 1b/19/0/0 : 4/4/0/0
  hp  path: depth=3 :04:0e:1b
  hp  path: depth=3 :04:0e:19

CTRL: add: Speaker Playback Volume:0
CTRL: add: Speaker Playback Switch:0
CTRL: add: Bass Speaker Playback Volume:0
CTRL: add: Bass Speaker Playback Switch:0
CTRL: add: Headphone Playback Volume:0
CTRL: add: Headphone Playback Switch:0
CTRL: add: Headphone Playback Switch:1
