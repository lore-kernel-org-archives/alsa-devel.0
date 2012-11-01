From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Fix for Asus G75 notebook subwoofer
Date: Thu, 1 Nov 2012 16:11:19 +0800
Message-ID: <CAN8cciZEwLxxiMp69k8yyAzSnqRNQ6m2=7q373x91D_pMy=h-w@mail.gmail.com>
References: <k6rkr2$usv$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 90D9C261710
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 09:11:20 +0100 (CET)
Received: by mail-qc0-f179.google.com with SMTP id b14so1466209qcs.38
 for <alsa-devel@alsa-project.org>; Thu, 01 Nov 2012 01:11:19 -0700 (PDT)
In-Reply-To: <k6rkr2$usv$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Massimo Del Fedele <max@veneto.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> This code fixes surround path of asus G75; i'll drop here as a function
to be called
> before codec initialization (I did it in static int patch_vt2002P() )
because I don't
> know how to detect the notebook and apply it only when needed (I'm new to
alsa code).
>
> /* Fixes for Asus G75 subwoofer
>    pin 24 is marked as speaker by bios -- should mark as line
>    pin 33 has a wrong connection to out-of-range nid #3e
> */

can you post the output of alsa-info.sh ?

http://git.kernel.org/?p=linux/kernel/git/tiwai/hda-emu.git;a=blob_plain;f=codecs/vt1802-asus-u30s;hb=HEAD

   9.337454] ALSA hda_codec.c:4877 autoconfig: line_outs=1
(0x24/0x0/0x0/0x0/0x0) type:speaker
[    9.337458] ALSA hda_codec.c:4881    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    9.337460] ALSA hda_codec.c:4885    hp_outs=1 (0x25/0x0/0x0/0x0/0x0)
[    9.337462] ALSA hda_codec.c:4886    mono: mono_out=0x0
[    9.337464] ALSA hda_codec.c:4889    dig-out=0x2d/0x0
[    9.337465] ALSA hda_codec.c:4890    inputs:
[    9.337467] ALSA hda_codec.c:4894  Internal Mic=0x29
[    9.337469] ALSA hda_codec.c:4894  Mic=0x2b

it is the auto parser put the speaker to autocfg->lineout

vt1802 also has connection to 0x3e in node 0x24 and 0x33

you cannot change the pin default from speaker of 0x24 to lineout if node
0x33 only support mono

should the auto parser put it into autocfg->mono_out?
