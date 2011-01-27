From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Strange control interactions on Tegra Harmony
Date: Thu, 27 Jan 2011 14:55:07 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310C8DE0F@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0310C8DD47@HQMAIL01.nvidia.com>
	<20110127184927.GC12717@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310C8DDEA@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 162DE103819
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 23:55:16 +0100 (CET)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310C8DDEA@HQMAIL01.nvidia.com>
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

Stephen Warren wrote at Thursday, January 27, 2011 3:00 PM:
> 
> I found the issue, and sent patch "ASoC: Use card as parameter to exported
> PM functions". I was nearly there the last time I looked at this a couple
> days back.
> 
> The issue with both the headphone and speaker mute controls muting both
> outputs is something else though.

Hmm. This issue happens when I run:

aplay foo.wav

But not when I run:

aplay -D hw:0,0 foo.wav

I deleted /etc/asound.conf (which set the default sink to pulse), and the
problem went away. I guess I won't bother investigating this anymore right
now.

-- 
nvpublic
