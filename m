From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: Add Aquila sound driver
Date: Thu, 8 Jul 2010 14:52:27 +0900
Message-ID: <AANLkTikHkQfmD5GPL9D-kbL7SuNksNA9tbhvoDqBeuur@mail.gmail.com>
References: <4C355AC2.8090502@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id C51442461B
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jul 2010 07:52:29 +0200 (CEST)
Received: by vws9 with SMTP id 9so644753vws.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Jul 2010 22:52:27 -0700 (PDT)
In-Reply-To: <4C355AC2.8090502@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 8, 2010 at 1:57 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch add sound support for the Aquila board based on S5PC110.
>
> The Aquila board is based on Samsung SoC(S5PC110) and include
> WM8994 codec over I2Sv5 to support sound. As there is currently
> no driver for the I2Sv5, the code to use I2Sv5 is deleted
> on this patch.
>
> After I2Sv5 driver is posted in a few weeks, I will post incremental
> patch which some codes for using I2Sv5. The owner of I2Sv5 said that
> he will post I2Sv5 driver after a few weeks.

I don't plan to create a copy of an almost copy of s3c64xx-i2s.c
Please try to use the existing sound/soc/s3c24xx/s3c64xx-i2s-v4.c
I intend to only enhance that code to enable features of 'v4', 'v5' etc.
