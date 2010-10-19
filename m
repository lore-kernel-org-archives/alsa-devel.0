From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 00/25] ASoC: Overhaul Samsung drivers
Date: Tue, 19 Oct 2010 02:56:02 -0700
Message-ID: <20101019095602.GA12173@opensource.wolfsonmicro.com>
References: <1287471805-17952-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2943C10387D
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 11:56:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1287471805-17952-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 19, 2010 at 04:03:25PM +0900, Jassi Brar wrote:

>   Simple testing of 5.1 channel and hardware mixing seems to work (though
> there seems to be some issue with symmetric_rates in soc-core.c which
> would be tried to fix later as saperate issue).

symmetric_rates can only cope with straight through DAIs.  It'd need a
substantial overhaul to be able to be told about multiple DAIs all
needing to share the same link.  We need to do something about this
anyway for multi-drop DAI links, provide some way of saying that
multiple DAI links share clocks and need to have their configurations
kept in lockstep.
