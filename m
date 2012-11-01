From: Massimo Del Fedele <max@veneto.com>
Subject: Re: Fix for Asus G75 notebook subwoofer
Date: Thu, 01 Nov 2012 12:15:14 +0100
Message-ID: <k6tlk1$2vr$1@ger.gmane.org>
References: <k6rkr2$usv$1@ger.gmane.org>
 <CAN8cciZEwLxxiMp69k8yyAzSnqRNQ6m2=7q373x91D_pMy=h-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id DFBB0261735
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 12:15:29 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1TTskJ-0002Oz-2T
 for alsa-devel@alsa-project.org; Thu, 01 Nov 2012 12:15:35 +0100
Received: from host126-249-dynamic.4-87-r.retail.telecomitalia.it
 ([87.4.249.126]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 01 Nov 2012 12:15:35 +0100
Received: from max by host126-249-dynamic.4-87-r.retail.telecomitalia.it with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 01 Nov 2012 12:15:35 +0100
In-Reply-To: <CAN8cciZEwLxxiMp69k8yyAzSnqRNQ6m2=7q373x91D_pMy=h-w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Il 01/11/2012 09:11, Raymond Yau ha scritto:

>
> can you post the output of alsa-info.sh ?

Where can I find the script ? I've not it on my machine
>
> http://git.kernel.org/?p=linux/kernel/git/tiwai/hda-emu.git;a=blob_plain;f=codecs/vt1802-asus-u30s;hb=HEAD
>
>     9.337454] ALSA hda_codec.c:4877 autoconfig: line_outs=1
> (0x24/0x0/0x0/0x0/0x0) type:speaker
> [    9.337458] ALSA hda_codec.c:4881    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [    9.337460] ALSA hda_codec.c:4885    hp_outs=1 (0x25/0x0/0x0/0x0/0x0)
> [    9.337462] ALSA hda_codec.c:4886    mono: mono_out=0x0
> [    9.337464] ALSA hda_codec.c:4889    dig-out=0x2d/0x0
> [    9.337465] ALSA hda_codec.c:4890    inputs:
> [    9.337467] ALSA hda_codec.c:4894  Internal Mic=0x29
> [    9.337469] ALSA hda_codec.c:4894  Mic=0x2b
>
> it is the auto parser put the speaker to autocfg->lineout

Yep, if you look at above, this one was exactly the output before my 2 patches; the only difference
was line 24, marked as type=SPEAKER; no trace of mono pin 0x33.
I guess the 0x33 is skipped because the parser don't find a path from it, as it have a connection to
widget 0x3e with is out of range (widgets are reported to be from 0x08 to 0x0c).
We could also patch the returned widget number to be 2 widgets more, even id 0x3d is NOT there.
>
> vt1802 also has connection to 0x3e in node 0x24 and 0x33

The 0x3e is a stereo to mono mixer, connecting to 0x1c.
As above, VT1802p reports to have widgets up to 0x3c.
>
> you cannot change the pin default from speaker of 0x24 to lineout if node
> 0x33 only support mono
>
> should the auto parser put it into autocfg->mono_out?
>

maybe.... I didn't try that one.
With both patches the stuffs appears like a 4 channel one; the correct would be 2+1, but
I didn't manage to get it right.

Anyways, I did all this without datasheet... I've tried to get it from VIA, with usual (null) results.
Maybe the 2 exceeding widgets are reported there, I don't know.

Resuming, without patches, the auto_parser report for asus :

0x24 Line out, type speaker
0x25 Hp out
0x33 is missing

Forcing the connection from 0x33 to 0x1c (skipping so 0x3e) the pin 0x33 don't appear
because bios marks it at none-connection.
Forcing the connection to JACK, it puts as a mono speaker, so no sound from it either.
Forcing to be a line out, sound only from it because then 0x24 takes the speaker place (marked as speaker in bios).
Forcing both 0x24 and 0x33 to be line out gives 4 channel sound (with 2 rear channels output to 0x33 mono).

No idea on how to get the 2+1 behaviour, but at least now it sounds.

Max
