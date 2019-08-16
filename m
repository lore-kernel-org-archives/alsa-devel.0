From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: SOF: Add OF DSP device support
Date: Fri, 16 Aug 2019 11:43:13 +0300
Message-ID: <CAEnQRZAM6VkCewfVYysz-NmPNEz-CSe763Cv-kz9kyNjx8uMtQ@mail.gmail.com>
References: <20190815154500.29090-1-pierre-louis.bossart@linux.intel.com>
 <20190815154500.29090-2-pierre-louis.bossart@linux.intel.com>
 <20190815164942.GB4841@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63C4CF8011F
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2019 10:43:24 +0200 (CEST)
Received: by mail-wr1-x442.google.com with SMTP id r3so790505wrt.3
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2019 01:43:24 -0700 (PDT)
In-Reply-To: <20190815164942.GB4841@sirena.co.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Linux-ALSA <alsa-devel@alsa-project.org>, Daniel Baluta <daniel.baluta@nxp.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Thu, Aug 15, 2019 at 7:50 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Aug 15, 2019 at 10:44:58AM -0500, Pierre-Louis Bossart wrote:
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> >
> > Add support for device tree based SOF DSP devices.
>
> I'm not seeing any binding documentation here.  Binding documentation is
> required for any new device tree bindings supported in code.

Binding documentation together with the actual dts nodes were sent
to Shawn.

https://lkml.org/lkml/2019/8/7/682

Shawn,

Can you pick 4/5 and 5/5 patches from series above? 1-3 are sent to
Mark to go through to alsa tree.

thanks,
Daniel.
