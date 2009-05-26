From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V4 0/5] AC97 driver for mpc5200
Date: Tue, 26 May 2009 12:04:43 +0100
Message-ID: <20090526110443.GB8969@sirena.org.uk>
References: <20090525221406.21370.30326.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 85D3424729
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 13:04:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090525221406.21370.30326.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2009 at 06:15:05PM -0400, Jon Smirl wrote:

> reset retries. Removing the retries makes the driver fail to load about 5% of the time. An oscilliscope is 

Please also send a patch sorting this out in the STAC9766 driver as
requested.  Other than that and the udelay() thing it looks like we can
merge this now - there's the reset issue and probably other things to
clean up but it'd be better to do those as incremental patches.

> needed to figure out what is going on with failed resets. Both pcm030 and Efika ocasionally fail to reset 
> and they use different codec chips.

Like I say, it may be worth checking into the startup of the master
clock for the CODECs, especially if it's an output from the SoC on both
boards.
