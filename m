From: Fausto Carvalho Marques SIlva <fausto@tse.gov.br>
Subject: Re: Alsa lib configure asoundlib.h
Date: Tue, 10 Jul 2007 16:59:42 -0300
Message-ID: <4693E52E.7070508@tse.gov.br>
References: <468D0AFA.20208@tse.gov.br>
	<s5hwsxd50fg.wl%tiwai@suse.de>	<s5h3azwl5p2.wl%tiwai@suse.de>
	<61c0054e0707100805m446a1bf0xbd12d6da6d68fde6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dexter.tse.gov.br (dexter.tse.gov.br [200.252.157.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 601E91037F2
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2007 22:03:19 +0200 (CEST)
In-Reply-To: <61c0054e0707100805m446a1bf0xbd12d6da6d68fde6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Kavan <pkavan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Kavan wrote

> <>I really like the idea of Salsa as well. I have built both ALSA-libs and
> SALSA-libs for my ARM SoC system. However, there are a lot of features 
> I am
> sure I do not need, e.g. mixer. I would like to build the minimal SALSA
> system for playing and capturing audio through a PCM interface. The 
> audio is
> mono, 8k sample rate with no sw audio control, etc. What tags can I add to
> get the smallest possible SALSA build. Currently I am doing this:
>
> CC=arm-linux-gcc ./configure --target=arm-linux --host=i686-pc-linux-gnu
> --with-versioned=no --disable-mixe
> then
>
> make install DESTDIR=$HOME/Linux_Builds/buildroot/build_arm/root/
>
> But am still getting about a 400k addition to my rootfs. Anyway to 
> make that
> smaller?

Alsa-lib is really big... I could make it in 340K but Salsa-lib is 45K 
(stripped and dynamic).
The default compilation of salsa-lib  gives a 166K(with strip turns to 
45K) you could remove more things like:
--diable-mixer, but i think is only this...(35K without mixer)


Teh

> <>
> Thanks.
>
> Paul
