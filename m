From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: Add Aquila sound driver
Date: Thu, 8 Jul 2010 16:05:51 +0900
Message-ID: <20100708070549.GA29850@opensource.wolfsonmicro.com>
References: <4C355AC2.8090502@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0B4B42464D
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jul 2010 09:06:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C355AC2.8090502@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: alsa-devel@alsa-project.org, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 08, 2010 at 01:57:38PM +0900, Chanwoo Choi wrote:
> This patch add sound support for the Aquila board based on S5PC110.
> 
> The Aquila board is based on Samsung SoC(S5PC110) and include
> WM8994 codec over I2Sv5 to support sound. As there is currently
> no driver for the I2Sv5, the code to use I2Sv5 is deleted
> on this patch.

This looks good from my point of view, though I'm not sure if you want
to do any updates for Jassi's comments and Liam also needs to review
still.

One other thing that you might want to do - I'm not sure if you noticed
but there is now an API call snd_soc_dapm_ignore_suspend() which allows 
audio paths to be kept up while the system is suspended, intended for
use in cases like voice calls on mobile phones where audio is running
even though the Linux system is suspended.  To use this you should mark
all DAPM endpoints which can be live over suspend as ignoring suspend
then ASoC should transparently keep any paths between endpoints marked
this way up.
