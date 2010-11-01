From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: tlv320aic3x: Add support to
 shared common reset line
Date: Mon, 1 Nov 2010 09:08:04 -0400
Message-ID: <20101101130804.GB22639@opensource.wolfsonmicro.com>
References: <1288613036-13169-1-git-send-email-jhnikula@gmail.com>
	<1288613036-13169-2-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C717103800
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 14:07:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1288613036-13169-2-git-send-email-jhnikula@gmail.com>
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

On Mon, Nov 01, 2010 at 02:03:56PM +0200, Jarkko Nikula wrote:
> This is aimed to configurations where multiple aic3x codecs share the same
> reset line and are powered from same supply voltages.
> 
> Currently aic3x_probe will fail if trying to request already requested
> gpio_reset and passing -1 to another aic3x instances cause that those
> instances cannot release reset in aic3x_set_power. That is, another
> instances can work only if primary aic3x instance is powered and reset is
> released.
> 
> Solve this by implementing a list of probed instances that is used for
> checking if other instance shares the same gpio_reset number. If a shared
> reset line exists, then only first instance tries to request and configure
> it and the last instance releases it.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
