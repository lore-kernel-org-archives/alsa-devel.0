From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v5] sound/soc/lapis: add platform driver
	for ML7213
Date: Wed, 13 Jun 2012 19:41:57 +0900
Message-ID: <CANKRQngP3e3U+VZDgA7fQfxBti9vri-AEAR8iTmhLYiqXP_kiw@mail.gmail.com>
References: <CANKRQnj_LdGQPYPV7d5NNZBx8oM5aAGHu4qZidiiS6C4eNtNJQ@mail.gmail.com>
	<1337941231.1580.19.camel@vkoul-udesk3>
	<20120527221956.GB25019@opensource.wolfsonmicro.com>
	<CANKRQnhwkhGUHi6WQhw-sRJuKari3SLcipCJXVp27OZ29=Vxkw@mail.gmail.com>
	<20120530121449.GI9947@opensource.wolfsonmicro.com>
	<CANKRQni4uqQJ99ycOScHmn-g1kz2_XH7ePL+n1taG5jAbDSubw@mail.gmail.com>
	<20120531104538.GA2666@opensource.wolfsonmicro.com>
	<CANKRQnjdiV+e=N+n_ZP04jmCAhxKjgZ+wab+anbgO+VJPNo=PQ@mail.gmail.com>
	<20120601083018.GH24139@opensource.wolfsonmicro.com>
	<CANKRQnjeYtBucmGoDUg7oTK82rvnkakWRB0Siezyz-kbhyPC+g@mail.gmail.com>
	<20120611085404.GB11439@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f179.google.com (mail-gh0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 22C3D244E7
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 12:41:59 +0200 (CEST)
Received: by ghbg24 with SMTP id g24so216964ghb.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Jun 2012 03:41:58 -0700 (PDT)
In-Reply-To: <20120611085404.GB11439@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, lars@metafoo.de, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 11, 2012 at 5:54 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> There are some drivers that predate the availibility of the dmaengine
> framework.

In case, you develop a new ASoC framework,  all previous ASoC drivers
should be adopted to the framework by yourself, don't you ?
Because a new developer must be confused by this.

> This, and the fact that the PCH driver uses dmaengine without using any
> shared code, is the topic of the discussion. =A0It is entirely natural
> that there are no open coded drivers using cyclic DMA via dmaengine,
> they have all had that code factored out.
>
> Please stop this and at least look at factoring this code out. =A0If it
> turns out that there's some reason why it's a lot of work that's one
> thing but it seems clear that you've not even looked yet. =A0It's like the
> previous issues where you were sending patches which would clearly not
> run successfully, it's not a very positive approach.

OK, I'll stop this.

I wanted to finish adding these patch series to upstream because we
spent much resource on this.
But I'm involved in other work, so I can't start now.

Until now thank you for your support.
Regards.

-- =

ROHM Co., Ltd.
tomoya
