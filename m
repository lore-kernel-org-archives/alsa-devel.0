From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: Remove NEO1973(GTA01) audio
 driver
Date: Thu, 6 Jan 2011 11:20:55 +0000
Message-ID: <20110106112055.GF746@opensource.wolfsonmicro.com>
References: <1294273308-25124-1-git-send-email-sw.youn@samsung.com>
	<AANLkTik9u5ETmdbd3MrbJfdqEYguCdVvhA2225Uks2_4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7A72624445
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 12:22:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTik9u5ETmdbd3MrbJfdqEYguCdVvhA2225Uks2_4@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, jassi.brar@samsung.com, graeme.gregory@wolfsonmicro.com, Seungwhan Youn <sw.youn@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 06, 2011 at 10:23:20AM +0900, Jassi Brar wrote:
> On Thu, Jan 6, 2011 at 9:21 AM, Seungwhan Youn <sw.youn@samsung.com> wrote:
> > This patch remove to support NEO1973(GTA01) audio driver, because we
> > don't need to support audio driver that is not supported in linux kernel.

> Seems the board support never got submitted, though I see a few hints in the
> ML archives. Assuming no such chances either in near future, I am for it.

> 'If anybody has any objections speak now or forever hold your peace' :)

I'd rather hold off on this - the OpenMoko guys are actively working on
this (there's just a couple of people doing it as a hobby project) and
I'd rather not make their lives any harder.  The last time I checked
they had reorganised things to merge the GTA01 and GTA02 into a single
machine driver.  Plus I have a GTA01 (not that I've actually used it for
years).

If there's nothing appeared upstream by the end of this release cycle
that might be a good time to look at this.
