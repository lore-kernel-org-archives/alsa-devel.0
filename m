From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: tpa6130a2: Replace DAPM code with
 direct interface
Date: Thu, 2 Dec 2010 09:56:26 +0000
Message-ID: <20101202095626.GB19267@rakim.wolfsonmicro.main>
References: <1291274996-28056-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2AD410380F
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 10:56:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291274996-28056-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Thu, Dec 02, 2010 at 09:29:56AM +0200, Peter Ujfalusi wrote:
> The use of DAPM widgets, and extra routing can cause ordering
> problems in the system.
> Machine drivers should use the exported direct interface with
> SND_SOC_DAPM_HP's event callback to manage the state of the
> amplifier.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

I thought we'd decided that adding a HP widget in the driver was the
most straightforward thing here?  Still...

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
