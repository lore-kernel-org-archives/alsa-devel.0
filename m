From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: UDA1380: refactor device registration
Date: Mon, 15 Jun 2009 22:10:23 +0100
Message-ID: <20090615211022.GA23241@sirena.org.uk>
References: <20090614145128.GB4482@sirena.org.uk>
	<1245097103-9486-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BE951103817
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 23:10:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1245097103-9486-1-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 15, 2009 at 10:18:23PM +0200, Philipp Zabel wrote:
> This patch mostly follows commit 5998102b9095fdb7c67755812038612afea315c5
> "ASoC: Refactor WM8731 device registration" to make UDA1380 use standard
> device instantiation. Similarly, the I2C device registration temporarily
> moves into the magician machine driver before it will find its final
> resting place in the board file.
> 
> At the same time, platform specific configuration is moved to platform data
> and common power/reset GPIO handling moves into the codec driver.

> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

Great stuff, applied thanks.
