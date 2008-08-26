From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Fix error paths in N810 machine
	driver init and release clocks at exit
Date: Tue, 26 Aug 2008 11:35:43 +0100
Message-ID: <20080826103541.GC24258@sirena.org.uk>
References: <1219746777-17328-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BAA5103850
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 12:35:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1219746777-17328-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 26, 2008 at 01:32:57PM +0300, Jarkko Nikula wrote:
> Thanks to Felipe Balbi <felipe.balbi@nokia.com> by noticing that if clk_get
> to sys_clkout2_src fails, then n810_snd_device is never released.

> Add also sys_clkout2_src release into error path, error code return and
> release the clocks at exit.

> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
