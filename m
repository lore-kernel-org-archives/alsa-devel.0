From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: Request for comments for SND_SOC_IMX_WM8731
Date: Sun, 26 Oct 2014 00:40:17 -0700
Message-ID: <20141026074017.GA6268@Asurada>
References: <CAB-pspcgsa3-YgBfk-5TUoyfEN0pbBHtqCUrzyaQdCA-QNHt1Q@mail.gmail.com>
 <CAOMZO5AXhj-r4v-sR6Rp_ywD85M07W06r551vMq0r6juE+Tmgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A506260494
 for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 08:40:26 +0100 (CET)
Received: by mail-pd0-f170.google.com with SMTP id z10so3799222pdj.29
 for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 00:40:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMZO5AXhj-r4v-sR6Rp_ywD85M07W06r551vMq0r6juE+Tmgg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Bennett <jbscience87@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Aaron Kling <webgeek1234@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>, Valentin Raevsky <valentin@compulab.co.il>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Jonathan,

On Fri, Oct 24, 2014 at 10:20:29AM -0200, Fabio Estevam wrote:
> On Fri, Oct 24, 2014 at 2:42 AM, Jonathan Bennett <jbscience87@gmail.com> wrote:
> > This patch is a continuation of my work on supporting the Utilite devices on
> > the vanilla kernel. I've modified the code slightly to conform to
> > established practice. Namely instead of using src-port and ext-port, we use
> > mux-int-port and mux-ext-port.
> >
> > This driver has support for putting the codec in either master mode or slave
> > mode. So far I've only had success with using slave mode. For trying to
> > submit for kernel inclusion, should I strip out the code for codec master

Just took a look at your driver. And I have a suggestion on the top
of Fabio's comments.

I think you should try fsl-asoc-card driver instead of adding this
one. Your driver doesn't seemly have some specific requirement and
it actually contains a few out-of-date code like SSI clock divider
settings. SSI driver now has the capability to calculate divisors
automatically based on the required sample rate, even if it may not
be perfect to apply all the sample rates. But I don't think the
machine driver shall take care this job any more.

So I suggest you first to try the fsl-asoc-card with a specific
change for wm8731 to make it work -- I think you only need to
configure some parameters in its probe() as I did for the other
CODECs. If it doesn't work out, you can raise the problem. I'll
also help on it.

Thanks,
Nicolin
