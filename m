From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: am3517evm: Remove unused cpu_dai
	from hw_params
Date: Tue, 11 Sep 2012 08:21:16 +0800
Message-ID: <20120911002115.GF30699@opensource.wolfsonmicro.com>
References: <1347281717-10244-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 339BC261B3E
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 02:21:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347281717-10244-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 10, 2012 at 03:55:17PM +0300, Peter Ujfalusi wrote:
> cpu_dai is not in use in this function and just generates warning at
> compile time.

Applied, thanks.

> Commit: fca04ae ASoC: am3517evm: Do not configure McBSP1 CLKR/FSR signal muxing
> left this line in the code which generates now warning.

Please just include stuff like this in the changelog.
