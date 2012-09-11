From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: Revert "ASoC: mc13783: Provide
 codec->control_data"
Date: Tue, 11 Sep 2012 08:21:30 +0800
Message-ID: <20120911002128.GG30699@opensource.wolfsonmicro.com>
References: <1347293410-23683-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 65671264F16
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 02:21:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347293410-23683-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: manuel.lauss@googlemail.com, lee.jones@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 10, 2012 at 01:10:08PM -0300, Fabio Estevam wrote:
> Since commit 98d3088e5 (SoC: core: Fix check before defaulting to regmap)
> , it is not necessary to provide codec->control_data anymore.

Applied all, thanks.
