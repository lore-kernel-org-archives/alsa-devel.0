From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC: TWL4030: bypass magic removal
 and cleanup patch
Date: Wed, 28 Oct 2009 10:05:24 +0000
Message-ID: <20091028100524.GA17413@rakim.wolfsonmicro.main>
References: <1256720225-6853-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 186D6244FB
	for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2009 11:05:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1256720225-6853-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Wed, Oct 28, 2009 at 10:57:03AM +0200, Peter Ujfalusi wrote:

> Since the soc core is now handling the codec bias state based on the complete
> paths as well, there is no need for the bypass tracking in the codec.
> The second patch replaces the missleading codec_muted to apll_enabled, which
> is what actually is handled by it.

Applied both, thanks.
