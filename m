From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: tlv320dac33: Add support for
 automatic FIFO configuration
Date: Tue, 27 Jul 2010 09:33:31 -0700
Message-ID: <20100727163330.GB18884@opensource.wolfsonmicro.com>
References: <1280213177-15439-1-git-send-email-peter.ujfalusi@nokia.com>
	<1280213177-15439-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BABCD103807
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 18:33:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1280213177-15439-3-git-send-email-peter.ujfalusi@nokia.com>
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

On Tue, Jul 27, 2010 at 09:46:17AM +0300, Peter Ujfalusi wrote:
> Platform parameter to enable automatic FIFO configuration when
> the codec is in Mode1 or Mode7 FIFO mode.
> When this mode is selected, the controls for changing
> nSample (in Mode1), and UTHR (in Mode7) are not added.
> The driver configures the FIFO configuration based on
> the stream's period size in a way, that every burst will
> read period size of data from the host.
> In Mode7 we need to use a formula, which gives close enough
> aproximation for the burst length from the host point
> of view.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
