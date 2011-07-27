From: Wayne Tams <wayne.tams@gmail.com>
Subject: Re: Problem trying to add ASoC ADAV801 support to my
	kernel
Date: Wed, 27 Jul 2011 15:18:12 +0100
Message-ID: <CAN=k24n9+rEVACGczgX5wJQAECNf3vE6kVSt1WK+ZMPnuQsGyA@mail.gmail.com>
References: <CAN=k24m3f0=rXKDrbK+9qNm6Qhwcm7aJf1_Fm4309+zWkF0p7w@mail.gmail.com>
	<4E2FC7BF.7090500@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F0A7724154
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jul 2011 16:18:33 +0200 (CEST)
Received: by iyn35 with SMTP id 35so1944319iyn.38
	for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2011 07:18:32 -0700 (PDT)
In-Reply-To: <4E2FC7BF.7090500@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 27, 2011 at 9:09 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 07/26/2011 03:31 PM, Wayne Tams wrote:
> > Hi,
> >
> > I am trying to add support for the ADAV801 codec to my 2.6.35.3 kernel. I
> > came across this patch
> > http://article.gmane.org/gmane.linux.alsa.devel/86474 obviously
> > I had to make some modifications so it would correctly patch my source.
> > However when I come to build the kernel I'm getting a whole host of
> errors
> > and I am little unsure on how to proceed, could anyone maybe provide some
> > guidance on the possible causes of my errors or maybe there is a more
> update
> > driver available.
> >
> > Many thanks
> >
> > W
>
> Your kernel version is rather old and was before the big Multi-Component
> patch,
> which change the ASoC API quite a bit.
> There is an old patch[1] adding ADAV801 support which still uses the pre
> Multi-Component API you could use. Other options are to update your kernel
> to a
> more recent version or backport the Multi-Component patch.
>
> - Lars
>
> [1] http://www.spinics.net/lists/alsa-devel/msg36465.html
>
> I think that is it, Though the patch caused the kernel to cross compile
with error

sound/soc/codecs/adav80x.c:431:7: error: 'struct snd_soc_codec' has no
member named 'private_data'

it looks as though in sound/soc.h private_data is referenced as drvdata so I
have modified the patch and the kernel has now compiled successfully. I'll
have to make some modifications to the kconfig as the driver will only build
when SND_SOC_ALL_CODECS=y. It'll be a little while before I can test the
codec on actual hardware but if I have anymore trouble I'll drop you a mail.

Thanks.
