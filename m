From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] alsa-lib: Conf: Fix channels of ICE1712 to
	10/12
Date: Mon, 28 Mar 2011 10:44:15 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1103281043070.4805@eeebox2.perex-int.cz>
References: <4D904851.7090602@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id AF0DE1038D6
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 10:44:16 +0200 (CEST)
In-Reply-To: <4D904851.7090602@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 28 Mar 2011, David Henningsson wrote:

> I know this issue has been brought up before, without resolution. Basically 
> PulseAudio cannot open cards such as M-Audio 2496 and M-Audio Delta 1010LT 
> because it does not try to open "front" with 10 channels, only with 2.
>
> I think it is reasonable to assume that a front:x stream should be able to 
> open with 2 channels only, therefore I'm proposing this fix, and I'm applying 
> it to Ubuntu as well, unless you have a better idea.

I applied your change to our git repo . Perhaps we find a better solution 
in future.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
