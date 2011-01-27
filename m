From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Strange control interactions on Tegra Harmony
Date: Thu, 27 Jan 2011 14:00:17 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310C8DDEA@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0310C8DD47@HQMAIL01.nvidia.com>
	<20110127184927.GC12717@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id D1B0C10380B
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 23:00:25 +0100 (CET)
In-Reply-To: <20110127184927.GC12717@opensource.wolfsonmicro.com>
Content-Language: en-US
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
Cc: "dp@opensource.wolfsonmicro.com" <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote at Thursday, January 27, 2011 11:49 AM:
> 
> On Thu, Jan 27, 2011 at 10:20:22AM -0800, Stephen Warren wrote:
> 
> > The Right Speaker Right Bypass control works the first and all subsequent
> > times. Perhaps that's something to do with it being the last entry in
> > wm8903.c's right_speaker_mixer[] array?
> 
> Possibly, though given the way DAPM processes those arrays I'd be a bit
> surprised if it made a difference.  More likely to be that the bypass
> paths is one of the simpler and more direct paths in the CODEC.

I found the issue, and sent patch "ASoC: Use card as parameter to exported
PM functions". I was nearly there the last time I looked at this a couple
days back.

The issue with both the headphone and speaker mute controls muting both
outputs is something else though.

-- 
nvpublic
