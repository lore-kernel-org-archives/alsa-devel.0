From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2.6.30] ASoC: remove trigger delay
	in	Freescale MPC8610 sound driver
Date: Thu, 26 Mar 2009 14:28:59 +0000
Message-ID: <20090326142859.GG3771@sirena.org.uk>
References: <1238023237-28558-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 55AED2412E
	for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2009 15:29:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1238023237-28558-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 25, 2009 at 06:20:37PM -0500, Timur Tabi wrote:
> Remove the delay from the trigger function in the Freescale MPC8610 sound
> driver when capture is started.  This delay was used to ensure that the DMA
> controller was active when ALSA call the .pointer function to request a
> DMA transfer status.  A better approach is for the .pointer function to detect
> that DMA has not started, and return zero instead.  This change eliminates
> the need for the delay.

> Also add some related code to check for a DMA programming error, and report
> XRUN if it occurs.

> Signed-off-by: Timur Tabi <timur@freescale.com>

Applied, thanks!
