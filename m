From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: core: Fix for the volume limiting
 when invert is in use
Date: Mon, 10 May 2010 19:56:22 +0100
Message-ID: <1273517782.3288.130.camel@odin>
References: <1273491564-11666-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1672F24836
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 20:56:26 +0200 (CEST)
Received: by fxm2 with SMTP id 2so2428996fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 10 May 2010 11:56:25 -0700 (PDT)
In-Reply-To: <1273491564-11666-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-05-10 at 14:39 +0300, Peter Ujfalusi wrote:
> If the register for the volume needs invert, than the inversion
> need to be done from the chip maximum, and not from the platform
> dependent limit.
> Introduce soc_mixer_control.platform_max value, which initially
> equals to chip maximum.
> The snd_soc_limit_volume function only modify the platform_max,
> all volsw_info call returns this as well.
> The .max value holds the chip default (maximum), and it is used
> for the inversion, if it is needed.
> 
> Additional check in the volsw_info call has been added to check
> the validity of the platform_max in case, when custom macros
> used by codec drivers are not initializing it correctly.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
