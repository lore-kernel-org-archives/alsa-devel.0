From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 13/15] sound/soc: davinci: check kzalloc()
	result (typo)
Date: Sat, 17 Jul 2010 19:47:05 +0100
Message-ID: <20100717184705.GA27456@rakim.wolfsonmicro.main>
References: <1279296977-25267-1-git-send-email-segooon@gmail.com>
	<1279388733.3070.5.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 912B5246EA
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Jul 2010 20:47:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1279388733.3070.5.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Kulikov Vasiliy <segooon@gmail.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Miguel Aguilar <miguel.aguilar@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 17, 2010 at 06:45:33PM +0100, Liam Girdwood wrote:
> On Fri, 2010-07-16 at 20:16 +0400, Kulikov Vasiliy wrote:
> > The code checks 'davinci_vc' after kzalloc() and do not checks
> > 'davinci_vcif_dev' that kzalloc() result is assigned to. It seems that
> > it is a typo (autocompletion?).

> > Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>

> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Applied, thanks.  Kulikov could you please check the subject lines
you're using for your patches - try to be consistent with the rest of
the patches for the same code area.
