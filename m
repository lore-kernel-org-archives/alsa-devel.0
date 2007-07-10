From: "J. Scott Merritt" <AlsaUser@PragmaSoft.com>
Subject: Re: Alsa lib configure asoundlib.h
Date: Tue, 10 Jul 2007 16:04:23 -0400
Message-ID: <20070710160423.748e5cd6.AlsaUser@PragmaSoft.com>
References: <468D0AFA.20208@tse.gov.br> <s5hwsxd50fg.wl%tiwai@suse.de>
	<s5h3azwl5p2.wl%tiwai@suse.de>
	<61c0054e0707100805m446a1bf0xbd12d6da6d68fde6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from starfish.geekisp.com (mail.geekisp.com [216.168.135.169])
	by alsa0.perex.cz (Postfix) with ESMTP id D0F84103853
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2007 22:05:35 +0200 (CEST)
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

On Tue, 10 Jul 2007 10:05:12 -0500
"Paul Kavan" <pkavan@gmail.com> wrote:

> On 7/10/07, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > At Fri, 06 Jul 2007 11:46:59 +0200,
> > I wrote:
> > >
> > > At Thu, 05 Jul 2007 12:15:06 -0300,
> > > Fausto Carvalho Marques SIlva wrote:
> > > >
> > > > In salsa library(this library really saved my life, from am alsa-lib
> > of
> > > > 600K to 45K!!!), developed by Takashi Iwai, the creation of
> > asoundlib.h
> > > > is dynamic and based on the configure options ( --disable-mixer will
> > > > remove mixer.h from asoundlib.h).
> > > > Can alsa-lib do the same??I think it is a good "cleanup" way of doing
> > > > client header files.
> 
> 
> 
> I really like the idea of Salsa as well. I have built both ALSA-libs and
> SALSA-libs for my ARM SoC system. However, there are a lot of features I am
> sure I do not need, e.g. mixer. I would like to build the minimal SALSA
> system for playing and capturing audio through a PCM interface. The audio is
> mono, 8k sample rate with no sw audio control, etc. What tags can I add to
> get the smallest possible SALSA build. Currently I am doing this:
> 
> CC=arm-linux-gcc ./configure --target=arm-linux --host=i686-pc-linux-gnu
> --with-versioned=no --disable-mixer
> 
> then
> 
> make install DESTDIR=$HOME/Linux_Builds/buildroot/build_arm/root/
> 
> But am still getting about a 400k addition to my rootfs. Anyway to make that
> smaller?

Perhaps you just need to run the "strip" tool to remove symbols from the
Object file ?
