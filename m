From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: TWL4030: Add supply for audio serial
 interface control
Date: Wed, 10 Feb 2010 10:58:54 +0000
Message-ID: <20100210105854.GB9481@rakim.wolfsonmicro.main>
References: <1265721844-5065-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 581992441E
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 11:58:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1265721844-5065-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, jy0922.shim@samsung.com, x0052729@ti.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 09, 2010 at 03:24:04PM +0200, Peter Ujfalusi wrote:
> The serial interface (TDM/I2S) for the audio block have been
> constantly enabled.
> Introduce a new DAPM_SUPPLY for handling the AIF_EN bit, so
> the interface is only enabled, when there is a need for it.
> For example when only the analog loopback is enabled, there
> is no need to keep the serial interface active.

Applied, thanks.
