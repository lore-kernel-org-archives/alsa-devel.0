From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 2/2] SoC: Samsung: Fix outdated
 cpu_dai_name for s3c24xx i2s
Date: Tue, 25 Jan 2011 10:44:26 +0900
Message-ID: <AANLkTino6vc5h7MrxZTkxcpXba3TZedrD+70F49VOAPA@mail.gmail.com>
References: <1295903363-4433-1-git-send-email-lars@metafoo.de>
	<1295903562-4564-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4751B103848
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 02:44:27 +0100 (CET)
Received: by bwz10 with SMTP id 10so4270743bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 17:44:27 -0800 (PST)
In-Reply-To: <1295903562-4564-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 25, 2011 at 6:12 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
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

Acked-by: Jassi Brar <jassi.brar@samsung.com>
