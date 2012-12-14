From: =?UTF-8?Q?Nicolas_Ma=C3=AEtre?= <nimai@skynet.be>
Subject: Fwd: Request for HW auto-recognition: HP Pavilion dv7
 with STAC92xx
Date: Fri, 14 Dec 2012 22:12:18 +0100
Message-ID: <CACd4Q01r58JL3hD49mtT97+7Jkdpr8Sgfni88wHfsE79_dTP6A@mail.gmail.com>
References: <CACd4Q01r1Oa=ds0+eskdkvnMJytuLRj5FPYyNjbdnx5WNWWZvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 8995A264F10
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2012 22:12:38 +0100 (CET)
Received: by mail-wi0-f169.google.com with SMTP id hq12so874971wib.2
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2012 13:12:38 -0800 (PST)
In-Reply-To: <CACd4Q01r1Oa=ds0+eskdkvnMJytuLRj5FPYyNjbdnx5WNWWZvQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

At Wed, 12 Dec 2012 18:08:25 +0100,
Tomas Pospisek wrote:
>
> Hello,
>
> I have a HP Pavilion dv7 laptop (LS066EA#UUZ), with:
>
>   # cat /proc/asound/card0/codec* | grep Codec
>   Codec: IDT 92HD81B1X5
>   Codec: Intel CougarPoint HDMI
>
> when play sound without any tweaks, I get a very weak sound output. If I
> want to have "beats audio", that is subwoofer and all speakers, I need to
> set:
>
>   # cat /etc/modprobe.d/alsa-base.conf
>   options snd-hda-intel model=hp-dv7-4000
>
> Could the snd_hda_intel alsa driver be updated to recognize and setup the
> driver accordingly?
>
> alsa-info.sh output here:
>
>
> http://www.alsa-project.org/db/?f=54ea874f43f12c1572aff3ee3113dc4b0ad0b398

I'm not quite sure that I have the exact same hardware, but I think
so. I have 5 speakers (rear left and right, front left and right +
subwoofer)
Here is my alsa-info:
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1056669/+attachment/3459484/+files/alsa-info.txt.lYaCjHLUA1
In my case, model=hp-dv7-4000 doesn't fully solve the problem. The
subwoofer works but it is not mapped as such.
After some tests, it seems that the alsa's speakers rear left and rear
right are mapped to the subwoofer. The front ones are alright.
With the model=hp-dv5 that I'm using, the subwoofer isnt recognized at
all, but the rear speakers are correctly mapped.

Also, with hp-dv7-4000, the internal microphone is still used when a
micro jack is plugged in. That's not the case with hp-dv5.

If you think there's a configuration issue on my side, please let me
know, but I think hp-dv5 is actually a better default choice if I have
to choose between both.

Kind regards,

--
nimai
