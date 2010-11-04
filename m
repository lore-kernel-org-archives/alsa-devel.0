From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Hang in snd_pcm_writei with alsa-pulse plugin
Date: Thu, 4 Nov 2010 11:29:39 +0800
Message-ID: <AANLkTinxDcSmpRfvp560AzzG3a-5BX9RdVfiG2qLzqiD@mail.gmail.com>
References: <20101101013819.GA22823@flim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C663103834
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 04:29:42 +0100 (CET)
Received: by ewy22 with SMTP id 22so876463ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 03 Nov 2010 20:29:39 -0700 (PDT)
In-Reply-To: <20101101013819.GA22823@flim.org>
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

2010/11/1 Matthew Gregan <kinetik@flim.org>

> Hi,
>
>
> I've attached a simple test program that reproduces this problem reliably
> on
> my machine.  It writes a period sized buffer in a loop, waiting half a
> period until the next attempt.  Every few iterations, it pauses the sound
> device for half a period and then resumes it.  It usually hangs within 2-3
> pause/resume cycles.  Running the test with "-r" enables the recovery code
> I
> mentioned above.  It never hangs when tested using the hardware ALSA
> backend
> with alsa-pulse disabled, but my sound hardware doesn't seem to support
> snd_pcm_pause.
>
>
when increase the sleep time from half period to one period, the hang occur
after around 50 pause/resume cycles.

did PA server  stop sending data to the sound card immediately when your
program pause ?

But cannot reproduce your problem using the "pause" function of aplay

which sound card are you using and did you change the pulseaudlo daemon.conf
?
