From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: What is exact definition of "normal/inverted"
	FSYNC signal polarity?
Date: Fri, 11 Sep 2015 22:48:05 -0700
Message-ID: <CAOMFOmWQnZH_OJGs4x6eP9KAHPikwh3cxUfaHgE3jvns0O3Kjw@mail.gmail.com>
References: <CAOMFOmXwfBydswh0BiSOB42KMa0T+0-W1mj0=d4AhisToFxkVg@mail.gmail.com>
 <20150831180250.GT12027@sirena.org.uk>
 <CAOMFOmVfE2qiXN=h7i1pJ38JJL3J94UgrN_q+ratYTu=nr372w@mail.gmail.com>
 <20150901121430.GU5313@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com
 [209.85.213.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B6BD261B07
 for <alsa-devel@alsa-project.org>; Sat, 12 Sep 2015 07:48:07 +0200 (CEST)
Received: by vkfp126 with SMTP id p126so35693530vkf.3
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2015 22:48:06 -0700 (PDT)
In-Reply-To: <20150901121430.GU5313@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Ben Zhang <benzh@google.com>, =?UTF-8?B?6Zmz56uL5bOw?= <albertchen@realtek.com>, Leng Ooi <lengo@google.com>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark

On Tue, Sep 1, 2015 at 5:14 AM, Mark Brown <broonie@kernel.org> wrote:

> On Mon, Aug 31, 2015 at 12:05:51PM -0700, Anatol Pomozov wrote:
>
> > Thus "normal" FSYNC for this driver means that the frame (L channel)
> > starts at rising edge of FSYNC (wm8731 datasheet calls it DACLRC).
> > "inverted" means frame starts at the falling edge. It differs both
> > from TegraX1 and rt5677 above.
>
> > It looks like each driver uses its own definition of FSYNC polarity.
> > To avoid compatibility problems between different codecs/socs there
> > should be a clean definition of what is FSYNC polarity is. I would
> > propose something simple like:
> >     ****  "normal" FSYNC means frame starts at rising edge of FSYNC,
> > and "inverted" frame starts at falling FSYNC edge ****
> > i.e. the same as for 8731.
>
> Right, the Tegra and Realtek drivers are buggy here - the wm8731
> definition is the one that essentially everything is using.
>

Are you OK to accept the patch
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-August/097126.html
 ?

If yes then I will work with NVidia/Realtek on updating their drivers.
