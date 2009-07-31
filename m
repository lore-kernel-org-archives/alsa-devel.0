From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: jack: Fix race in
 snd_soc_jack_add_gpios
Date: Fri, 31 Jul 2009 22:31:10 +0100
Message-ID: <20090731213108.GA6335@sirena.org.uk>
References: <1249067725-25791-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 85D00246EF
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Jul 2009 23:31:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1249067725-25791-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 31, 2009 at 09:15:25PM +0200, Lars-Peter Clausen wrote:
> The irq can fire as soon as it has been requested, thus all fields accessed
> from within the irq handler must be initialized prior to requesting the irq.

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied, thanks.
