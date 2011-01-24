From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] SoC: Samsung: Fix outdated cpu_dai_name
 for s3c24xx i2s
Date: Mon, 24 Jan 2011 11:16:05 +0000
Message-ID: <1295867765.3419.6.camel@odin>
References: <1295735888-25527-1-git-send-email-lars@metafoo.de>
	<1295735888-25527-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 2CFD92445E
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 12:16:10 +0100 (CET)
Received: by wyi11 with SMTP id 11so3993629wyi.38
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 03:16:09 -0800 (PST)
In-Reply-To: <1295735888-25527-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, "for 2.6.37" <stable@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 2011-01-22 at 23:38 +0100, Lars-Peter Clausen wrote:
> During the multi-component patch the s3c24xx i2s driver was renamed from
> "s3c24xx-i2s" to "s3c24xx-iis", while the sound board drivers were not
> updated to reflect this change as well.
> 
> As a result there is no match between the dai_link and the i2s driver and no
> sound card is instantiated.
> 
> This patch fixes the problem by updating the sound board drivers to use
> "s3c24xx-iis" for the cpu_dai_name.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: stable@kernel.org (for 2.6.37)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
