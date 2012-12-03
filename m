From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: zoom2: Remove HS mux GPIO handling
 to avoid kernel crash due to BUG_ON()
Date: Mon, 3 Dec 2012 17:41:32 +0900
Message-ID: <20121203084131.GB15177@opensource.wolfsonmicro.com>
References: <1354523948-23835-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BB6E02615DC
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2012 09:41:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1354523948-23835-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 03, 2012 at 09:39:08AM +0100, Peter Ujfalusi wrote:
> The machine driver try to use GPIO15 of twl4030 for HS MUX which supposed to
> select between TWL's HSOL/R and tlv320aic3254's HPL/R.

Applied, thanks.
