From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ALSA UCM
Date: Sat, 06 Nov 2010 12:26:36 +0000
Message-ID: <1289046396.3318.53.camel@odin>
References: <AANLkTimFdKg=_KDv8fbSJry6XTEsZqyQz7GhzaPxXDYP@mail.gmail.com>
	<1288865349.3277.14.camel@odin>
	<AANLkTim1Aopc2ALEXoWorPjzua0gGoSef8CpH+At4_cp@mail.gmail.com>
	<1288890598.3277.81.camel@odin>
	<alpine.LNX.2.00.1011041932410.29422@eeebox2.perex-int.cz>
	<1288896461.3277.98.camel@odin>
	<alpine.LNX.2.00.1011041949180.29422@eeebox2.perex-int.cz>
	<1288897628.3277.99.camel@odin>
	<AANLkTikn6Q+6KUpZaDGXuX=bGHrbV_9s91C6u+rS5e22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 377AA1037F7
	for <alsa-devel@alsa-project.org>; Sat,  6 Nov 2010 13:26:40 +0100 (CET)
Received: by wwi17 with SMTP id 17so1988435wwi.20
	for <alsa-devel@alsa-project.org>; Sat, 06 Nov 2010 05:26:39 -0700 (PDT)
In-Reply-To: <AANLkTikn6Q+6KUpZaDGXuX=bGHrbV_9s91C6u+rS5e22@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: abraham duenas <aduejazz@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-11-05 at 15:23 -0600, abraham duenas wrote:
> ok I changed to this form in the SectionDefaults at SDP4430.conf:
> cset "name='Capture Preamplifier Volume' 0,0"
> cset "name='Capture Volume' 0,0"
> cset "name='Aux FM Volume' 0,0"
> ...
> and so on....  and on "hifi" is remove all "index=X" references...
> 
> Some things I noticed is that at parse_sequence function in
> /ucm/parser.c the 'const char *id' never matches 'cset' or 'sleep' or
> 'exec' when parsing SectionDevice of the verb file. And in
> "execute_sequence" function of the the /ucm/main.c it never gets into
> the "list_for_each" cycle which in turn would show me the "
> uc_error("cset not yet implemented: '%s'", s->data.cset);"

Ok, so either your config is different compared to Jaroslav's or there
is a bug in the parser. I'd expect you to see the "cset not implemented"
warning so can you try your Jaroslav's config with your debug trace.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
