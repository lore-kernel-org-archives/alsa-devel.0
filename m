From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] New Aztech Sound Galaxy driver
Date: Mon, 24 Sep 2007 21:19:49 +0200
Message-ID: <46F80DD5.6040100@keyaccess.nl>
References: <46F26571.501@gmail.com>
	<20070923174317.71510732.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C45C103845
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Sep 2007 21:19:53 +0200 (CEST)
In-Reply-To: <20070923174317.71510732.krzysztof.h1@poczta.fm>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/23/2007 05:43 PM, Krzysztof Helt wrote:

> On Thu, 20 Sep 2007 14:20:01 +0200
> Rene Herman <rene.herman@gmail.com> wrote:
> 
>> FCC-ID I38-MMSN852: Aztech Sound Galaxy Waverider Pro 32-3D
>>
> 
> I have tested your driver on this cards and it works for me (no suprise).

Thanks for testing and I've indeed been careful with testing on all cards. 
The end result doesn't really show it but it's been a rather long series of 
eliminating steps that the original DOS drivers took (with small differences 
between all the types -- but it turned out it seems that most all of it was 
only needed for the "native" SB mode, not WSS).

> I have no tested full-duplex recording.

Should work fine on the 852.

> Just two minor issues below.
> 
>> --- /dev/null	Thu Jan 01 00:00:00 1970 +0000
>> +++ b/isa/galaxy/Makefile	Thu Sep 20 14:15:22 2007 +0200
>> @@ -0,0 +1,10 @@
>> +#
>> +# Makefile for ALSA
>> +# Copyright (c) 2001 by Jaroslav Kysela <perex@suse.cz>
>> +#
>> +
> 
> You should be file's author, I suppose.

Well, I am, but Jaroslav can have the copyright...

The makefile is wholy trivial. In fact, trivial enough to not even _be_ 
copyrightable in itself and only the ALSA built system as a whole could 
count as copyrightable, I'd say. Keeping that under one single copyright 
might make some things easier.

Or not. I don't care. He can have it ;-)

>> diff -r 0687faf0e009 isa/galaxy/galaxy.c
>> --- /dev/null	Thu Jan 01 00:00:00 1970 +0000
>> +++ b/isa/galaxy/galaxy.c	Thu Sep 20 14:15:22 2007 +0200
>> @@ -0,0 +1,562 @@
>> [...]
>> +#define DSP_COMMAND_GALAXY_9	9
>> +#define GALAXY_COMMAND_WSSMODE	0
>> +#define GALAXY_COMMAND_SB8MODE	1
>> +
>> +#define GALAXY_MODE_WSS		GALAXY_COMMAND_WSSMODE
>> +#define GALAXY_MODE_SB8		GALAXY_COMMAND_SB8MODE
> 
> There is no need for these redefinitions. The first constant is used once, the second not even once.
> You can use the original name (GALAXY_COMMAND_WSSMODE) without losing readability.

This is by design. I have a set_mode() function, which takes a "mode" 
argument and the fact that I've defined them to be the command used to 
switch _to_ that mode can be seen just as a convenience thing. And the 
SB8MODE one is retained as documentation (going back to SB8MODE gets you 
floating volumes and the like though -- would need to configure the thing 
completely to be able to do that right, so I don't).

Otherwise, since I was too late for 1.0.15 anyway, things will see a further 
splitup into a library module I guess. My "NX Pro 16" (I38-MMSN803) and 
AZT2320 cards want some of it as well.

Rene.
