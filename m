From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 1/2] opti93x: add support for Opti93x codec
 in cs4231-lib
Date: Sun, 15 Jun 2008 21:50:30 +0200
Message-ID: <48557286.701@keyaccess.nl>
References: <20080609230728.273c9e1e.krzysztof.h1@poczta.fm>	<484DBB07.1080802@keyaccess.nl>
	<20080615193325.6fac815d.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id EC41C2438B
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Jun 2008 21:50:07 +0200 (CEST)
In-Reply-To: <20080615193325.6fac815d.krzysztof.h1@poczta.fm>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 15-06-08 19:33, Krzysztof Helt wrote:

> I have tried to reproduce this on an opti930 card. I do not hear any
> difference. I tried at 100% and 75% (both PCM and Master) levels. I
> used the script which reloaded an old and new driver and played a wav
> file. I run it in a loop. The thing I noticed is that the old driver
> often produced noise (say more than 1 in 4 tries) instead of the
> sound. The new driver (cs4231) never. The old and new driver produced
> a click before playing the sound (50% probability).
> 
> I have checked the mixer code. It is not changed.
> 
> What do you do to get a different sound level? (card model, level
> settings).

I've restested (quite extensively by now...) and have not been able to 
reproduce. I do have quit a few 931 and 933 cards, all alike physically 
but likely not all the same post the onboard amp. What MAY have happened 
is that I mistakingly grabbed another one during testing while I was 
busy switching 930, 931 and 933 cards (and kernels).

Doubt it a bit but well, I'm just not reproducing now. I do believe it 
was a 931 on which I observed the level difference; let's just conclude 
this must have been an error on my part.

Rene.
