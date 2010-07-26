From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: multi-component: SAMSUNG: Modify the
	name of I2S driver
Date: Mon, 26 Jul 2010 06:08:23 -0700
Message-ID: <9966EAB7-EA0D-4FC7-A25B-CDBEB58B479F@opensource.wolfsonmicro.com>
References: <4C4CEDE1.5010605@samsung.com>
	<B9F57799-417E-4006-80D4-7768EE347BF5@opensource.wolfsonmicro.com>
	<AANLkTi=20B0K+87HeRjdKAONVjwEhar09QRmj-SB2zbO@mail.gmail.com>
	(sfid-20100726_082228_503366_E83A5854)
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E07BB1038B5
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 15:08:08 +0200 (CEST)
In-Reply-To: <AANLkTi=20B0K+87HeRjdKAONVjwEhar09QRmj-SB2zbO@mail.gmail.com>
	(sfid-20100726_082228_503366_E83A5854)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Joonyoung Shim <jy0922.shim@samsung.com>, "jassi.brar@samsung.com" <jassi.brar@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 26 Jul 2010, at 00:22, Jassi Brar <jassisinghbrar@gmail.com> wrote:

> I already talked to Ben about renaming drivers but he doesn't like the idea
> of breaking loadable drivers in distributions and I buy his opinion.
> So, Ben really has the say on the matter.

I don't think it's a big deal for distros - they will generally only explicitly load the final machine driver for a device rather than the individual component drivers which will get pulled in automatically by the kernel infrastructure anyway (either module dependencies or hotplug depending) and the board drivers keep their names.
