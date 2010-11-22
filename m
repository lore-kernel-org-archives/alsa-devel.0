From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ASoC: s3c24xx: test wrong variable
Date: Tue, 23 Nov 2010 06:53:58 +0900
Message-ID: <AANLkTimXOk8FXK5NqbuW9qa6HUt5_4Fgvc+7h8OrJO_j@mail.gmail.com>
References: <1290361223-15211-1-git-send-email-segoon@openwall.com>
	<20101122140002.GB18960@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 51A162448D
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 22:54:02 +0100 (CET)
Received: by fxm10 with SMTP id 10so367617fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 13:53:58 -0800 (PST)
In-Reply-To: <20101122140002.GB18960@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Vasiliy Kulikov <segoon@openwall.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 22, 2010 at 11:00 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Nov 21, 2010 at 08:40:21PM +0300, Vasiliy Kulikov wrote:
>> After clk_get() mclk is checked three times instead of mout_epll
>> and sclk_spdif checks.
>>
>> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
>
> Applied, thanks.

Wierd, it is CC to me as well but I didn't receive it.
Though the change is ok.
