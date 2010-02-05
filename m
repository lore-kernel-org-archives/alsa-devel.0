From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH -next] ASoC: pandora: Add DAC regulator
 support
Date: Fri, 05 Feb 2010 14:08:43 +0000
Message-ID: <1265378923.3177.11.camel@odin>
References: <1265375612-9079-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f211.google.com (mail-fx0-f211.google.com
	[209.85.220.211])
	by alsa0.perex.cz (Postfix) with ESMTP id EA54B10381D
	for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2010 15:08:51 +0100 (CET)
Received: by fxm3 with SMTP id 3so3978853fxm.19
	for <alsa-devel@alsa-project.org>; Fri, 05 Feb 2010 06:08:50 -0800 (PST)
In-Reply-To: <1265375612-9079-1-git-send-email-notasas@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-02-05 at 15:13 +0200, Grazvydas Ignotas wrote:
> Pandora's external DAC is connected to VSIM TWL4030 supply, so let's
> start switching it too to save more power.
> 
> Also DAC got it's own DAPM handler and the delay was removed
> (it gave on audible improvement).
> 

That's good to hear (pun intended).

> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
>  sound/soc/omap/omap3pandora.c |   37 +++++++++++++++++++++++++++++++------
>  1 files changed, 31 insertions(+), 6 deletions(-)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
