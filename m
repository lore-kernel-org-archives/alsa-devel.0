From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: da7210: Remove unnecessary
	regmap_exit call
Date: Mon, 3 Dec 2012 17:25:10 +0900
Message-ID: <20121203082509.GA15177@opensource.wolfsonmicro.com>
References: <1354522423-28874-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CFE042615D9
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2012 09:25:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1354522423-28874-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: alsa-devel@alsa-project.org, patches@linaro.org, tiwai@suse.de, dchen@diasemi.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 03, 2012 at 01:43:43PM +0530, Sachin Kamat wrote:
> Use of devm_regmap_init_spi does not require an explicit
> regmap_exit call.

Applied, thanks.
