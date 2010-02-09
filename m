From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4270: enable regulators at
	probe time
Date: Tue, 9 Feb 2010 19:48:26 +0000
Message-ID: <20100209194826.GA13024@opensource.wolfsonmicro.com>
References: <4B62E8B7.5080403@freescale.com>
	<1265653979-2333-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 70EAD103809
	for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2010 20:48:25 +0100 (CET)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 09, 2010 at 02:32:59AM +0800, Daniel Mack wrote:
> Enable the bulk regulators at probe time so we can safely disable them
> again when going to suspend without confusing the reference counter.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Timur Tabi <timur@freescale.com>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied, thanks.
