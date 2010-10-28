From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Store DC offset correction for
 wm_hubs devices in class W mode
Date: Thu, 28 Oct 2010 10:11:20 +0100
Message-ID: <1288257080.18037.420.camel@vega>
References: <1288236881-7751-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B56322417E
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Oct 2010 11:11:25 +0200 (CEST)
Received: by wwb17 with SMTP id 17so464724wwb.20
	for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2010 02:11:24 -0700 (PDT)
In-Reply-To: <1288236881-7751-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-10-27 at 20:34 -0700, Mark Brown wrote:
> Providing the analogue configuration of the output path remains the same
> the DC offset corrected by the DC servo will remain identical so we can
> skip the callibration, reducing the startup time for the headphone output.
> Implement this for the wm_hubs devices as has been done for several other
> CODECs.
> 
> Don't do this if we have any analogue paths enabled since offsets may be
> being introduced by the analogue paths which could vary outside the
> control of the driver.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> This change has not been tested yet but I'm sending it out for review
> now to accelerate the process.
> 
>  sound/soc/codecs/wm8993.c  |    2 +
>  sound/soc/codecs/wm8994.c  |    3 ++
>  sound/soc/codecs/wm_hubs.c |   69 +++++++++++++++++++++++++++++--------------
>  sound/soc/codecs/wm_hubs.h |    3 ++
>  4 files changed, 54 insertions(+), 23 deletions(-)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
