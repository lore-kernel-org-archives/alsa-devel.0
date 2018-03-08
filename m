From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ASoC: Use proper DT compatible string for
 Hardkernel Odroid boards
Date: Wed, 7 Mar 2018 20:42:46 -0600
Message-ID: <20180308024246.iwaecyxek56xhr5d@rob-hp-laptop>
References: <CGME20180307174638epcas2p33f071928807ccaa40ad07922c15be31c@epcas2p3.samsung.com>
 <20180307174625.16597-1-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 by alsa0.perex.cz (Postfix) with ESMTP id B7ADF26732A
 for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2018 03:42:48 +0100 (CET)
Received: by mail-oi0-f66.google.com with SMTP id j79so3307297oib.12
 for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2018 18:42:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180307174625.16597-1-s.nawrocki@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com, lgirdwood@gmail.com, broonie@kernel.org, m.szyprowski@samsung.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 07, 2018 at 06:46:25PM +0100, Sylwester Nawrocki wrote:
> The Odroid boards are manufactured by Hardkernel, not Samsung. New compatible
> string entries are added, with "hardkernel," instead of "samsung," vendor
> prefix. Support for the old compatible strings is going to be removed after
> some time.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  Documentation/devicetree/bindings/sound/samsung,odroid.txt | 6 +++---
>  sound/soc/samsung/odroid.c                                 | 4 +++-
>  2 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
