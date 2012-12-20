From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Fwd: Request for HW auto-recognition: HP Pavilion
 dv7 with STAC92xx
Date: Thu, 20 Dec 2012 08:24:16 +0800
Message-ID: <CAN8ccibkg5intFjngUs37nJ5T+iiq5NPA2B=yP0T5fuecYfymg@mail.gmail.com>
References: <CACd4Q01r1Oa=ds0+eskdkvnMJytuLRj5FPYyNjbdnx5WNWWZvQ@mail.gmail.com>
 <CACd4Q01r58JL3hD49mtT97+7Jkdpr8Sgfni88wHfsE79_dTP6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f172.google.com (mail-ia0-f172.google.com
 [209.85.210.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 036D526515B
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 01:24:17 +0100 (CET)
Received: by mail-ia0-f172.google.com with SMTP id z13so2386329iaz.3
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2012 16:24:16 -0800 (PST)
In-Reply-To: <CACd4Q01r58JL3hD49mtT97+7Jkdpr8Sgfni88wHfsE79_dTP6A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Nicolas_Ma=C3=AEtre?= <nimai@skynet.be>, tpo2@sourcepole.ch, taiwai@suse.de, seastland@gmail.com
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> >
> > I have a HP Pavilion dv7 laptop (LS066EA#UUZ), with:
> >
> >   # cat /proc/asound/card0/codec* | grep Codec
> >   Codec: IDT 92HD81B1X5
> >   Codec: Intel CougarPoint HDMI
> >
> >
http://www.alsa-project.org/db/?f=54ea874f43f12c1572aff3ee3113dc4b0ad0b398
>
> I'm not quite sure that I have the exact same hardware, but I think
> so. I have 5 speakers (rear left and right, front left and right +
> subwoofer)
> Here is my alsa-info:
>
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1056669/+attachment/3459484/+files/alsa-info.txt.lYaCjHLUA1
> In my case, model=hp-dv7-4000 doesn't fully solve the problem. The
> subwoofer works but it is not mapped as such.

Do you mean node 0x0d is the subwoofer and node 0x0f is the internal
speaker ?

static const unsigned int hp_dv7_4000_pin_configs[10] = {
- 0x03a12050, 0x0321201f, 0x40f000f0, 0x90170110,
+ 0x03a12050, 0x0321201f, 0x40f000f0, 0x90170111,
0x40f000f0, 0x40f000f0, 0x90170110, 0xd5a30140,
0x40f000f0, 0x40f000f0,
};
