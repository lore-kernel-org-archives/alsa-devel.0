From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] ASoC: tlv320dac33: Cleanup,
	and 32/24 bit support
Date: Wed, 22 Dec 2010 11:14:20 +0000
Message-ID: <20101222111419.GC12426@opensource.wolfsonmicro.com>
References: <1293007518-3870-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E47AB10388E
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 12:14:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1293007518-3870-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 22, 2010 at 10:45:15AM +0200, Peter Ujfalusi wrote:
> Hello,
> 
> the following series adds 32/24 bit support for DAC33 codec.
> The manual FIFO configuration code will be removed, since that
> was mainly used for initial debugging, and with the 24 bit support
> the FIFO sizes are different, so it would be pain to safe guard
> the manual FIFO settings for both 16, and 24 bit modes.

All

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
