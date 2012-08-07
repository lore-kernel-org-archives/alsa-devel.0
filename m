From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Fix 6pin mux
	configuration
Date: Tue, 7 Aug 2012 15:04:41 +0100
Message-ID: <20120807140441.GI16861@opensource.wolfsonmicro.com>
References: <1344343067-27435-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BB27C265F40
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 18:01:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1344343067-27435-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, stable@linux.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, "3.4+" <stable@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 07, 2012 at 03:37:47PM +0300, Peter Ujfalusi wrote:
> The check for the mux_signal callback was wrong which prevents us to
> configure the 6pin port's FSR/CLKR signal mux.

Applied, thanks.

> Cc: stable@kernel.org (3.4+)

Should be stable@vger.kernel.org these days.
