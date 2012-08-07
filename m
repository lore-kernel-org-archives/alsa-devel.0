From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Set dapm->idle_bias_off for
 DAIs not mapped with a codec
Date: Tue, 7 Aug 2012 15:10:05 +0100
Message-ID: <20120807141004.GM16861@opensource.wolfsonmicro.com>
References: <1344324253-30327-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E6F1C265F2E
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 18:06:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1344324253-30327-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 07, 2012 at 10:24:13AM +0300, Peter Ujfalusi wrote:
> The idle_bias_off flag is not configured for DAIs not mapped with a codec.
> This causes the pm counter to be increased at probe time for the CPU dai
> which unbalances the pm counter handling.

Applied, thanks.
