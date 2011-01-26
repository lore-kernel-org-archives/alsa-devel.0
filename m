From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC: Add optional pointer to codec
 interconnects to snd_soc_codec_driver
Date: Wed, 26 Jan 2011 13:41:23 +0000
Message-ID: <20110126134123.GD8501@opensource.wolfsonmicro.com>
References: <1296043097-11720-1-git-send-email-jhnikula@gmail.com>
	<1296043097-11720-3-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7434D1039B1
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 14:41:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296043097-11720-3-git-send-email-jhnikula@gmail.com>
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

On Wed, Jan 26, 2011 at 01:58:16PM +0200, Jarkko Nikula wrote:

>  {
> -	int ret = 0;
> +	int ret = 0, err;

Looks good but it'd be better to avoid combining initialisation with
other variable declarations like this - it's a bit error prone, if only
from a legibility point of view.

As for the machines a similar thing for widgets would be nice.
