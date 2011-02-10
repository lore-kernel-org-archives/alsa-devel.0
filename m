From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 3/3] ASoC: Add support for AIF channel
 muxing on WM8903
Date: Thu, 10 Feb 2011 14:59:17 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310F6050C@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 42266244B7
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 23:59:33 +0100 (CET)
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
To: Stephen Warren <swarren@nvidia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Stephen Warren wrote at Wednesday, February 09, 2011 9:33 AM:
> 
> Mark Brown wrote at Wednesday, February 09, 2011 6:47 AM:
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > ---
> >  sound/soc/codecs/wm8903.c |   66 ++++++++++++++++++++++++++++++++++++++++++---
> >  1 files changed, 62 insertions(+), 4 deletions(-)
> 
> ...I'll make sure to test it within the next few days, once it's applied.

Mark,

I did find one issue with this.

With the default Left/Right Capture Mux settings, and the patch series I just
posted, mic detection now works fine in all the scenarios I tested:

1) Mic plugged in before loading driver, or not.
2) Mic plugged in when starting to capture, or not.
3) Mic removed and plugged back in while capture active.

However, if I flip the Right Capture Mux to setting Left (while not capturing),
then this breaks case (3) above; the initial portion of the recording is fine,
but when I remove and plug the mic back in, something isn't turned on, and so
nothing is recorded after that.

I haven't had a chance to look into this yet, but can later; probably on
Saturday evening.
 
-- 
nvpublic
