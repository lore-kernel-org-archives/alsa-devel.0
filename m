From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Duplicate wake-ups in pcm_lib.c
Date: Tue, 26 Jan 2010 09:23:33 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001260917290.6542@eeebox2.perex-int.cz>
References: <6160a5130912231228g29669e4ctfef9ea8f42633120@mail.gmail.com>
	<alpine.LNX.2.00.0912240922460.2598@eeebox2.perex-int.cz>
	<6160a5131001062059i1ef74831p4210987579feb759@mail.gmail.com>
	<alpine.LNX.2.00.1001071552060.4210@eeebox2.perex-int.cz>
	<4f3252891001102011l603d30cdlbe2a14163bbc7405@mail.gmail.com>
	<alpine.LNX.2.00.1001110814310.4210@eeebox2.perex-int.cz>
	<4f3252891001122258j5c3bd7c5u7184cad199f5cf40@mail.gmail.com>
	<alpine.LNX.2.00.1001130803290.4324@eeebox2.perex-int.cz>
	<4f3252891001192338r53b3847dq8f3bfab03cc8a914@mail.gmail.com>
	<alpine.LNX.2.00.1001201141590.4324@eeebox2.perex-int.cz>
	<4f3252891001252325i5ab1ecf6o48e21f50c1b5ac29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id C5EFF244AB
	for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2010 09:23:33 +0100 (CET)
In-Reply-To: <4f3252891001252325i5ab1ecf6o48e21f50c1b5ac29@mail.gmail.com>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Jan 2010, Raymond Yau wrote:

>>>> Ok, I understand now. It would be better to use value 101 then - to see
>>>> last 10 ring buffer positions when jiffies correction occurs. Also, get
>>>> latest snapshot - there is a fix for jiffies check. Thanks.
>
> alsa-lib/test/pcm --verbose -Dhw -c2 -r48000 -f440  --method write_and_poll
>
> How do I know the double wake up is fixed ?

As far as know, only pulseaudio reports this issue in verbose mode.

> the echo still exist only XRUN_DEBUG_JIFFIESCHECK  bit is set

Please, could you set 101 to xrun_debug proc file and report relevant 
messages in dmesg as I asked before? I am curious where the problem is.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
