From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH] ASoC: au1x: convert to platform drivers.
Date: Mon, 2 Nov 2009 12:59:20 +0100
Message-ID: <f861ec6f0911020359w1745d1c4h137ce098df1959f1@mail.gmail.com>
References: <1257016508-13195-1-git-send-email-manuel.lauss@gmail.com>
	<20091102113247.GE29351@sirena.org.uk>
	<f861ec6f0911020339x3816f6c0oe8ec935800f9f56a@mail.gmail.com>
	<20091102115354.GG29351@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BE8810382C
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 12:59:23 +0100 (CET)
Received: by bwz9 with SMTP id 9so19926478bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 02 Nov 2009 03:59:21 -0800 (PST)
In-Reply-To: <20091102115354.GG29351@sirena.org.uk>
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
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 2, 2009 at 12:53 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Nov 02, 2009 at 12:39:11PM +0100, Manuel Lauss wrote:
>
>> Great, thanks. =A0I'll add you to all other asoc related patches in the =
future.
>> Off-topic: I'm not really up-to-date on ASoC; how is multi-device support
>> coming along? =A0I received a new system which has 2 independet audio
>> systems, one with AC97 WM9715 + touchscreen, the other I2S. =A0Some day
>> I'd like to support the touch interface and I2S at the same time ;-)
>
> If they're two completely unrelated audio subsystems then it might
> actually work at the minute if you register two ASoC devices with
> different device numbers, I've had reports that people are succesfully
> doing this.

They're independent of each other, attached to 2 of the 4 PSCs.  I'll try
the most obvious path first.

Thanks!
     Manuel Lauss
