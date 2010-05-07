From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: core: Support for limiting the volume
Date: Fri, 07 May 2010 14:56:37 +0100
Message-ID: <1273240597.2852.200.camel@odin>
References: <1273230349-6351-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id A1230245B7
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 15:56:39 +0200 (CEST)
Received: by wyf23 with SMTP id 23so703545wyf.38
	for <alsa-devel@alsa-project.org>; Fri, 07 May 2010 06:56:38 -0700 (PDT)
In-Reply-To: <1273230349-6351-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Fri, 2010-05-07 at 14:05 +0300, Peter Ujfalusi wrote:
> Add support for the core to limit the maximum volume on an
> existing control.
> The function will modify the soc_mixer_control.max value
> of the given control.
> The new value must be lower than the original one (chip maximum)
> 
> If there is a need for limiting a gain on a given control,
> than machine drivers can do the following in their
> snd_soc_dai_link.init function:
> 
> snd_soc_limit_volume(codec, "TPA6140A2 Headphone Playback Volume", 21);
> 
> This will modify the original 31 (chip maximum) to 21, so user
> space will not be able to set the gain higher than this.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
