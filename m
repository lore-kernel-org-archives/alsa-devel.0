From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2] ALSA: ASoC: cs4720: use
	snd_soc_cache_sync()
Date: Tue, 22 Nov 2011 14:24:06 -0600
Message-ID: <4ECC04E6.3060400@freescale.com>
References: <1321978643-23976-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 289FB103807
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 21:24:11 +0100 (CET)
In-Reply-To: <1321978643-23976-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, s.neumann@raumfeld.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> Replace the manual register restore mechanism in cs4270.c and call the
> generic snd_soc_cache_sync() handler instead.
> 
> This factors code out in favour of core facilities and also fixes a
> bus confusion that is most probably caused by intermixing i2c-regmap
> functions and i2c_smbus_* accessors.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Reported-and-tested-by: Sven Neumann <s.neumann@raumfeld.com>
> ---

Acked-by: Timur Tabi <timur@freescale.com>

I can't test it, but it doesn't break anything else.

-- 
Timur Tabi
Linux kernel developer at Freescale
