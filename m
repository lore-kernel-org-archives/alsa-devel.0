From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv4 17/18] ASoC: Samsung: Generalize Kconfig
	symbols
Date: Tue, 23 Nov 2010 14:25:49 +0000
Message-ID: <20101123142549.GJ18960@rakim.wolfsonmicro.main>
References: <1290407690-28917-1-git-send-email-jassisinghbrar@gmail.com>
	<1290407842-29591-1-git-send-email-jassisinghbrar@gmail.com>
	<20101123141255.GH18960@rakim.wolfsonmicro.main>
	<AANLkTik=eFwdN5UjhKWGe5Os_SwTE=uH++s6Xu+0zxVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AA14C103A88
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 15:25:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTik=eFwdN5UjhKWGe5Os_SwTE=uH++s6Xu+0zxVA@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 23, 2010 at 11:16:57PM +0900, Jassi Brar wrote:

> If SND_SOC is to be used across all platforms, my changes are indeed
> out of line.
> Otherwise, ASOC represents SND_SOC better and compactly.

I agree it's probably a slightly better name but everything else is
using SND_SOC_ already...

> > I've applied this just now as the rename patch depends on it.

> Ok, though I was/am willing to submit yet another revision.

No need for that, the series is sufficiently useful (and lengthy to
review!) for this to be a fairly minor detail.
