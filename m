From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: SSM2602: drop rate and sample
	bits	constraints
Date: Sat, 26 Mar 2011 12:44:09 +0000
Message-ID: <20110326124409.GF28537@opensource.wolfsonmicro.com>
References: <1301124539-527-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0C20424427
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 13:44:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1301124539-527-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 26, 2011 at 03:28:58AM -0400, Mike Frysinger wrote:
> From: Cliff Cai <cliff.cai@analog.com>
> 
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

I suspect this change is incomplete and should also be setting the
symmetric_rates flag in the driver which does the equivalent thing in
the core as this code is doing.  Looking at the code some symmetry
handling is required as the driver is setting the same registers for
playback and capture rates so simultaneous playback and record with
different rates is not supported?

Converting to symmetric_rates would definitely be a good thing.
