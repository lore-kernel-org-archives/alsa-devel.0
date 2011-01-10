From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: let snd_soc_update_bits() return an
	error code
Date: Mon, 10 Jan 2011 19:29:01 +0000
Message-ID: <20110110192901.GA11684@opensource.wolfsonmicro.com>
References: <1294687713-16433-1-git-send-email-timur@freescale.com>
	<1294687713-16433-2-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5C7B1245C7
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 20:31:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294687713-16433-2-git-send-email-timur@freescale.com>
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

On Mon, Jan 10, 2011 at 01:28:33PM -0600, Timur Tabi wrote:

> +	ret = old = snd_soc_read(codec, reg);
> +	if (ret < 0)
> +		return ret;

Please don't use multiple assignments in a single statement, it does
nothing for legibility.
