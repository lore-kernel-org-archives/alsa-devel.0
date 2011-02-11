From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: Add support for AIF channel
 muxing on WM8903
Date: Fri, 11 Feb 2011 11:36:05 +0000
Message-ID: <20110211113605.GI7180@opensource.wolfsonmicro.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0310F6050C@HQMAIL01.nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310F605B2@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ABB6124430
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 12:35:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310F605B2@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 10, 2011 at 09:40:37PM -0800, Stephen Warren wrote:

> So, what's happening is that once the mic is removed, there's no active path
> in the whole codec, so everything gets shut down, including CLK_SYS.
> In turn, this means that mic detection doesn't work, so when the mic gets
> plugged back in, that event is not noticed, and nothing gets re-enabled.

> If I am playing a stream at the same time as recording, that solves (hides)
> the problem, since the codec is active and CLK_SYS stays enabled.

> I found that if I revert:

> 2c8be5a26e42cfc4906c4daa8a5a5c82610ddb3d
> ASoC: Dynamically manage CLK_SYS in WM8903

> That also fixes the issue. I'm not entirely clear why though; perhaps there
> are simply missing entries in the route map for CLK_SYS to mic-related
> widgets?

There's a link from CLK_SYS to Mic Bias so if Mic Bias is enabled then
CLK_SYS should be kept up too.  However, it looks like the core DAPM
logic is getting this wrong and the force enable is only applying to the
immediate widget.  In the case of a supply widget this is clearly the
wrong thing to do.  I'll send out a patch for this shortly.
