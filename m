From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Help
Date: Fri, 24 Apr 2009 13:39:48 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904241338080.25064@eeebox2.perex-int.cz>
References: <9D5E1752379A43408015F7FE98466115023F03C3@CHNEXVS01.VSNLXCHANGE.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id F38741038A7
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 13:39:48 +0200 (CEST)
In-Reply-To: <9D5E1752379A43408015F7FE98466115023F03C3@CHNEXVS01.VSNLXCHANGE.COM>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sudeept Prusti <sudeeptp@tataelxsi.co.in>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 24 Apr 2009, Sudeept Prusti wrote:

> Hi all,
>
> As i am working on alsa for minimal PCM playback (8khz,mono,16 bit pcm 
> file).
>
> When i tried to allocate 1k buffer and send through snd_pcm_writei() 
> call it doesn't play perfect and skips are there in between. If we keep 
> on increasing in allocating the buffer for 31 kb then it could play the 
> buffers randomly.

Sure. Your file read logic is broken. You have to check number of bytes 
read and do not assume that 'k' bytes were read all time. Also, using seek 
is not necessary for sequential reads.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
