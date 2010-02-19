From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Latency of mixer reconfiguration
Date: Fri, 19 Feb 2010 09:43:37 +0000
Message-ID: <20100219094337.GL2032@sirena.org.uk>
References: <20100217181530.GA23152@tango.0pointer.de>
	<20100218100127.GJ2032@sirena.org.uk>
	<20100218180422.GA5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190952310.28127@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7847E10391F
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 10:43:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1002190952310.28127@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 19, 2010 at 10:01:26AM +0100, Jaroslav Kysela wrote:

> It's quite complex question and probably only hardware vendors knows 
> these internals for all devices. I guess also, that some devices also uses 
> volume ramping to avoid clicks.

The most common technique there is actually to do volume updates on zero
cross - ie, only update the gain when the signal level is zero.
