From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v5] sound/soc/lapis: add platform driver
	for ML7213
Date: Fri, 25 May 2012 18:30:06 +0900
Message-ID: <CANKRQnj_LdGQPYPV7d5NNZBx8oM5aAGHu4qZidiiS6C4eNtNJQ@mail.gmail.com>
References: <1331275160-31757-1-git-send-email-tomoya.rohm@gmail.com>
	<1332158459-14880-1-git-send-email-tomoya.rohm@gmail.com>
	<20120321160913.GF3226@opensource.wolfsonmicro.com>
	<CANKRQnjoGN=uvej8B1BxPHAx7NQtOORD9yJRPUc134DrVmPzNg@mail.gmail.com>
	<20120326154009.GA17506@sirena.org.uk>
	<CANKRQnhn=ALR0ucv5gnvwnxwxBQX4ajm9Jo5qC0fL-EFjDdoZg@mail.gmail.com>
	<20120523093857.GC4085@opensource.wolfsonmicro.com>
	<CANKRQnhNWC2F6zKgBMJY7HnipJbA5p-=6Lz4uGZqBKNQ688Z3w@mail.gmail.com>
	<20120524100742.GH5361@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 29CA5243C7
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2012 11:30:07 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so1746081pbb.38
	for <alsa-devel@alsa-project.org>; Fri, 25 May 2012 02:30:06 -0700 (PDT)
In-Reply-To: <20120524100742.GH5361@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 24, 2012 at 7:07 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>> > Nobody seems to be working on it as far as I can tell, I've certainly
>> > not seen any patches.
>
>> If so, could you accept current platform/machine driver ?
>
> Ideally what would be happening here is that you or other people who
> have such systems would be working to add the required support to the
> core code, there's clearly a need for common code here as there are a
> number of different systems that don't have cyclic DMA and it wouldn't
> be great to end up with duplicated code.
>
> Is there some great difficulty in factoring out the support for
> non-cyclic audio DMA on dmaengine - it seems like if there is we must
> have a serious problem in dmaengine which we should fix? =A0If there is a
> substantial difficulty then that's different but it doesn't feel like
> we've tried doing common code yet, if there's problems doing that I'd
> like to understand what they are before we jump ahead of ourselves.

I'm not so familiar with Linux's DMA idea.
So we don't know whether non-cyclic dmaengine has problem or not.

Until now, we've developed device drivers use DMA driver like UART, SPI.
These drivers are  implemented using the same way, you called
"non-cyclic", and already applied.

As you said, common code for DMA code can be best solution.
However, currently, the code is nothing.
So, I want you to accept our driver as first step.
Because I think supporting new device is more important for linux than
dmaengine common.

thanks
-- =

ROHM Co., Ltd.
tomoya
