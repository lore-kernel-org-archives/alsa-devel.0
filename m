From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd-hda-intel - wallclk patch
Date: Tue, 11 May 2010 10:28:50 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005111028110.6856@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.1005101849490.6856@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 78A9124730
	for <alsa-devel@alsa-project.org>;
	Tue, 11 May 2010 10:28:51 +0200 (CEST)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	6DE9114999F for <alsa-devel@alsa-project.org>;
	Tue, 11 May 2010 10:28:51 +0200 (CEST)
Received: from eeebox2.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	3479484A9C for <alsa-devel@alsa-project.org>;
	Tue, 11 May 2010 10:28:51 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1005101849490.6856@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: tiwai@perex.cz
List-Id: alsa-devel@alsa-project.org

On Mon, 10 May 2010, Jaroslav Kysela wrote:

> Hi,
>
> 	I would like to ask HDA gurus to check this patch (I will include it 
> to my tree once acked). The patch uses WALLCLK from HDA chips (marked as 
> required in the HDA specification) to check for bogus - too early - interrups 
> which confuses the upper PCM layer (sound skipping issues).
>
> 	More details about patch testing on problematic hardware can be found 
> at:
>
> 	https://bugzilla.kernel.org/show_bug.cgi?id=15912

No objections received, so I pushed this code to my master/devel branches.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
