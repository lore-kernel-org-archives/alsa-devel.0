From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8993: Refactor set_pll code to
	avoid GCC warnings
Date: Wed, 12 Dec 2012 12:21:31 +0900
Message-ID: <20121212032129.GB30719@opensource.wolfsonmicro.com>
References: <1355282392-30693-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 69A40261603
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 04:21:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1355282392-30693-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 12, 2012 at 01:19:52AM -0200, Fabio Estevam wrote:

> -	if (freq_in && freq_out) {
> +	if (!freq_in || !freq_out) {
> +		/* disable the PLL before re-programming it */
> +		snd_soc_update_bits(codec, WM8983_POWER_MANAGEMENT_1,
> +				    WM8983_PLLEN_MASK, 0);
> +		return 0;

This comment clearly doesn't match the code.
