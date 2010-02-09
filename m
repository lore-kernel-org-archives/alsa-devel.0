From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ALSA: ASoC: cs4270: enable regulators at
	probe time
Date: Tue, 09 Feb 2010 10:39:44 +0000
Message-ID: <1265711984.3254.0.camel@odin>
References: <4B62E8B7.5080403@freescale.com>
	<1265653979-2333-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 9049E24545
	for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2010 11:39:49 +0100 (CET)
Received: by ewy23 with SMTP id 23so4233ewy.4
	for <alsa-devel@alsa-project.org>; Tue, 09 Feb 2010 02:39:49 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-02-09 at 02:32 +0800, Daniel Mack wrote:
> Enable the bulk regulators at probe time so we can safely disable them
> again when going to suspend without confusing the reference counter.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Timur Tabi <timur@freescale.com>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/cs4270.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
