From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/2] ASoC: multi-comp: twl4030 updates
Date: Sat, 07 Aug 2010 13:03:25 +0100
Message-ID: <1281182605.3088.3.camel@odin>
References: <1281073795-4364-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 986A02441A
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Aug 2010 14:03:27 +0200 (CEST)
Received: by wyb42 with SMTP id 42so8578637wyb.38
	for <alsa-devel@alsa-project.org>; Sat, 07 Aug 2010 05:03:27 -0700 (PDT)
In-Reply-To: <1281073795-4364-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Fri, 2010-08-06 at 08:49 +0300, Peter Ujfalusi wrote:
> Hello Liam, Mark!
> 
> The following two patch is for the current multi-comp
> branch with twl4030 related fixes.
> 
> I have separated them, so they can be squased to the
> corresponding commit in multi-comp branch for now.
> 
> The changes in short:
> - We do not need the header sound/soc/codecs/twl4030.h
>   anymore, so remove it
> - Fix machine drivers with theis header removal
> - The codec no longer get's the former setup data, all
>   configuration is coming from board files via the
>   platform_data. So change the code accordingly
> - Move the twl4030_priv allocation to a proper place
> - Codec can shall go OFF instead of STANDBY, so add back
>   the idle_bias_off flag
> - The MFD driver is twl4030-audio
> 
> TODO after the multi-comp is merged:
> - Rename the mfd driver to twl4030-audio.
>   Clean up the internal naming within the mfd
>   This going to touch many files...
> 
> One more notice:
> The multi-comp branch does not have the
> "ASoC: TWL4030: Capture route runtime DAPM ordering fix" commit
> yet, and I have tested my changes on top of that, but it should
> not be a big problem, when you rebase this driver.
> 

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
