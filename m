From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/6] docs: fix a couple of new broken references
Date: Wed, 31 Jul 2019 14:21:19 -0600
Message-ID: <CAL_Jsq+n9g5d7GkJRJJohfQywzuQNbOam=FbsDCaQu86Z+4zfg@mail.gmail.com>
References: <cover.1564603513.git.mchehab+samsung@kernel.org> <5b4fae5978d309641fa8ba233a9efe2b48201cd6.1564603513.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5b4fae5978d309641fa8ba233a9efe2b48201cd6.1564603513.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Dave Kleikamp <shaggy@kernel.org>, Evgeniy Dushistov <dushistov@mail.ru>, Linux-ALSA <alsa-devel@alsa-project.org>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.o>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 31, 2019 at 2:08 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Those are due to recent changes. Most of the issues
> can be automatically fixed with:
>
>         $ ./scripts/documentation-file-ref-check --fix
>
> The only exception was the sound binding with required
> manual work.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt | 2 +-

Acked-by: Rob Herring <robh@kernel.org>

>  MAINTAINERS                                                 | 4 ++--
>  drivers/hwtracing/coresight/Kconfig                         | 2 +-
>  fs/jfs/Kconfig                                              | 2 +-
>  fs/ufs/Kconfig                                              | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
