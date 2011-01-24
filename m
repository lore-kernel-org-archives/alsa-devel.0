From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] SoC: Samsung: Fix outdated cpu_dai_name
 for s3c24xx i2s
Date: Mon, 24 Jan 2011 20:31:19 +0900
Message-ID: <AANLkTim2L=ybmFhFXkQ+h_FrqQuMzzt9tHj_+WMgbyN5@mail.gmail.com>
References: <1295735888-25527-1-git-send-email-lars@metafoo.de>
	<1295735888-25527-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id CB1BF2446F
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 12:31:20 +0100 (CET)
Received: by bwz10 with SMTP id 10so3519473bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 03:31:20 -0800 (PST)
In-Reply-To: <1295735888-25527-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "for 2.6.37" <stable@kernel.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 23, 2011 at 7:38 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> During the multi-component patch the s3c24xx i2s driver was renamed from
> "s3c24xx-i2s" to "s3c24xx-iis", while the sound board drivers were not
> updated to reflect this change as well.
>
> As a result there is no match between the dai_link and the i2s driver and no
> sound card is instantiated.
>
> This patch fixes the problem by updating the sound board drivers to use
> "s3c24xx-iis" for the cpu_dai_name.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: stable@kernel.org (for 2.6.37)

Acked-by: Jassi Brar <jassi.brar@samsung.com>
