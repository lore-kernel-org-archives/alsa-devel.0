From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Allow use sleeping gpio in soc-jack
Date: Fri, 11 Feb 2011 11:17:38 +0000
Message-ID: <20110211111738.GE7180@opensource.wolfsonmicro.com>
References: <1297351343-17297-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8DEFF1037F2
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 12:17:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1297351343-17297-1-git-send-email-jhnikula@gmail.com>
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

On Thu, Feb 10, 2011 at 05:22:23PM +0200, Jarkko Nikula wrote:
> It is safe to use sleeping gpio in snd_soc_jack_gpio_detect as it is not
> called from interrupt context. This avoids WARN_ON from __gpio_get_value
> if sleeping gpio is registered for jack.

Applied, thanks.
