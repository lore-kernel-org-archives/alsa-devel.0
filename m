From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA issue on DA850/OMAP-L138/AM18x
Date: Tue, 18 Jan 2011 19:16:27 +0000
Message-ID: <20110118191626.GA17591@sirena.org.uk>
References: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0@dbde02.ent.ti.com>
	<87ei8aytpj.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B8D162417E
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 20:16:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87ei8aytpj.fsf@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Rajashekhara,
	Sudhakar" <sudhakar.raj@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 18, 2011 at 10:04:08AM -0800, Kevin Hilman wrote:
> "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com> writes:

> > On DA850/OMAP-L138/AM18x, AIC3x codec is at 0x18 slave address.
> > But in sound/soc/davinci/davinci-evm.c file, "struct snd_soc_dai_link"
> > has the wrong AIC3x codec slave address. This patch fixes this issue.

> As suggested by Sergei...

> This part should be one patch, and merged by Liam via ASoC tree for
> 2.6.38-rc cycle.

When reposting remember to CC the maintainers for the subsystem on the
patch (as always when posting patches).
