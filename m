From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap: rx51: Add stereo output
 support to audio jack
Date: Wed, 5 Jan 2011 15:55:09 +0000
Message-ID: <20110105155509.GC746@opensource.wolfsonmicro.com>
References: <1294242360-1903-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C1977244B4
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 16:56:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294242360-1903-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 05, 2011 at 05:46:00PM +0200, Jarkko Nikula wrote:

> This support could have been implemented earlier but I was targeting to have
> ASoC cross-device support first. But as there's no DAPM widgets anymore in
> TPA6130, I don't see any other way to implement this than by registering TPA6130
> controls to aic34a with tpa6130a2_add_controls and by using
> tpa6130a2_stereo_enable.

Having thought about it for at least a second I think we should have a
DAPM context in the cards for all the board-level stuff - does that seem
resonable?  The patch itself looks good:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

in the context of the current APIs, though.
