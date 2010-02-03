From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [Q] playing / recording mono on a stereo-only
	hardware
Date: Wed, 3 Feb 2010 10:07:59 +0800
Message-ID: <4f3252891002021807x4276d0b8y4c61c69aee2af3dc@mail.gmail.com>
References: <Pine.LNX.4.64.1001301045500.4260@axis700.grange>
	<4B645E51.900@gandalf.sssup.it>
	<Pine.LNX.4.64.1001301744580.9593@axis700.grange>
	<4B683B48.1030707@gandalf.sssup.it>
	<Pine.LNX.4.64.1002021552450.6324@axis700.grange>
	<4B683DDC.5030209@gandalf.sssup.it>
	<Pine.LNX.4.64.1002021606340.6324@axis700.grange>
	<4B6843E1.4050001@gandalf.sssup.it>
	<Pine.LNX.4.64.1002021733550.6324@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 61C9E103802
	for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2010 03:08:00 +0100 (CET)
Received: by pxi3 with SMTP id 3so821834pxi.16
	for <alsa-devel@alsa-project.org>; Tue, 02 Feb 2010 18:07:59 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1002021733550.6324@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/2/3 Guennadi Liakhovetski <g.liakhovetski@gmx.de>

> On Tue, 2 Feb 2010, Michael Trimarchi wrote:
>
> > I have tested it on the no-bluetooth interface. What is your testing
> > application and the reporting error?
>
> Using aplayer / arecord, I posted a couple of logs in other threads, see,
> e.g., http://thread.gmane.org/gmane.linux.alsa.user/33861 and a log with
> some debugging http://pastebin.ca/1773284
>
> Thanks
> Guennadi
>

 Try

export LIBASOUND_DEBUG=1
arecord -v -Dplughw:0,0 -c 1 -f S16_LE -r 800 -d 30  any.wav
