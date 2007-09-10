From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1848 and cs4231 busy loop replacement
Date: Mon, 10 Sep 2007 13:54:26 +0200
Message-ID: <46E53072.2040404@gmail.com>
References: <20070909001208.b2e54c13.krzysztof.h1@gmail.com>	
	<46E46109.5040704@gmail.com>
	<8c74410a0709100008v5497e870j7495b3ea054ae00b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F027243CC
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 14:01:20 +0200 (CEST)
In-Reply-To: <8c74410a0709100008v5497e870j7495b3ea054ae00b@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/10/2007 09:08 AM, Krzysztof Helt wrote:

> Rene wrote:

>> Which seems to be saying that we should be waiting for only 5 cycles at
>> that point. With the slowest (!) possible sampling rate of 5.5125 kHz 
>> that would mean 907 us, or sligtly under 1 ms.
>> 
> It does not matter. If you have to wait for the start of the 
> auto-calibration then for the end of auto-calibration you may as well 
> wait for the end of the auto-calibration only (unless you want to follow 
> the auto-calibration to the very single clock pulse ;-). The delay here 
> is simple to assure that auto-calibration started (and probably is 
> already under way). It may be longer then the start but it should not be 
> longer than whole auto-calibration.
> 
> I simply tried to do as long msleep as possible to allow other tasks 
> using CPU and decrease number of waiting loop iterations.

Well, no, sorry, but I consider that to be completely breaking the logic of 
the code. One line after this bit, we're doing the "wait for calibration to 
finish" loop (and already schedule ourselves away while doing so, for 250ms 
no less) meaning that at this point we should only wait long enough to be 
guaranteed that the ACI bit reflects reality -- those 5 cycles.

Your: wait unconditionally until calibration _nearly_ done, then go wait for 
it for 250 ms to be really done.

Mine: wait unconditionally until calibration has started, then go wait for 
it for 250 ms to finish.

Really -- please just do the 1 ms delay for ad1848 and either no delay or 
the same 1 ms for cs4231 if you want to keep them in sync (and the comment 
explaining why it's 1 ms). I don't particularly care about mdelay versus 
msleep here (although a mere 1 ms fits mdelay better) but your setup is 
pointlessly obscuring the code-flow.

Rene.
