From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4720: use
	snd_soc_cache_sync()
Date: Tue, 22 Nov 2011 09:47:41 -0600
Message-ID: <4ECBC41D.4000904@freescale.com>
References: <1321969516-21174-1-git-send-email-zonque@gmail.com>
	<20111122140210.GD6624@sirena.org.uk> <4ECBBE59.2040703@gmail.com>
	<20111122153539.GF6624@sirena.org.uk> <4ECBC367.8080801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B73F103A94
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 16:47:48 +0100 (CET)
In-Reply-To: <4ECBC367.8080801@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> The code is so simple that I'm starting to suspect
> i2c_smbus_write_byte_data() is doing something very wrong, but I can't
> trace it without a hardware I2C analyzer right now. The i2c-regmap
> low-level implementation uses different access functions under the hood,
> so maybe that's a regression.

What platform are you testing this on?  I never really understood the i2c vs. smbus thing (I can never tell which function an i2c device really needs), so I only know that the i2c code works on my PowerPC board.

Also keep in mind that a patch that affects i2c_smbus_write_byte_data() on PowerPC was recently posted, but not approved yet.  Check the thread, "i2c/busses: (mpc) Add support for SMBUS_READ_BLOCK_DATA".  

-- 
Timur Tabi
Linux kernel developer at Freescale
