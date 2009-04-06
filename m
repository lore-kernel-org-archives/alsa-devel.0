From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] ASoC: OMAP mcbsp: Add DSP_A support
Date: Mon, 6 Apr 2009 13:22:33 +0100
Message-ID: <20090406122232.GA8585@rakim.wolfsonmicro.main>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2493F24364
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Apr 2009 14:22:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1239020372-8457-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 06, 2009 at 03:19:27PM +0300, Peter Ujfalusi wrote:
> Add SND_SOC_DAIFMT_DSP_A support for omap-mcbsp.
> The configuration for DSP_A and DSP_B is the same.

That doesn't sound right - the two formats do differ on the wire.  In
mode B the MSB of data is transmitted along with the LRC pulse while in
mode A it is transmitted after the trailing edge of the LRC pulse.
