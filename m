From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: build fix for snd_soc_info_bool_ext
Date: Sat, 10 May 2008 15:37:36 +0100
Message-ID: <20080510143732.GA7124@sirena.org.uk>
References: <1210421259.3876.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 48DB624423
	for <alsa-devel@alsa-project.org>;
	Sat, 10 May 2008 16:37:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1210421259.3876.3.camel@localhost.localdomain>
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

On Sat, May 10, 2008 at 02:07:39PM +0200, Philipp Zabel wrote:

> ???I suspect that ???snd_ctl_boolean_mono should have been
> snd_ctl_boolean_mono_info instead. This fixes the build for magician.

> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

Looks like you're right there - thanks.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
