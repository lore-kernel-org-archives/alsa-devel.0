From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: dmix - unable to open slave
Date: Wed, 26 Oct 2011 11:24:17 +0800
Message-ID: <CAHG8p1BWkaaLQ_NEzt5FpnHPFLioFa-38maHG1=Xz3GccLk5fw@mail.gmail.com>
References: <5118DCBF03F5431599E4728F6F1B6DA1@domain.local>
	<CAHG8p1C=-faa-nysrUoC45NnXQukaGdYk1oCe84aUb-sAUMr_w@mail.gmail.com>
	<CE026379887849589B21F7999D71754D@domain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2BB2524818
	for <alsa-devel@alsa-project.org>;
	Wed, 26 Oct 2011 05:24:20 +0200 (CEST)
Received: by vws20 with SMTP id 20so1216772vws.38
	for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2011 20:24:19 -0700 (PDT)
In-Reply-To: <CE026379887849589B21F7999D71754D@domain.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nenad Sljivic <nenad.sljivic@rt-rk.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/10/25 Nenad Sljivic <nenad.sljivic@rt-rk.com>:
> Hello Scott,
>
> Thanks a lot for your reply. My project is totally blocked due to this
> issue. I would really appreciate your help.
>
> Are you referring to this entry:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2011-September/04339=
3.h
> tml
> =A0?
>
> Could you elaborate your solution a little more ?
>
> What do you mean by:
> " I add driver_name in my snd_soc_card to solve this bug. "
>
Mark has committed a patch to fix this in asoc core.
you can cat /proc/asound/cards to find the card driver name, then you
must modify your config file to match this.

Scott
