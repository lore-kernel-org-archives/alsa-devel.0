From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: multi-component - Modify to use
 common S3C I2S features
Date: Thu, 15 Jul 2010 12:54:01 +0100
Message-ID: <20100715115401.GH23529@rakim.wolfsonmicro.main>
References: <lrg@slimlogic.co.uk> <broonie@opensource.wolfsonmicro.com>
	<jassisinghbrar@gmail.com> <claude.youn@gmail.com>
	<1279184328-31746-1-git-send-email-sw.youn@samsung.com>
	<1279184328-31746-2-git-send-email-sw.youn@samsung.com>
	<20100715093220.GE23529@rakim.wolfsonmicro.main>
	<AANLkTimKZGCYPp5ElEPthi8YY7fbSPMldRQVWDZe0HzX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B06E7245A4
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 13:54:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimKZGCYPp5ElEPthi8YY7fbSPMldRQVWDZe0HzX@mail.gmail.com>
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
Cc: Jassi Brar <jassisinghbrar@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 15, 2010 at 08:33:28PM +0900, Seungwhan Youn wrote:

> Does your comment means that 'i2s->base' get base address from the
> resources for the platform device using 'platform_get_resources()'?

Yes, exactly.

> I'm doing on preparing that issue into another patch already (because
> I think this patch is only for Liam's multi-comp, not for that issue).

My comment was that since this patch is going so far towards doing the
move to pulling the data from the platform device it'd make sense to
just do that as part of this patch rather than introduce a temporary
workaround.  It's not really any extra effort and it's much nicer.
