From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/7] ASoC: i.MX31ads: initialize only on
	correct machine
Date: Thu, 4 Nov 2010 14:51:36 -0400
Message-ID: <20101104185136.GG6088@opensource.wolfsonmicro.com>
References: <1288886745-25977-1-git-send-email-s.hauer@pengutronix.de>
	<1288886745-25977-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D649F24413
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 19:51:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1288886745-25977-2-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 04, 2010 at 05:05:39PM +0100, Sascha Hauer wrote:

> +	if (!machine_is_mx31ads())
> +		return 0;
> +

As previously discussed we need a better check than this - most of these
machines won't have a 1133-EV1 PMIC module on them.  Better to convert
the driver to instantiate from a platform device...
