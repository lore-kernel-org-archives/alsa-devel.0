From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tlv320dac33: Add DAPM selection for
	LOM invert
Date: Wed, 12 Jan 2011 00:54:12 +0000
Message-ID: <1294793652.3338.483.camel@odin>
References: <1294666789-16272-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f65.google.com (mail-ww0-f65.google.com [74.125.82.65])
	by alsa0.perex.cz (Postfix) with ESMTP id C4A871038E9
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 01:54:15 +0100 (CET)
Received: by wwb39 with SMTP id 39so13436wwb.8
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 16:54:15 -0800 (PST)
In-Reply-To: <1294666789-16272-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-01-10 at 15:39 +0200, Peter Ujfalusi wrote:
> The L/R LOM line can be invertined side of the
> corresponding DAC, or inverted from the corresponding
> LOP.
> Add control for user space to select the source of the
> LOM inversion.
> When only the analog bypass is enabled, and the LOM
> is inverted from DAC output, we need to power the
> corresponding DAC.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---


Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
