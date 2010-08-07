From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: Use Case Manager Test Drive [Was: Re: ASoC: Hiding
 unused CODEC mixer widgets in the machine driver]
Date: Sun, 08 Aug 2010 09:07:55 +1000
Message-ID: <4C5DE74B.6090106@gentoo.org>
References: <20100806001844.GM15884@atomos.longlandclan.yi.org>	
	<20100806111935.GA31326@sirena.org.uk>
	<1281094453.3077.46.camel@odin> <1281094963.3077.59.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25])
	by alsa0.perex.cz (Postfix) with ESMTP id F3C2E103810
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Aug 2010 01:08:07 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OhsUk-0004HU-Gz
	for alsa-devel@alsa-project.org; Sun, 08 Aug 2010 09:08:03 +1000
Received: from [203.94.56.252] (helo=atomos.dmz.longlandclan.yi.org)
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OhsUj-0004H1-18
	for alsa-devel@alsa-project.org; Sun, 08 Aug 2010 09:08:02 +1000
In-Reply-To: <1281094963.3077.59.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: tiwai@suse.de, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Justin Xu <justin.oxu@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark, Liam...
On 08/06/10 21:42, Liam Girdwood wrote:
> On Fri, 2010-08-06 at 12:34 +0100, Liam Girdwood wrote:
>> On Fri, 2010-08-06 at 12:19 +0100, Mark Brown wrote:
>>> The machine driver shouldn't be doing this - it's too fragile in the
>>> face of any changes in the drivers and means hard coding use cases into
>>> the kernel which is really bad practice since it's much slower than
>>> doing things from user space and much harder to change as new needs
>>> arise.
>>
>> Please do give UCM (Use Case Manager) a test drive. We are in the late
>> development / early testing phase before upstreaming (still one or two
>> things todo).
>>
>> You will need to checkout the use-case-verb branches of :-
>>
>> git://git.slimlogic.co.uk/alsa-lib.git
>>
>> git://git.slimlogic.co.uk/alsa-utils.git
>>
>> There is a tool called alsaucm that allows changing the use case from
>> the command line. Best to use it's interactive (-i) mode atm.
>>
>> There is also an initial repository for UCM use case configuration files
>> here :-
>>
>> git://git.slimlogic.co.uk/alsa-ucm-conf.git
>>
>> This will show the format required to describe use cases.
>>
> 
> Forgot to add that patches are most welcome.

No worries... I can see there being possible issues with the machine
driver being highly sensitive to changes to the CODEC driver, I was just
curious if there was some mechanism for abstracting this.

However, a userspace solution will probably work well... I'll have a
look and report back any findings.  How close is this to being merged
into the main alsa-lib and alsa-utils trees?

Regards,
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
