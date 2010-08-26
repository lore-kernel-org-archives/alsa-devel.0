From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Questions about alsa driver for i.Mx27 + wm8974:
 playback time shorter than the original record time
Date: Thu, 26 Aug 2010 13:41:37 +0100
Message-ID: <20100826124137.GA3509@opensource.wolfsonmicro.com>
References: <1282824338.1106.44.camel@UT43>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 785351037EA
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 14:41:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282824338.1106.44.camel@UT43>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jie Jiang <jjinfo@nudt.edu.cn>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 26, 2010 at 08:05:38PM +0800, Jie Jiang wrote:

> The configuration of mx27 ssi1 transmission channel is as follows(using
> ssi api from kernel 2.6.19.2):

This is an extremely old kernel version, the current kernel version is
2.6.35 with 2.6.36 in development.  Current mainline kernels have a
different API for configuring the IOMUX.  I'd strongly recommend working
with a more current kernel if you're looking for community support.

> Here I'm not very sure about the setting of frame rate and frame sync
> length.  Is the above setting right?  But even I set frame rate to 1, it
> does not make any difference. 

> What's the possible reason causing the incorrect faster playback speed?
> Any suggestion is appreciated.

Normally this will be the result of either an incorrect frame rate or
the hardware trying to play back mono data as stereo (which will cause
data to be consumed as twice the expected rate).
