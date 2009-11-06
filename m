From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] S3C64XX I2S: Enable audio-bus clock
Date: Fri, 6 Nov 2009 23:48:30 +0900
Message-ID: <1b68c6790911060648w8a3bca6te94ae2fcd221f1ae@mail.gmail.com>
References: <1257498024-29163-1-git-send-email-jassi.brar@samsung.com>
	<20091106131330.GB10371@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id E617F24733
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 15:48:31 +0100 (CET)
Received: by pwj16 with SMTP id 16so1523657pwj.32
	for <alsa-devel@alsa-project.org>; Fri, 06 Nov 2009 06:48:30 -0800 (PST)
In-Reply-To: <20091106131330.GB10371@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 6, 2009 at 10:13 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Nov 06, 2009 at 06:00:24PM +0900, Jassi Brar wrote:
>> Added the missing clk_enable after acquiring the 'audio-bus' clock.
>
> I'll apply this but I beleive the driver ought to be smarter with the
> clocks - AFAICT from the documentation the audio bus clock is not
> guaranteed to be needed.
this patch only adds the missing code, its no modification.
s3c64xx-i2s driver sure needs to be upgraded, which i plan to do soon if
nobody else does.
