From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4720: use
	snd_soc_cache_sync()
Date: Tue, 22 Nov 2011 10:12:02 -0600
Message-ID: <4ECBC9D2.60800@freescale.com>
References: <1321969516-21174-1-git-send-email-zonque@gmail.com>
	<20111122140210.GD6624@sirena.org.uk> <4ECBBE59.2040703@gmail.com>
	<20111122153539.GF6624@sirena.org.uk>
	<4ECBC367.8080801@gmail.com> <4ECBC41D.4000904@freescale.com>
	<4ECBC66A.2060005@gmail
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE007.bigfish.com (mail-va3.bigfish.com [216.32.180.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 712E5103AC7
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 17:12:11 +0100 (CET)
In-Reply-To: <4ECBC66A.2060005@gmail.com>
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
> Well, we're on a different platform and we don't use BLOCK_DATA
> transfers but single byte instructions. You still think it's related?

I have no idea, I just wanted to bring it to your attention, in case it sparked something.  The original code uses i2c_smbus_write_byte_data, but the new code uses i2c_transfer().  Maybe that function is smarter about handling the I2C bus?

-- 
Timur Tabi
Linux kernel developer at Freescale
