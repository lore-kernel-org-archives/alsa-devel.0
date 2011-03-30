From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound/soc/pxa/zylonite.c: set
 .codec_dai_name in initializer
Date: Wed, 30 Mar 2011 09:31:19 +0900
Message-ID: <20110330003113.GA2853@opensource.wolfsonmicro.com>
References: <1300448853-15651-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B9C4C103817
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 02:31:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1300448853-15651-1-git-send-email-ospite@studenti.unina.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, Eric Miao <eric.y.miao@gmail.com>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 18, 2011 at 12:47:33PM +0100, Antonio Ospite wrote:
> Fix the initialization of .codec_dai_name in zylonite_dai initializer,
> do not mix it with the initialization of .codec_name which is set
> already a few lines above.

Applied, thanks.

As discussed via IRC please fix your mail setup so it can deliver to
hosts without MX records.  Please also try to cut down the CC lists a
bit - don't blindly trust get_maintainers.
