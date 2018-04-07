From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Clear the xPM bit when
	using xFP
Date: Sat, 7 Apr 2018 12:18:09 -0300
Message-ID: <CAOMZO5CQxbqiFgQJ1Cj3LxCqEzWGwAgRJDhxzyj7gePJJByfZQ@mail.gmail.com>
References: <20180407130221.24770-1-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E9B1266FA1
 for <alsa-devel@alsa-project.org>; Sat,  7 Apr 2018 17:18:11 +0200 (CEST)
Received: by mail-ot0-f193.google.com with SMTP id 23-v6so4261175otj.0
 for <alsa-devel@alsa-project.org>; Sat, 07 Apr 2018 08:18:11 -0700 (PDT)
In-Reply-To: <20180407130221.24770-1-marex@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Gustavo A . R . Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 7, 2018 at 10:02 AM, Marek Vasut <marex@denx.de> wrote:
> When setting xFP directly, set the xPM predivider to 1, otherwise
> it could remain set to previously set incorrect value and interfere
> with the correct clocking.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Gustavo A. R. Silva <garsilva@embeddedor.com>
> Cc: Mark Brown <broonie@kernel.org>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
