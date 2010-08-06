From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: S3C64XX: Add ADC source
	clock	setting
Date: Fri, 6 Aug 2010 17:49:29 +0100
Message-ID: <20100806164928.GI31326@sirena.org.uk>
References: <1281053592-3311-1-git-send-email-sw.youn@samsung.com>
	<1281054064-4730-1-git-send-email-sw.youn@samsung.com>
	<20100806102619.GC398@rakim.wolfsonmicro.main>
	<AANLkTin=X3YsTA_cR5ocAML2vLC14HCzbi-qvFhPQz8z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BA4881037F9
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 18:49:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTin=X3YsTA_cR5ocAML2vLC14HCzbi-qvFhPQz8z@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <claude.youn@gmail.com>
Cc: Seungwhan Youn <sw.youn@samsung.com>, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 07, 2010 at 01:28:47AM +0900, Seungwhan Youn wrote:
> On Fri, Aug 6, 2010 at 7:26 PM, Mark Brown

> > This isn't a patch for S3C64xx, this is a patch for the SMDK boards.

> Can I go-ahead this ADC_MCLK patches? or will you have a plan to
> handle this also?

Not really much point if we do the clocking properly - it changes over
to specifying the clock to via set_sysclk() so there's a code change
implied.
