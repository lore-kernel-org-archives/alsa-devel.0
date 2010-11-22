From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2] ASoC: atmel: test wrong variable
Date: Mon, 22 Nov 2010 10:04:37 -0600
Message-ID: <4CEA9495.8040605@freescale.com>
References: <1290361216-15166-1-git-send-email-segoon@openwall.com>
	<20101122094353.f76830b5.jhnikula@gmail.com>
	<20101122155913.GA9089@albatros>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	by alsa0.perex.cz (Postfix) with ESMTP id C95592432C
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 17:05:18 +0100 (CET)
Received: from mail65-am1 (localhost.localdomain [127.0.0.1])	by
	mail65-am1-R.bigfish.com (Postfix) with ESMTP id 040921348170	for
	<alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 16:05:10 +0000 (UTC)
Received: from AM1EHSMHS006.bigfish.com (unknown [10.3.201.240])	by
	mail65-am1.bigfish.com (Postfix) with ESMTP id B10E91A585E9	for
	<alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 16:04:44 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	oAMG4ctf013087	for
	<alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 09:04:39 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oAMGMJcb014505	for <alsa-devel@alsa-project.org>;
	Mon, 22 Nov 2010 10:22:19 -0600 (CST)
In-Reply-To: <20101122155913.GA9089@albatros>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Liam@alsa-project.org, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Vasiliy Kulikov wrote:
> After clk_get() mclk is checked second time instead of pllb check.
> In patch v1 Jarkko Nikula noticed that PTR_ERR() is also has wrong argument.
> 
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>

Why am I'm being cc'd on Atmel driver patches?  I've done no work on these drivers.

-- 
Timur Tabi
Linux kernel developer at Freescale
