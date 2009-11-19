From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: Patches for Samsung SoC PCM Controller driver
Date: Thu, 19 Nov 2009 13:25:47 +0900
Message-ID: <1b68c6790911182025p4390faefvc8594d5e49dabd0@mail.gmail.com>
References: <1258444397-23576-1-git-send-email-jassi.brar@samsung.com>
	<20091118130643.GC6592@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4355524456
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2009 05:25:50 +0100 (CET)
Received: by pxi9 with SMTP id 9so1271575pxi.16
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 20:25:48 -0800 (PST)
In-Reply-To: <20091118130643.GC6592@rakim.wolfsonmicro.main>
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

On Wed, Nov 18, 2009 at 10:06 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Nov 17, 2009 at 04:53:17PM +0900, Jassi Brar wrote:
>
>> Samsung SoCs S3C2450, S3C64XX and later versions have got PCM controllers
>> which drive what the ALSA stack terms DSP_A/DSP_B formats.
>
> Applied all except patch 4, thanks.
>
> Please do try to follow the subject line conventions for the subsystem
> you're submitting to when sending patches - it makes them much easier to
> apply.

well, the patches that were neither 64xx nor PCM specific, we marked
"S3C AUDIO", those specific were marked "S3C64XX PCM" and the driver
was marked "S3C PCM" since that is supposed to run all PCM controllers
of S3C series.
Thanks.
