From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: SOF: Add OF DSP device support
Date: Mon, 19 Aug 2019 15:46:17 +0200
Message-ID: <20190819134616.GR5999@X250>
References: <20190815154500.29090-1-pierre-louis.bossart@linux.intel.com>
 <20190815154500.29090-2-pierre-louis.bossart@linux.intel.com>
 <20190815164942.GB4841@sirena.co.uk>
 <CAEnQRZAM6VkCewfVYysz-NmPNEz-CSe763Cv-kz9kyNjx8uMtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3BE2DF802BE
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2019 15:46:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAEnQRZAM6VkCewfVYysz-NmPNEz-CSe763Cv-kz9kyNjx8uMtQ@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 16, 2019 at 11:43:13AM +0300, Daniel Baluta wrote:
> Hi Mark,
> 
> On Thu, Aug 15, 2019 at 7:50 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Thu, Aug 15, 2019 at 10:44:58AM -0500, Pierre-Louis Bossart wrote:
> > > From: Daniel Baluta <daniel.baluta@nxp.com>
> > >
> > > Add support for device tree based SOF DSP devices.
> >
> > I'm not seeing any binding documentation here.  Binding documentation is
> > required for any new device tree bindings supported in code.
> 
> Binding documentation together with the actual dts nodes were sent
> to Shawn.
> 
> https://lkml.org/lkml/2019/8/7/682
> 
> Shawn,
> 
> Can you pick 4/5 and 5/5 patches from series above? 1-3 are sent to
> Mark to go through to alsa tree.

I just picked up DTS patch (4/5), but DT bindings should generally go
through driver/subsystem tree as preference.

Shawn
