From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/5] ASoC: tlv320dac33: Adding new FIFO mode
Date: Thu, 31 Dec 2009 11:55:08 +0000
Message-ID: <20091231115508.GB4110@opensource.wolfsonmicro.com>
References: <1262248223-9335-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9C4F3103807
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 12:55:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1262248223-9335-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 31, 2009 at 10:30:18AM +0200, Peter Ujfalusi wrote:

> the following series adds new FIFO operating mode to the tlv320dac33 codec
> driver.
> To be able to add new FIFO mode the code has to be restructured in order to
> keep it readable after the new mode is added.
> Since both of the support FIFO mode in the driver needs the codec to be the
> master, an additional check is added to avoid misconfiguration.

Applied all, thanks.
