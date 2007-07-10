From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Alsa lib configure asoundlib.h
Date: Tue, 10 Jul 2007 10:05:12 -0500
Message-ID: <61c0054e0707100805m446a1bf0xbd12d6da6d68fde6@mail.gmail.com>
References: <468D0AFA.20208@tse.gov.br> <s5hwsxd50fg.wl%tiwai@suse.de>
	<s5h3azwl5p2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 5500D1038D3
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2007 17:05:13 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so1136393mue
	for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2007 08:05:12 -0700 (PDT)
In-Reply-To: <s5h3azwl5p2.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Fausto Carvalho Marques SIlva <fausto@tse.gov.br>
List-Id: alsa-devel@alsa-project.org

On 7/10/07, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Fri, 06 Jul 2007 11:46:59 +0200,
> I wrote:
> >
> > At Thu, 05 Jul 2007 12:15:06 -0300,
> > Fausto Carvalho Marques SIlva wrote:
> > >
> > > In salsa library(this library really saved my life, from am alsa-lib
> of
> > > 600K to 45K!!!), developed by Takashi Iwai, the creation of
> asoundlib.h
> > > is dynamic and based on the configure options ( --disable-mixer will
> > > remove mixer.h from asoundlib.h).
> > > Can alsa-lib do the same??I think it is a good "cleanup" way of doing
> > > client header files.



I really like the idea of Salsa as well. I have built both ALSA-libs and
SALSA-libs for my ARM SoC system. However, there are a lot of features I am
sure I do not need, e.g. mixer. I would like to build the minimal SALSA
system for playing and capturing audio through a PCM interface. The audio is
mono, 8k sample rate with no sw audio control, etc. What tags can I add to
get the smallest possible SALSA build. Currently I am doing this:

CC=arm-linux-gcc ./configure --target=arm-linux --host=i686-pc-linux-gnu
--with-versioned=no --disable-mixer

then

make install DESTDIR=$HOME/Linux_Builds/buildroot/build_arm/root/

But am still getting about a 400k addition to my rootfs. Anyway to make that
smaller?

Thanks.

Paul
-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
