From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WM8580: Fix R8 initial value
Date: Thu, 9 Dec 2010 11:00:16 +0000
Message-ID: <20101209110015.GB4548@rakim.wolfsonmicro.main>
References: <1291885672-7198-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 87745103C76
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 12:00:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291885672-7198-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: sbkim73@samsung.com, sw.youn@samsung.com, alsa-devel@alsa-project.org, kgene.kim@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 09, 2010 at 06:07:52PM +0900, Jassi Brar wrote:
> From: Seungwhan Youn <sw.youn@samsung.com>
> 
> Acc to WM8580 manual, the default value for R8 is 0x10, not 0x1c.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
> ---

You really should include your signoff in patches when sending ones
written by other people to say that you're certifying that the patch is
legally OK to submit - that's what the signoff stuff is about, it's
about saying that you take responsibility for the patch.

In this case it's not so important as it's a trivially obvious fix so
probably below the individually copyrightable threashold anyway so I've
applied.
