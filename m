From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Current ad1848/cs4231 mce_down code
Date: Tue, 18 Sep 2007 09:33:39 +0200
Message-ID: <46EF7F53.5060208@gmail.com>
References: <46EF2188.60704@gmail.com>
	<20070918092821.773e522c.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 682EC2446F
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 09:34:34 +0200 (CEST)
In-Reply-To: <20070918092821.773e522c.krzysztof.h1@gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org

On 09/18/2007 09:28 AM, Krzysztof Helt wrote:

>> Moreover, we aren't under lock at all in the cs4231 version (which also 
>> means that msleep(1) thing is in fact fine there). Can't we do that for 
>> ad1848 as well?
>>
> 
> The lock is right thing to do as Trent found out. The in() call writes
> to register. On the SMP setup it may backfire (cs4231 does not have
> locks but sparc cs4231 has them).

Yep, cs4231 is broken. Trent's new ad1848 version is the reference now it 
seems. I'll fix up cs4231 if he doesn't beat me to it -- I'm still messing 
with the Aztech cards so am testing cs4231 continously anyway...

Rene.
