From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: multi-component - Add to support
	AC97 codec driver on SMDK
Date: Thu, 15 Jul 2010 20:21:41 +0900
Message-ID: <AANLkTik5xYRLLjL6kAe7wW9GyxyMKu_sdBYTPMCWMLIS@mail.gmail.com>
References: <lrg@slimlogic.co.uk> <broonie@opensource.wolfsonmicro.com>
	<jassisinghbrar@gmail.com> <claude.youn@gmail.com>
	<1279184328-31746-1-git-send-email-sw.youn@samsung.com>
	<1279184328-31746-2-git-send-email-sw.youn@samsung.com>
	<1279184328-31746-3-git-send-email-sw.youn@samsung.com>
	<20100715093403.GF23529@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AF381037F3
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 13:21:42 +0200 (CEST)
Received: by wyf19 with SMTP id 19so622353wyf.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2010 04:21:41 -0700 (PDT)
In-Reply-To: <20100715093403.GF23529@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 15, 2010 at 6:34 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Jul 15, 2010 at 05:58:48PM +0900, Seungwhan Youn wrote:
>> This patch adds AC97 codec driver for SMDK board.
>
> We already have a driver for this in mainline (which you are modifying).
> It looks like what you're actually doing is registering a device for the
> AC'97 CODEC so things probe.
>

Okay, I'll fix this.

Thanks

Claude
