From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH 2/3] sound/soc/lapis: add machine driver
Date: Fri, 2 Dec 2011 21:35:57 +0900
Message-ID: <CANKRQnhcA-bzcMnR2BBPStb7XgZp2pe=XE2YjKOMjUKPw2Ms5w@mail.gmail.com>
References: <1321848532-8784-1-git-send-email-tomoya.rohm@gmail.com>
	<1321848532-8784-2-git-send-email-tomoya.rohm@gmail.com>
	<20111121113433.GD3784@opensource.wolfsonmicro.com>
	<CANKRQnjdS1NvcGLa=S1M0D4U_NV3+JR1E4YfAV7Ziq-fE2LQgg@mail.gmail.com>
	<20111202114638.GI8245@opensource.wolfsonmicro.com>
	<CANKRQng5OzqjiQ81OUH+2Aet8DAM198s6B=_1FuASnd19BU26w@mail.gmail.com>
	<20111202122205.GL8245@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8068A243A7
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 13:35:58 +0100 (CET)
Received: by dadi2 with SMTP id i2so1572732dad.38
	for <alsa-devel@alsa-project.org>; Fri, 02 Dec 2011 04:35:57 -0800 (PST)
In-Reply-To: <20111202122205.GL8245@opensource.wolfsonmicro.com>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

2011/12/2 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Dec 02, 2011 at 09:09:34PM +0900, Tomoya MORINAGA wrote:
>> 2011/12/2 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>
>> > The CPU side audio drivers are not there - there seemed to be some quite
>> > serious review issues with those.
>
>> Let me clarify your saying.
>> Does the above "audio drivers" mean i2s (of south bridge) driver or HD
>> audio (of north bridge) or another?
>
> I2S and audio DMA.

OK.
As you know, I post i2s/dma driver once. I understand need to do much
modification.
I'm going to develop codec driver, machine driver and
platform(i2s/dma) driver in turn obeying modern ASoC framework.

Do you mean you cannot review this codec driver any more unless I
provide other 2 drivers (machine and platform) ?

Thanks,
tomoya
