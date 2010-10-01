From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: namehint: Evaluate more possibilities for hw
	devices
Date: Fri, 1 Oct 2010 15:14:03 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010011512520.20467@eeebox2.perex-int.cz>
References: <4CA4B6BF.3080503@aknet.ru>
	<alpine.LNX.2.00.1010011332210.20467@eeebox2.perex-int.cz>
	<4CA5CB0D.9030003@aknet.ru>
	<alpine.LNX.2.00.1010011408410.20467@eeebox2.perex-int.cz>
	<4CA5D359.9040400@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 32B07103839
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 15:14:04 +0200 (CEST)
In-Reply-To: <4CA5D359.9040400@aknet.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@aknet.ru>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 1 Oct 2010, Stas Sergeev wrote:

> 01.10.2010 16:08, Jaroslav Kysela wrote:
>       This patch should definitely fix it:
> 
> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=c049d48407ff0459
>       ff15e466edeeee6ecff67fcd
> 
> Much better now, thanks!
> I still have an issue though.
> If the device registers only the playback
> substreams and no record substreams,
> it is still not listed. To reproduce, set the
> "capture_count" param of snd_pcm_new()
> to 0 in dummy.c, and then it disappears
> from the list, as follows:

Try upgrade alsa-utils (aplay). Appearenly, the bug is there (at least on 
my system the latest aplay lists devices correctly, but aplay 1.0.18 is 
buggy).

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
