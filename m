From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 0/4] mpc5200 audio rework for AC97
Date: Mon, 25 May 2009 11:43:29 +0100
Message-ID: <20090525104329.GE18290@sirena.org.uk>
References: <20090525013606.3073.86753.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 32BD3103857
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 12:43:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090525013606.3073.86753.stgit@terra>
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
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, May 24, 2009 at 09:38:45PM -0400, Jon Smirl wrote:
> The following series implements audio support for the mpc5200. It adds an AC97 driver and STAC9766 codec driver. 
> Board support for the Efika and Phytec pcm030 are also included.

> I've tried to implement the feedback received on the previous two versions.

Please also add the fixes for the reset code in the CODEC driver that I
asked for.
