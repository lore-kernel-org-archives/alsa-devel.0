From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH] ASoC: tegra: Use devm_ioremap_resource
	instead of open code
Date: Mon, 31 Aug 2015 14:21:14 +0900
Message-ID: <CAAVeFuKdQmewtfk+FL5a6VVOfbPLsrFvBUEiiD7zUDNBR-gL4w@mail.gmail.com>
References: <1440343934.18793.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
 [209.85.218.54])
 by alsa0.perex.cz (Postfix) with ESMTP id B740B26055C
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 07:21:34 +0200 (CEST)
Received: by oibi18 with SMTP id i18so53044352oib.3
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 22:21:33 -0700 (PDT)
In-Reply-To: <1440343934.18793.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@wwwdotorg.org>, Vaishali Thakkar <vthakkar1994@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 24, 2015 at 12:32 AM, Axel Lin <axel.lin@ingics.com> wrote:
> Use devm_ioremap_resource() to simplify the code.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/tegra/tegra20_das.c   | 23 ++++------------------
>  sound/soc/tegra/tegra20_i2s.c   | 23 ++++------------------
>  sound/soc/tegra/tegra20_spdif.c | 22 ++++-----------------
>  sound/soc/tegra/tegra30_ahub.c  | 43 +++++++----------------------------------
>  sound/soc/tegra/tegra30_i2s.c   | 23 ++++------------------
>  5 files changed, 23 insertions(+), 111 deletions(-)

Nice negative line count!

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
