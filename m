From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/2] ASoC: tlv320dac33: Add option for
 keeping the BCLK running
Date: Fri, 12 Mar 2010 08:10:43 +0000
Message-ID: <1268381443.3755.6.camel@odin>
References: <1268317582-10284-1-git-send-email-peter.ujfalusi@nokia.com>
	<1268317582-10284-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 01DA9103811
	for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2010 09:10:50 +0100 (CET)
Received: by bwz20 with SMTP id 20so1934089bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2010 00:10:49 -0800 (PST)
In-Reply-To: <1268317582-10284-3-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-03-11 at 16:26 +0200, Peter Ujfalusi wrote:
> Platform data option for the codec to keep the BCLK clock
> continuously running in FIFO modes (codec master).
> 
> OMAP3 McBSP when in slave mode needs continuous BCLK running
> on the serial bus in order to operate correctly.
> 
> Since in FIFO mode the DAC33 can also shut down the BCLK clock
> and enable it only when it is needed, let the platforms decide
> if the CPU side needs the BCLK running or not.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
