From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4270: enable regulators at
	probe time
Date: Tue, 09 Feb 2010 09:55:28 -0600
Message-ID: <4B718570.4050200@freescale.com>
References: <4B62E8B7.5080403@freescale.com>
	<1265653979-2333-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 7635B1037E3
	for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2010 16:55:48 +0100 (CET)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o19FtUB7015710
	for <alsa-devel@alsa-project.org>; Tue, 9 Feb 2010 08:55:40 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o19G2nhv001330
	for <alsa-devel@alsa-project.org>; Tue, 9 Feb 2010 10:02:49 -0600 (CST)
In-Reply-To: <1265653979-2333-1-git-send-email-daniel@caiaq.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> Enable the bulk regulators at probe time so we can safely disable them
> again when going to suspend without confusing the reference counter.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Timur Tabi <timur@freescale.com>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

I don't have any way to test this, but it looks okay.  Mark, feel free to apply if you're okay with it.

-- 
Timur Tabi
Linux kernel developer at Freescale
