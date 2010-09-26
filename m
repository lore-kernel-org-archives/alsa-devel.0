From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] ASoC: Add Jassi Brar as Samsung maintainer
Date: Sun, 26 Sep 2010 19:49:42 +0900
Message-ID: <AANLkTimvdZP3pjYv56+AXGy5d7ceb+q1=NomH3fr1isC@mail.gmail.com>
References: <1285402601-10131-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTik5q1B9B5V0rUHVfAXPHe7vWbxJm3dK_A6QfTJ=@mail.gmail.com>
	<AANLkTi=xEwPGsf756EG3c4sC5F4mDevoXwcMtSYnrXt_@mail.gmail.com>
	<AANLkTimf1BmDe0pPqPgi0qWYG9pb2tZVgvLQ4VVEh6K5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 9C21624149
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Sep 2010 12:49:42 +0200 (CEST)
Received: by wya21 with SMTP id 21so1094383wya.38
	for <alsa-devel@alsa-project.org>; Sun, 26 Sep 2010 03:49:42 -0700 (PDT)
In-Reply-To: <AANLkTimf1BmDe0pPqPgi0qWYG9pb2tZVgvLQ4VVEh6K5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 26, 2010 at 7:41 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Sun, Sep 26, 2010 at 7:38 PM, Kyungmin Park <kmpark@infradead.org> wrote:
>> Good news,
>>
>> At the first work, can you proceed the directory name change from
>> s3c24xx to samsung?
>>
>> it's really misleading and confusing to others.
> I am currently working on overhauling the Samsung ASoC support (AC97,
> PCM, DMA rename and I2S redesign).
> Hopefully patches will be ready within few days.

Also please consider the power consumption issues. Lower Power (LP)
and runtime PM.
In the previous time it's handled by multimedia team (user level) but
they can't control it well.
In rough idea, it creates the some interface and just toggle it either
LP and normal.
As you know Lower Power Audio is one of big issues at power consumption.

I'm not sure runtime PM is required for audio since ALSA control the
codec well. but try to reduce the power as we can.

Thank you,
Kyungmin Park
