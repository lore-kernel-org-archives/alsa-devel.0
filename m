From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC V2: restrict sample rate
	and	size in Freescale MPC8610 sound drivers
Date: Mon, 4 Aug 2008 17:43:38 +0100
Message-ID: <20080804164337.GA4193@sirena.org.uk>
References: <1217867506-19730-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D1682103833
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Aug 2008 18:43:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1217867506-19730-1-git-send-email-timur@freescale.com>
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

On Mon, Aug 04, 2008 at 11:31:46AM -0500, Timur Tabi wrote:

> A future version of this driver will lift the sample size restriction.
> Supporting independent sample rates is more difficult, because only certain
> codecs provide dual independent clocks.

Generally the approach here is for the platform drivers to allow as much
flexability as they can and rely on the codec and/or machine drivers to
restrict things as needed.  Even where both codec and platform can
support separate clocks they can be made shared by the board design.

> Signed-off-by: Timur Tabi <timur@freescale.com>

Appled, thanks.
