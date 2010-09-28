From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: how to mandate the use of PCM plugin?
Date: Tue, 28 Sep 2010 09:38:14 +0400
Message-ID: <4CA17F46.2050305@aknet.ru>
References: <4C9F6409.6010400@aknet.ru> <20100927005858.GD21247@sirena.org.uk>
	<4CA0221D.6030208@aknet.ru>
	<20100927055438.GA13129@opensource.wolfsonmicro.com>
	<4CA03F7D.8040602@aknet.ru>
	<20100927220012.GA7817@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.28])
	by alsa0.perex.cz (Postfix) with ESMTP id B1E4910387F
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Sep 2010 07:39:20 +0200 (CEST)
In-Reply-To: <20100927220012.GA7817@opensource.wolfsonmicro.com>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  28.09.2010 02:00, Mark Brown wrote:
> I can't really comment since I've no idea what the problem is; if it's
> not understood what has gone wrong then some diagnosis will be needed.
For now, all I can say is that the softvol
doesn't communicate with pulseaudio when
snd-pcsp is used. You can alter it, but the
playback volume won't change. And if you
run the pulseaudio mixer in parallel, it won't
reflect the change done by alsamixer too.
Likewise, the alsamixer won't reflect the volume
change of pa. So it is completely disconnected.
If I redefine the softvol from "Master Playback Volume"
to "PCM Playback Volume", then it starts to
reflect the state of the pa volume, but not the
other way around.
And with other drivers, that seemingly use the
softvol too, everything works. But that's a bit
odd, since the driver should have nothing to
do with softvol...

> The entire plugin stack is subject to customisation.
>
OK, thanks for the info.
Then some debugging is a due.

>> So what the real fix do you think of?
> Like I say, I've no idea what the actual problem is so can't really
> comment.
softvol doesn't communicate with pulseaudio,
when snd-pcsp is used. That's all about it. :)
But I'll try to find time for some debugging, thank you.
