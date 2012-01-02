From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix return value of
 wm8903_gpio_direction_in() and wm8903_gpio_direction_out()
Date: Mon, 2 Jan 2012 12:44:50 +0000
Message-ID: <20120102124449.GD4300@opensource.wolfsonmicro.com>
References: <1325300501.4616.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5EB021038FA
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2012 13:44:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325300501.4616.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 31, 2011 at 11:01:41AM +0800, Axel Lin wrote:
> We can't just pass back the return value of snd_soc_update_bits() as it
> will be 1 if a bit changed rather than zero.

Applied, thanks.
