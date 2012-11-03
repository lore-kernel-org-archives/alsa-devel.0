From: Massimo Del Fedele <max@veneto.com>
Subject: Re: Fix for Asus G75 notebook subwoofer
Date: Sat, 03 Nov 2012 10:04:01 +0100
Message-ID: <k72mm0$os$1@ger.gmane.org>
References: <k6rkr2$usv$1@ger.gmane.org>
 <CAN8cciZEwLxxiMp69k8yyAzSnqRNQ6m2=7q373x91D_pMy=h-w@mail.gmail.com>
 <k6tlk1$2vr$1@ger.gmane.org>
 <CAN8cciZQw8m-m-Bk6KF2UuqpU2a5=Y7vAi7daWmqF9vbA2w=4g@mail.gmail.com>
 <k70n1l$65a$1@ger.gmane.org>
 <CAN8ccia86GNJrXkDQM9zxrcBD6+5oqTYn6wk-ZVamW0VV1iQOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D0DB2602AC
 for <alsa-devel@alsa-project.org>; Sat,  3 Nov 2012 10:04:13 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1TUZeO-0000xq-4Z
 for alsa-devel@alsa-project.org; Sat, 03 Nov 2012 10:04:20 +0100
Received: from host97-251-dynamic.0-87-r.retail.telecomitalia.it
 ([87.0.251.97]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 03 Nov 2012 10:04:20 +0100
Received: from max by host97-251-dynamic.0-87-r.retail.telecomitalia.it with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 03 Nov 2012 10:04:20 +0100
In-Reply-To: <CAN8ccia86GNJrXkDQM9zxrcBD6+5oqTYn6wk-ZVamW0VV1iQOA@mail.gmail.com>
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

Il 03/11/2012 01:37, Raymond Yau ha scritto:
> https://launchpadlibrarian.net/121871263/alsainfo.txt
>
> do your patched driver really work with pulseaudio 2.0 if there is no
> headphone playback volume controls ?
>
Yep... behaviour is following :

if NO headphone plugged in, I can choose between stereo and 4 channel surround.
With pulse I can then balance left/right and front/rear channels, and set the
overall sound volume.
The output selector of pulseaudio shows just "analog output".

if headset is plugged in, output audio selector shows both "analog output" and "headphone output",
but no matters what I select, output of front channelsgoes to HP, and rear channels are disabled.
I guess the output selector switch should work, but it doesn't and audio goes always to HP when plugged.

>
> if independent headphone is ON, two different audio stereo streams can play
> using device 0 (speaker) and device 2 (headphone)

Can't obviously have indep HP mode AND 2+1 channels, having just 2 volume controls.
Maybe it would be possible to have indep HP mode when selecting stereo mode output,
but I don't see much use for it.
>
> dac 0x08 cannot be shared beween headphone 0x25 and speaker 0x24
>
> do a notebook really need independent headphone ?

When I said "shared" I meant "alternative"; channel 8 is used for HP when plugged, for front speakers
when unplugged; I can't hear both together, and I think it's correct behaviour, having just 2 volume
widgets inside VT1802P.
Plugged HP completely disables both subwoofer and front speakers; this should be selectable by pulse
output selector, but it doesn't.... Bu I guess that one is another bug.


Max
