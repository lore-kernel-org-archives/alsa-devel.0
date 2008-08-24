From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] wss_lib: do not mess mixer settings during
 probe
Date: Mon, 25 Aug 2008 00:37:52 +0200
Message-ID: <48B1E2C0.8000105@keyaccess.nl>
References: <20080824180804.b88effc0.krzysztof.h1@poczta.fm>	<48B1AA48.7020403@keyaccess.nl>
	<20080824214832.daa13d68.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id A6967243D5
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Aug 2008 00:36:24 +0200 (CEST)
In-Reply-To: <20080824214832.daa13d68.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 24-08-08 21:48, Krzysztof Helt wrote:

>From the Documentation/memory-barriers.txt
> "
> (*) inX(), outX():
> ...
>     They are guaranteed to be fully ordered with respect to each other.
> 
>     They are not guaranteed to be fully ordered with respect to other types of
>      memory and I/O operation.
> ...
> "
> 
> No barriers are needed in this case. 

On x86 certainly not and I would expect these barriers are there for 
cases/architectures where inb() and outb() are redefined to memory 
mapped I/O or there would just be no point at all.

In that case, the first outb() writes an index and we'd better make sure 
that it hits the hardware before we write the value. Hence my suspicion 
that if at all, the mb() should be in between.

No idea who added those and why...

Rene
