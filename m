From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap: rx51: Use
 gpio_set_value_cansleep for speaker amp control
Date: Mon, 23 Aug 2010 10:58:16 +0100
Message-ID: <20100823095816.GB6061@rakim.wolfsonmicro.main>
References: <1282549001-10391-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D7B52449B
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 11:58:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282549001-10391-1-git-send-email-jhnikula@gmail.com>
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

On Mon, Aug 23, 2010 at 10:36:41AM +0300, Jarkko Nikula wrote:
> Speaker amplifier is controlled by TWL4030 GPIO which may sleep. Therefore
> use gpio_set_value_cansleep to get rid of runtime warning that is introduced
> after the commit 9c4ba94 and to get a stack trace if ever executing this
> code in atomic context.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
