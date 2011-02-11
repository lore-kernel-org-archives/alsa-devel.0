From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 3/3] ASoC: Add support for AIF channel
 muxing on WM8903
Date: Thu, 10 Feb 2011 21:40:37 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310F605B2@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0310F6050C@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id D2A472414A
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 06:40:49 +0100 (CET)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310F6050C@HQMAIL01.nvidia.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Stephen Warren wrote at Thursday, February 10, 2011 3:59 PM:
> Stephen Warren wrote at Wednesday, February 09, 2011 9:33 AM:
> >
> > ...I'll make sure to test it within the next few days, once it's
> > applied.
> 
> Mark,
> 
> I did find one issue with this.
> ...
> However, if I flip the Right Capture Mux to setting Left (while not
> capturing),then this breaks case (3) above; the initial portion of the
> recording is fine, but when I remove and plug the mic back in, something
> isn't turned on, and so nothing is recorded after that.

So, what's happening is that once the mic is removed, there's no active path
in the whole codec, so everything gets shut down, including CLK_SYS.
In turn, this means that mic detection doesn't work, so when the mic gets
plugged back in, that event is not noticed, and nothing gets re-enabled.

If I am playing a stream at the same time as recording, that solves (hides)
the problem, since the codec is active and CLK_SYS stays enabled.

I found that if I revert:

2c8be5a26e42cfc4906c4daa8a5a5c82610ddb3d
ASoC: Dynamically manage CLK_SYS in WM8903

That also fixes the issue. I'm not entirely clear why though; perhaps there
are simply missing entries in the route map for CLK_SYS to mic-related
widgets?
 
-- 
nvpublic
