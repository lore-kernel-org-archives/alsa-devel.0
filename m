From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: future ALSA development
Date: Tue, 24 Jun 2003 14:52:35 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030624145235.pochini@shiny.it>
References: <s5hsmq12ggf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from denise.shiny.it (denise.shiny.it [194.20.232.1])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA29499
	for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2003 14:52:42 +0200
In-Reply-To: <s5hsmq12ggf.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>ALSA development <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org


On 23-Jun-2003 Takashi Iwai wrote:
> At Sun, 22 Jun 2003 21:10:31 +0200 (CEST),
> Jaroslav wrote:
>> 
>> Hello all,
>> 
>>      here are my next goals for the ALSA library development (short
>> term). I invite all developers to comment these directions.
>> 
>> * create ordinary pcm & mixer interfaces
>>   - proposed headers are in current CVS
>>     - alsa-lib/include/pcm_ordinary.h
>>     - alsa-lib/include/mixer_ordinary.h
>
> i know the name conflictions of the word "simple" but i feel this
> naming not so intuitive...  it's just my tastes, though.

It has to be simple from the application's point of view, but the
implementation will be quite complex. Things as simple as setting
the volume can be all but trivial given the complexity of the
control API.

>> * investigate a lisp integration to the current configuration syntax
>>   - we need to describe the relations between high level abstract
>>     layer (ordinary mixer) and current universal controls (very lowlevel);
>>     it seems that the simple configuration is not able to describe
>>     these (in most cases) very complicated paths
> 
> yep.

Lisp should be fine, although it's not very user-friendly. But what the
interpreter is supposed to do ?  Is it possible to create an ordinary
mixer control that the hw doesn't support ?  For example: a card may not
have an hw master volume control, but the ordinary mixer has to provide
it. Is the lisp config file generic enough to provide a function to
emulate the master volume control it by changing the volume controls
of all single channels ?  It's not trivial at all to do such a thing
with a "normal" config file, but it's possible with an interpreter. The
question is: is it worth the effort ?  Or is it better to force all
lowlevel drivers to provide a minimal set of ordinary controls ?

>>   - note that describing of these relations might be used also for
>>     another mixer interfaces (simple mixer for example)
>>   - I don't rely on lisp, but what another interpreter with function
>>     definition has only 22kB binary (slisp-1.2 - i686)?

And what about Brainfuck ?  The compiler is a few hundred bytes
long. Ah, no, it hasn't functions. :)))))

>> * initiate a development of a graphical tool which will manage
>>   the alsa configuration files (~/.asoundrc)
>>   - we need a rapid development tool; I slowly became a fan of python and
>>     Qt has rich number of widgets; python + PyQt seems to me a good idea
>>   - using python requires to write a GPLed ALSA 0.9 -> python wrapper
>
> no objection at all.  python is powerful enough.

And an Alsa module is quite easy to write.


Bye.



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
