From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Duplicate wake-ups in pcm_lib.c
Date: Mon, 11 Jan 2010 12:11:58 +0800
Message-ID: <4f3252891001102011l603d30cdlbe2a14163bbc7405@mail.gmail.com>
References: <6160a5130912231228g29669e4ctfef9ea8f42633120@mail.gmail.com>
	<alpine.LNX.2.00.0912240922460.2598@eeebox2.perex-int.cz>
	<6160a5131001062059i1ef74831p4210987579feb759@mail.gmail.com>
	<alpine.LNX.2.00.1001071552060.4210@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f184.google.com (mail-pz0-f184.google.com
	[209.85.222.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 477831037F5
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 05:12:01 +0100 (CET)
Received: by pzk14 with SMTP id 14so1476522pzk.23
	for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2010 20:11:58 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1001071552060.4210@eeebox2.perex-int.cz>
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

2010/1/7 Jaroslav Kysela <perex@perex.cz>

> On Wed, 6 Jan 2010, pl bossart wrote:
>
>
>
> The improved and more clean fix in now in my tree:
>
>
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=1250932e48d3b698415b1f04775433cf1da688d6
>
> Note that you should apply these 4 patches (in reverse order):
>
> 4: ALSA: pcm_lib - optimize wake_up() calls for PCM I/O
> 3: ALSA: pcm_lib - cleanup & merge hw_ptr update functions
> 2: ALSA: pcm_lib - add possibility to log last 10 DMA ring buffer positions
> 1: ALSA: pcm_lib.c - convert second xrun_debug() parameter to use defines
>
> Patch #3 should definitely fix problems with large avail or delay values
> reported in PA. I finally figured the culprit (and decide to cleanup all
> relevant code rather do just another workaround). In other words, new
> hw_ptr pointer should never be less than previous one now.
>
>                                                Jaroslav
>
> -
>

using alsa-driver-1.0.22.1.1.g231e3.14.g812cb and Fedora 12 inside Virtual
Box

aplay -D plughw:0,0 /usr/share/sounds/alsa/*.wav

"Front Left" sound as "Front Front Left" when playing "Front_left.wav"

only when echo 4 > /proc/asound/card0/pcm0p/xrun_debug
