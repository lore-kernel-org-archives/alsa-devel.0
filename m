From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [Q] playing / recording mono on a stereo-only
 hardware
Date: Thu, 4 Feb 2010 21:24:18 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1002042120310.19438@axis700.grange>
References: <Pine.LNX.4.64.1001301045500.4260@axis700.grange>
	<Pine.LNX.4.64.1001301744580.9593@axis700.grange>
	<4B683B48.1030707@gandalf.sssup.it>
	<Pine.LNX.4.64.1002021552450.6324@axis700.grange>
	<4B683DDC.5030209@gandalf.sssup.it>
	<Pine.LNX.4.64.1002021606340.6324@axis700.grange>
	<4B6843E1.4050001@gandalf.sssup.it>
	<Pine.LNX.4.64.1002021733550.6324@axis700.grange>
	<4f3252891002021807x4276d0b8y4c61c69aee2af3dc@mail.gmail.com>
	<Pine.LNX.4.64.1002032310230.19438@axis700.grange>
	<4f3252891002031612g5d384eb6o851f690f94b7945a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 291F410387B
	for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2010 21:24:25 +0100 (CET)
In-Reply-To: <4f3252891002031612g5d384eb6o851f690f94b7945a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 4 Feb 2010, Raymond Yau wrote:

I would see your reply sooner, if you used reply-to-all.

> if LIBASOUND_DEBUG = 1 cannot tell you which parameter fail in hw_params() ,
> you will need to define RULES_DEBUG in alsa-kernel/core/pcm_native.c and
> compile driver with debug=verbose
> 
> -#undef RULES_DEBUG
> +#define RULES DEBUG 1

That's already on too. Not sure what you mean by "compile driver with 
debug=verbose," supposedly, some kernel ALSA debug parameter. Since this 
is my driver, I can certainly add any debugging there, but it seems 
obvious to me, that the kernel is still getting a mono configuration, 
which shouldn't be the cae.

> you can find out how ALSA refine the hw parameters by examing the system log

If you mean "dmesg" output, then, as I said, there isn't much to look for 
there - the kernel is configured for mono...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
