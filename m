From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: how to mandate the use of PCM plugin?
Date: Tue, 28 Sep 2010 17:36:04 +0800
Message-ID: <AANLkTikBYgWHLBBUfLPdseaPvqYTJhMVfzznm50o5gdH@mail.gmail.com>
References: <4C9F6409.6010400@aknet.ru> <20100927005858.GD21247@sirena.org.uk>
	<4CA0221D.6030208@aknet.ru>
	<20100927055438.GA13129@opensource.wolfsonmicro.com>
	<4CA03F7D.8040602@aknet.ru>
	<20100927220012.GA7817@opensource.wolfsonmicro.com>
	<4CA17F46.2050305@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 95332103820
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Sep 2010 11:36:04 +0200 (CEST)
Received: by eye27 with SMTP id 27so1695035eye.38
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2010 02:36:04 -0700 (PDT)
In-Reply-To: <4CA17F46.2050305@aknet.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/9/28 Stas Sergeev <stsp@aknet.ru>

>  28.09.2010 02:00, Mark Brown wrote:
> > I can't really comment since I've no idea what the problem is; if it's
> > not understood what has gone wrong then some diagnosis will be needed.
> For now, all I can say is that the softvol
> doesn't communicate with pulseaudio when
> snd-pcsp is used. You can alter it, but the
> playback volume won't change. And if you
> run the pulseaudio mixer in parallel, it won't
> reflect the change done by alsamixer too.
>

AFAIK, PA probe "hw" device for mono output profile first .

As snd-pcsp support only mono , PA expect "front" device support stereo so
it cannot create stereo output profile

So it is incorrect to define "front" device to use "hw" without "plug"
plugin  when the pcsp does not support stereo

 http://0pointer.de/blog/projects/decibel-data.html

finally falling back to software for everything that cannot be done in
hardware.
