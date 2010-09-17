From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Add virtual output pin
	Detection
Date: Fri, 17 Sep 2010 14:00:11 +0100
Message-ID: <20100917130011.GH4322@rakim.wolfsonmicro.main>
References: <1284723541-21813-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BBBB5103980
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Sep 2010 15:00:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284723541-21813-1-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 17, 2010 at 02:39:01PM +0300, Jarkko Nikula wrote:
> Purpose of this virtual Detection pin is to keep codec bias on whenever the
> GPIO or jack detection features are needed.
> 
> Jack detection needs a mic bias so machine drivers can construct a following
> route for instance for keeping the path and codec bias on:

> "Input Jack" -> "Mic Bias xV" -> "Detection" -> detection block inside codec.

> For the GPIO the machine driver can force the pin on with
> snd_soc_dapm_force_enable_pin.

> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
