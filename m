From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: wm8940: Enable cache usage to
 fix crashes on resume
Date: Thu, 16 Jun 2016 16:16:24 +0100
Message-ID: <20160616151624.GC1552@localhost.localdomain>
References: <1466080472-9817-1-git-send-email-geert+renesas@glider.be>
 <1466080472-9817-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id DE7C8266BEA
 for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2016 17:16:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1466080472-9817-4-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 16, 2016 at 02:34:32PM +0200, Geert Uytterhoeven wrote:
> The wm8940 driver is using a regmap cache sync to restore the
> configuration of the chip when switching from OFF to STANDBY, but does
> not actually define a register cache which means that the restore is
> never going to work and we trigger asserts in regmap.  Fix this by
> enabling caching.
> 
> Based on commit d3030d11961a8c10 ("ASoC: ak4642: Enable cache usage to
> fix crashes on resume") by Mark Brown <broonie@kernel.org>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
