From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ASoC: Add Jassi Brar as Samsung maintainer
Date: Mon, 27 Sep 2010 11:23:55 +0900
Message-ID: <AANLkTimRdkJL=vWddcZYGt-ip=va8Oo5s_qb1qzdYrw9@mail.gmail.com>
References: <1285402601-10131-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTik5q1B9B5V0rUHVfAXPHe7vWbxJm3dK_A6QfTJ=@mail.gmail.com>
	<AANLkTi=xEwPGsf756EG3c4sC5F4mDevoXwcMtSYnrXt_@mail.gmail.com>
	<AANLkTimf1BmDe0pPqPgi0qWYG9pb2tZVgvLQ4VVEh6K5@mail.gmail.com>
	<AANLkTimvdZP3pjYv56+AXGy5d7ceb+q1=NomH3fr1isC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id E5DFA243AE
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 04:23:55 +0200 (CEST)
Received: by bwz13 with SMTP id 13so2772105bwz.38
	for <alsa-devel@alsa-project.org>; Sun, 26 Sep 2010 19:23:55 -0700 (PDT)
In-Reply-To: <AANLkTimvdZP3pjYv56+AXGy5d7ceb+q1=NomH3fr1isC@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 26, 2010 at 7:49 PM, Kyungmin Park <kmpark@infradead.org> wrote:
>>> Good news,
>>>
>>> At the first work, can you proceed the directory name change from
>>> s3c24xx to samsung?
>>>
>>> it's really misleading and confusing to others.
>> I am currently working on overhauling the Samsung ASoC support (AC97,
>> PCM, DMA rename and I2S redesign).
>> Hopefully patches will be ready within few days.
>
> Also please consider the power consumption issues. Lower Power (LP)
> and runtime PM.
> In the previous time it's handled by multimedia team (user level) but
> they can't control it well.
> In rough idea, it creates the some interface and just toggle it either
> LP and normal.
> As you know Lower Power Audio is one of big issues at power consumption.

The Secondary fifo(overlay stereo channel) of I2Sv5 can receive data from a
dedicated h/w buffer via dedicated audio-internal DMA as well as from
system memory via system DMA(ex PL330).

LPAM(power saving by using iDMA and iBuff while system is in deep-idle mode)
is just one use of the overlay channel.
Please remember that some other user might use it purely for h/w mixing
in normal-power mode while using system RAM and DMA.
So, ATM, I am against putting any power-mode detection mechanism into
audio drivers.
IMO, it's the responsibility of user-space to setup routes/modes to
serve it's purpose.

Anyways, I am open to suggestions. Mr Choi may ping me anytime.

Thanks.
