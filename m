From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1848 and cs4231 busy loop replacement
Date: Sun, 09 Sep 2007 23:19:56 +0200
Message-ID: <46E4637C.9000809@gmail.com>
References: <20070909001208.b2e54c13.krzysztof.h1@gmail.com>
	<46E46109.5040704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 40DDD103950
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Sep 2007 23:26:45 +0200 (CEST)
In-Reply-To: <46E46109.5040704@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@gmail.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/09/2007 11:09 PM, Rene Herman wrote:

> Given that the only difference is that I wait less, yours would've 
> worked as well -- thanks for looking into this! And could you viceversa 
> test this on AD1848 and perhaps resubmit if you agree?

Oh, and I forgot to say (sigh) that I use a mdelay() and not an msleep() in 
the ad1848 one due to the 1 ms being short enough and didn't keep the 
snd_printd() because if one, then all please...

If you yourself insist on keeping a change like that split off, then doing 
that as a second patch ontop is best I guess but I suspect Takashi wouldn't 
mind trivial stuff like that anymore than I would -- we're not rule-driven 
robots...

Rene.
