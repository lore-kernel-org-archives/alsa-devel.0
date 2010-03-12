From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC: tlv320dac33 fixes
Date: Fri, 12 Mar 2010 11:18:19 +0000
Message-ID: <20100312111819.GB21260@rakim.wolfsonmicro.main>
References: <1268317582-10284-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A72B710391C
	for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2010 12:18:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1268317582-10284-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 11, 2010 at 04:26:20PM +0200, Peter Ujfalusi wrote:

> Revisiting the start/stop sequence used by the tlv320dac33 codec in
> order to avoid race conditions, which can occur, when the codec is in
> FIFO modes.

Applied, thanks.

> It has been found that OMAP3 McBSP needs the BCLK continuously running
> on the serial interface when it is configured to be slave.
> DAC33 can be configured in a way, that it keeps the BCLK ticking, and
> only enable the FS when it is needed.

I suspect there's some cause and effect going on in the CODEC having
this feature :/
