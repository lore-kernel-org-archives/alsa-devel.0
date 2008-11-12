From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [topic/asoc][PATCH] ASoC: Fix supported sample
	rates of TWL4030 audio codec
Date: Wed, 12 Nov 2008 15:11:29 +0000
Message-ID: <20081112151123.GF8767@sirena.org.uk>
References: <1226502341-21815-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CD3024481
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 16:11:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1226502341-21815-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 12, 2008 at 05:05:41PM +0200, Jarkko Nikula wrote:
> TWL4030 currently supports rates between 8 kHz and 48 kHz and sets the codec
> mode register accordingly in twl4030_hw_params. Expose this info so that
> ASoC can match other rates than 44.1 kHz or 48 kHz as well.

> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Cc: Steve Sakoman <steve@sakoman.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
