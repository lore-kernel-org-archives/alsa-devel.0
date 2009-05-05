From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: cs4270: introduce CS4270_I2C_INCR
Date: Tue, 05 May 2009 09:51:47 -0500
Message-ID: <4A005283.50306@freescale.com>
References: <1241515501-6600-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id AFB6E1037FA
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 16:52:09 +0200 (CEST)
In-Reply-To: <1241515501-6600-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> Replace the magic 0x80 value with a suitable macro definition.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Timur Tabi <timur@freescale.com>
> Cc: Mark Brown <broonie@sirena.org.uk>

And I thought *I* was anal-retentive! :-)

Acked-by: Timur Tabi <timur@freescale.com>

(although personally, I would have called it CS4270_I2C_AUTO_INCR)

-- 
Timur Tabi
Linux kernel developer at Freescale
