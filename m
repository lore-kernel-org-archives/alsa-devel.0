From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add support for 19.2 MHz MCLK
	in	TLV320AIC3X
Date: Mon, 14 Apr 2008 14:50:46 +0100
Message-ID: <20080414135046.GA25508@rakim.wolfsonmicro.main>
References: <1207902735-6660-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E07024517
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 15:50:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1207902735-6660-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 11, 2008 at 11:32:15AM +0300, Jarkko Nikula wrote:
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>

Thanks - I've added this to the ASoC tree and upstream queue.

Rather than maintaining this table it might be worth looking at adding
code to allow the driver to calculate a suitable configuration at run
time.  The WM8753 and WM9713 drivers do this for the PLL configuration,
for example.
