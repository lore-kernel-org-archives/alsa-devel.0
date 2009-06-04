From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] Palm interrupt driven touchscreen driver
Date: Thu, 4 Jun 2009 09:35:17 +0800
Message-ID: <f17812d70906031835u5a650772wedcab94fd6f2ae2d@mail.gmail.com>
References: <200906032341.03266.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B2171037FF
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 03:35:19 +0200 (CEST)
Received: by qyk1 with SMTP id 1so703586qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2009 18:35:18 -0700 (PDT)
In-Reply-To: <200906032341.03266.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 4, 2009 at 5:41 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Hi,
>
> this patch adds interrupt driven touchscreen driver. It's an addition to
> mainstone-wm97xx, but does some reorganization of the code there.
>
> Mark, it's the same patch we discussed on IRC, so it should be OK.
>

Mark, the driver looks generic enough to me, is there some specific
reason this remains named "mainstone-wm97xx.c"?

I didn't look into the code too much, yet I'm wondering if it's possible
to come up with a platform_data to cover the difference of boards
and make this driver generic.
