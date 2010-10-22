From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: tlv320dac33: Use usleep_range
	for delays
Date: Fri, 22 Oct 2010 08:32:25 -0700
Message-ID: <20101022153225.GC16521@opensource.wolfsonmicro.com>
References: <1287749481-12203-1-git-send-email-peter.ujfalusi@nokia.com>
	<1287749481-12203-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C6CC910385C
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 17:32:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1287749481-12203-2-git-send-email-peter.ujfalusi@nokia.com>
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

On Fri, Oct 22, 2010 at 03:11:20PM +0300, Peter Ujfalusi wrote:
> Switch to use the more precise usleep_range instead of
> msleep().
> Replace the udelay with usleep_range to remove the busy loop
> waiting.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Mark Borwn <broonie@opensource.wolfsonmicro.com>
