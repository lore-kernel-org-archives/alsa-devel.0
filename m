From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: RX1950: Fix hw_params function
Date: Mon, 15 Nov 2010 11:07:59 +0000
Message-ID: <1289819279.3377.12.camel@odin>
References: <1289652821-5435-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DBA91037F9
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 12:08:03 +0100 (CET)
Received: by wyg36 with SMTP id 36so3481869wyg.38
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 03:08:02 -0800 (PST)
In-Reply-To: <1289652821-5435-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2010-11-13 at 14:53 +0200, Vasily Khoruzhick wrote:
> Unfortunatelly, I misunderstood datasheet, and on s3c244x-iis
> when MPLLin source for master clock is selected, prescaler has
> no effect. Remove dividor calculation for 44100 rate; remove 88200
> rate at all, rx1950 can't do it.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
