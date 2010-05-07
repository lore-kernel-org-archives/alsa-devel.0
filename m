From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Support for limiting the volume
Date: Fri, 7 May 2010 16:41:20 +0100
Message-ID: <20100507154120.GC25793@rakim.wolfsonmicro.main>
References: <1273230349-6351-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC7C11038B4
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 17:41:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1273230349-6351-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Fri, May 07, 2010 at 02:05:49PM +0300, Peter Ujfalusi wrote:
> Add support for the core to limit the maximum volume on an
> existing control.
> The function will modify the soc_mixer_control.max value
> of the given control.
> The new value must be lower than the original one (chip maximum)

Applied, thanks.
