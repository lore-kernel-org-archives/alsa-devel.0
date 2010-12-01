From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: ak4535: Improve readability for
	setting mute
Date: Wed, 01 Dec 2010 09:53:52 +0000
Message-ID: <1291197232.3292.5.camel@odin>
References: <1291195354.5563.6.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D7931039DB
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2010 10:53:55 +0100 (CET)
Received: by wyi11 with SMTP id 11so6738282wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 01 Dec 2010 01:53:54 -0800 (PST)
In-Reply-To: <1291195354.5563.6.camel@mola>
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
Cc: Richard Purdie <richard@openedhand.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-12-01 at 17:22 +0800, Axel Lin wrote:
> The mute/unmute is controled by SMUTE (Soft Mute Control bit):
>         0: Normal Operation (Default)
>         1: DAC outputs soft-muted
> 
> I think this change improves readability.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
