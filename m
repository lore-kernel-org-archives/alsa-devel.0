From: Timur Tabi <timur@freescale.com>
Subject: Re: snd_soc_dai_link.init()
Date: Thu, 31 May 2007 12:04:37 -0500
Message-ID: <465F0025.4010008@freescale.com>
References: <465DFBF5.9040800@freescale.com>
	<1180630964.29590.83.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 708E8245D2
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2007 19:04:42 +0200 (CEST)
In-Reply-To: <1180630964.29590.83.camel@a10072.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> On Wed, 2007-05-30 at 17:34 -0500, Timur Tabi wrote:
>> Liam,
>>
>> Why does the init() function pointer in the snd_soc_dai_link structure take a 
>> snd_soc_codec pointer?  Wouldn't it make more sense for it to take a snd_soc_dai_link 
>> pointer?  That way, I could use the init() function to initialize the structure.
>>
> 
> Your right, I've logged a bug.
> 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3135
> 
> I should have some time to look at the bugs tomorrow.

I'd be happy to create a patch that fixes it today, if you like.  I just need to know the 
URL of the git tree to use as a starting point.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
