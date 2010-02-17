From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Wed, 17 Feb 2010 16:24:35 +0900
Message-ID: <1b68c6791002162324kbeb220dm23031e3115e617ca@mail.gmail.com>
References: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
	<4B7B9387.1070506@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 443361037F7
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 08:24:37 +0100 (CET)
Received: by vws18 with SMTP id 18so533416vws.38
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 23:24:35 -0800 (PST)
In-Reply-To: <4B7B9387.1070506@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2010 at 3:58 PM, Joonyoung Shim <jy0922.shim@samsung.com> wrote:
> Additionally, i have one more question.
>
> At the ASoC, is there a situation to share the dai(cpu or codec)?
Currently, ASOC doesn't allow sharing cpu or codec dai.

> If the dai is shared, i just think the ASoC core cannot support it.
Correct.

> There is the case at the S5PC1XX, it supports the hardware mixing by
> using two tx fifo. First Jassi implemented codes using each other cpu
> dai as Jassi says at the above for the hardware mixing, but it should
> share codec_dai and need some modification of ASoC core.
> (I can see codes at the below url
> http://git.kernel.org/?p=linux/kernel/git/kki_ap/linux-2.6-samsung.git)
> Jassi, how do you think about this?
Though outside this topic, please see latest code from samsung GIT.
I already share wm8580 dai with I2S primary_fifo dai as well
as secondary_fifo dai. I implemented temporary workaround to share
dais(luckily codec_dai wasn't used in a way to make it impossible,
though cpu_dai still can't be shared).
Also, there is some reason I didn't point to our repository:- the code is
not meant for mainline. It's just a 'workaround' for urgent requirement.

Now, I wud like to get back to getting suggestions about how to
approach the solution from mainline's POV rather than discussing
Samsung's internal code.
