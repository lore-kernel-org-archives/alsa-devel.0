From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2.6.29] ASoC: fix registration of the
	SOC	card in the Freescale MPC8610 drivers
Date: Tue, 20 Jan 2009 20:32:28 +0000
Message-ID: <20090120203227.GD6864@sirena.org.uk>
References: <1232406864-25421-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EA72D103856
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 21:32:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1232406864-25421-1-git-send-email-timur@freescale.com>
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

On Mon, Jan 19, 2009 at 05:14:24PM -0600, Timur Tabi wrote:
> The Freescale MPC8610 driver was defining two SOC card (snd_soc_card) structures,
> partially initializing each one, but registering only one of them with ASoC.

> Signed-off-by: Timur Tabi <timur@freescale.com>

Applied, thanks.
