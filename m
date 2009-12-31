From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: tlv320dac33: Safety check for
 codec slave mode
Date: Thu, 31 Dec 2009 11:52:19 +0000
Message-ID: <20091231115218.GA4110@opensource.wolfsonmicro.com>
References: <1262248223-9335-1-git-send-email-peter.ujfalusi@nokia.com>
	<1262248223-9335-2-git-send-email-peter.ujfalusi@nokia.com>
	<1262248223-9335-3-git-send-email-peter.ujfalusi@nokia.com>
	<1262248223-9335-4-git-send-email-peter.ujfalusi@nokia.com>
	<1262248223-9335-5-git-send-email-peter.ujfalusi@nokia.com>
	<1262248223-9335-6-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0DE3E10380D
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 12:52:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1262248223-9335-6-git-send-email-peter.ujfalusi@nokia.com>
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

On Thu, Dec 31, 2009 at 10:30:23AM +0200, Peter Ujfalusi wrote:
> The currently available FIFO modes (mode1 and mode7) require master
> mode from the codec.
> Do not allow the slave configuration when the FIFO is in use.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Ideally the mode configuration control ought to have a corresponding
limit in it too, so that these modes can't be enabled when the device
is configured as a slave and is active.
