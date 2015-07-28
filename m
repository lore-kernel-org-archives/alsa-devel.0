From: Paulo Roberto de Oliveira Castro <p.oliveira.castro@gmail.com>
Subject: Re: Bug on Dell Vostro 5480 (Intel Wildcat) kernel
	driver
Date: Tue, 28 Jul 2015 00:42:25 -0300
Message-ID: <CAE7bemp+6xfZeuVhdfadpfWAZ28Gf5bnC69MK=XTYfVeTnYO9w@mail.gmail.com>
References: <CAE7bemp1SL2q2h3vkxgAzF=+75kpDvX2aZUck_c70Ujxw3cyvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com
 [209.85.213.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A9C56265109
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 05:42:26 +0200 (CEST)
Received: by igbij6 with SMTP id ij6so99340927igb.1
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 20:42:26 -0700 (PDT)
In-Reply-To: <CAE7bemp1SL2q2h3vkxgAzF=+75kpDvX2aZUck_c70Ujxw3cyvQ@mail.gmail.com>
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

http://hastebin.com/raw/kixaqaloqe

2015-07-28 0:35 GMT-03:00 Paulo Roberto de Oliveira Castro <
p.oliveira.castro@gmail.com>:

> Hi everyone,
>
> After installing Fedora 22 on my Dell Vostro 5480, the speakers don't
> work, and the sound only comes out of the subwoofer. Here is the output
> of alsa-info.sh. After talking to "debianuser" on IRC, we found this
> workaround:
>
> sudo hda-verb /dev/snd/hwC1D0 0x14 SET_PIN_WIDGET_CONTROL 0x40 # enable,
> set it to OUT
> sudo hda-verb /dev/snd/hwC1D0 0x14 SET_CONNECT_SEL 0 # switch to 0x0c
> sudo hda-verb /dev/snd/hwC1D0 0x14 SET_AMP_GAIN_MUTE 0xa000 # unmute left
> sudo hda-verb /dev/snd/hwC1D0 0x14 SET_AMP_GAIN_MUTE 0x9000 # unmute right
>
> We suspect that it's a kernel driver bug. This makes the speakers work
> alongside the headphones (both at the same time) but I need help making
> it working when headphones are not plugged in.
>
> Thanks,
>
> Paulo
>
