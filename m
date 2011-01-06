From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: cs4270: fix dynamic initialization
 of register cache
Date: Thu, 6 Jan 2011 20:15:12 +0000
Message-ID: <20110106201511.GA8018@opensource.wolfsonmicro.com>
References: <1294339968-420-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3023324532
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 21:14:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294339968-420-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 06, 2011 at 12:52:48PM -0600, Timur Tabi wrote:

> +	u8 reg_cache[CS4270_NUMREGS];
> +	struct snd_soc_codec_driver codec_drv;

Having a driver per device is pretty icky and off the top of my head I'd
expect it to cause problems if there are two cs4270 in the system.  It
would be much nicer and more maintainable to avoid bodging around the
API like this.
