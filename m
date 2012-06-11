From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v5] sound/soc/lapis: add platform driver
	for ML7213
Date: Mon, 11 Jun 2012 16:05:56 +0900
Message-ID: <CANKRQnjeYtBucmGoDUg7oTK82rvnkakWRB0Siezyz-kbhyPC+g@mail.gmail.com>
References: <CANKRQnhNWC2F6zKgBMJY7HnipJbA5p-=6Lz4uGZqBKNQ688Z3w@mail.gmail.com>
	<20120524100742.GH5361@opensource.wolfsonmicro.com>
	<CANKRQnj_LdGQPYPV7d5NNZBx8oM5aAGHu4qZidiiS6C4eNtNJQ@mail.gmail.com>
	<1337941231.1580.19.camel@vkoul-udesk3>
	<20120527221956.GB25019@opensource.wolfsonmicro.com>
	<CANKRQnhwkhGUHi6WQhw-sRJuKari3SLcipCJXVp27OZ29=Vxkw@mail.gmail.com>
	<20120530121449.GI9947@opensource.wolfsonmicro.com>
	<CANKRQni4uqQJ99ycOScHmn-g1kz2_XH7ePL+n1taG5jAbDSubw@mail.gmail.com>
	<20120531104538.GA2666@opensource.wolfsonmicro.com>
	<CANKRQnjdiV+e=N+n_ZP04jmCAhxKjgZ+wab+anbgO+VJPNo=PQ@mail.gmail.com>
	<20120601083018.GH24139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5064E10415D
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 09:05:58 +0200 (CEST)
Received: by dajt11 with SMTP id t11so5976230daj.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2012 00:05:56 -0700 (PDT)
In-Reply-To: <20120601083018.GH24139@opensource.wolfsonmicro.com>
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

On Fri, Jun 1, 2012 at 5:30 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> > Sorry, I couldn't find.
> > Is your saying Linus's tree this ?
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > However, any ASoC driver doesn't use cyclic DMA's.
>
> $ grep CYCLIC sound/soc/soc-dmaengine-pcm.c
> =A0 =A0 =A0 =A0dma_cap_set(DMA_CYCLIC, mask);

I already saw this.

You said "all current mainline drivers using the library use cyclic DMA."
Does this mean the following drivers use "snd_dmaengine_pcm_open" ?
  ep93xx-pcm
  imx-pcm-dma-mx2
  mxs-pcm

However, the following drivers don't use any ASoC DMA framework, right ?.
E.g. these drivers call dma_request_channel directly.
  siu_pcm
  fsi
  txx9aclc

That is to say, some drivers ASoC DMA framework. However some drivers
don't use any ASoC DMA framework.

Why didn't you do porting to your saying "ASoC DMA framework"?

thanks.

--
ROHM Co., Ltd.
tomoya
