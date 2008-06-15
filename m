From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 1/2] opti93x: add support for Opti93x codec
 in cs4231-lib
Date: Sun, 15 Jun 2008 19:33:25 +0200
Message-ID: <20080615193325.6fac815d.krzysztof.h1@poczta.fm>
References: <20080609230728.273c9e1e.krzysztof.h1@poczta.fm>
	<484DBB07.1080802@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 62E0824378
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Jun 2008 19:30:19 +0200 (CEST)
In-Reply-To: <484DBB07.1080802@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 10 Jun 2008 01:21:43 +0200
Rene Herman <rene.herman@keyaccess.nl> wrote:

> 
> The mixer levels do seem different between the old and new driver. Does 
> that make sense? The new one appears to  be a bit louder so there might 
> be an offset issue somewhere I suppose. I didn't compare that closely.
> 

I have tried to reproduce this on an opti930 card. I do not hear any difference.
I tried at 100% and 75% (both PCM and Master) levels. I used the script which
reloaded an old and new driver and played a wav file. I run it in a loop.
The thing I noticed is that the old driver often produced noise (say more
than 1 in 4 tries) instead of the sound. The new driver (cs4231) never. The old
and new driver produced a click before playing the sound (50% probability).

I have checked the mixer code. It is not changed.

What do you do to get a different sound level? (card model, level settings).

Regards,
Krzysztof


----------------------------------------------------------------------
Podbij Dziki Zachod!Gra strategiczna online
Sprawdz >>> http://link.interia.pl/f1dff
