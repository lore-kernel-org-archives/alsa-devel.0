From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: Fix SND_SOC_DAPM_LINE handling
Date: Wed, 30 Sep 2009 11:21:25 +0100
Message-ID: <20090930102125.GA19852@rakim.wolfsonmicro.main>
References: <1254292044-26634-1-git-send-email-peter.ujfalusi@nokia.com>
	<1254292044-26634-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A8ED3103897
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 12:21:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1254292044-26634-2-git-send-email-peter.ujfalusi@nokia.com>
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

On Wed, Sep 30, 2009 at 09:27:24AM +0300, Peter Ujfalusi wrote:
> Since the SND_SOC_DAPM_LINE can be input or output, additional check is
> needed in order to determine if the widget is connected as input or
> output.

Applied, thanks.

Incidentally, there's usually no need to send a cover letter with single
patches - normally you can just cover everything in the commit message.
If there's stuff that shouldn't be in the commit message add it after
the '---' and tools like git am will drop it automatically.
