From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WM8580: Debug interface index
Date: Fri, 3 Dec 2010 16:39:32 +0000
Message-ID: <20101203163932.GX859@rakim.wolfsonmicro.main>
References: <1291340065-16897-1-git-send-email-jassi.brar@samsung.com>
	<1291376076.3271.32.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A744A10384A
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 17:39:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291376076.3271.32.camel@odin>
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
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 03, 2010 at 11:34:36AM +0000, Liam Girdwood wrote:
> On Fri, 2010-12-03 at 10:34 +0900, Jassi Brar wrote:
> > We want the index of DAI's driver here.

> It's fine but could you add a little more context here.

Yes, please.  Indeed, the DAI ID should be being initialised from the
driver ID by the core so it's a bit surprising if they diverge - why do
we want the driver index?  Though I've gone ahead and applied anyway as
at worst it's a noop.
