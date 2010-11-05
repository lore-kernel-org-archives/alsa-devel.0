From: abraham duenas <aduejazz@gmail.com>
Subject: Re: ALSA UCM
Date: Fri, 5 Nov 2010 15:23:55 -0600
Message-ID: <AANLkTikn6Q+6KUpZaDGXuX=bGHrbV_9s91C6u+rS5e22@mail.gmail.com>
References: <AANLkTimFdKg=_KDv8fbSJry6XTEsZqyQz7GhzaPxXDYP@mail.gmail.com>
	<1288865349.3277.14.camel@odin>
	<AANLkTim1Aopc2ALEXoWorPjzua0gGoSef8CpH+At4_cp@mail.gmail.com>
	<1288890598.3277.81.camel@odin>
	<alpine.LNX.2.00.1011041932410.29422@eeebox2.perex-int.cz>
	<1288896461.3277.98.camel@odin>
	<alpine.LNX.2.00.1011041949180.29422@eeebox2.perex-int.cz>
	<1288897628.3277.99.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 584681037FF
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 22:23:58 +0100 (CET)
Received: by wwi17 with SMTP id 17so1553050wwi.20
	for <alsa-devel@alsa-project.org>; Fri, 05 Nov 2010 14:23:55 -0700 (PDT)
In-Reply-To: <1288897628.3277.99.camel@odin>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

ok I changed to this form in the SectionDefaults at SDP4430.conf:
cset "name='Capture Preamplifier Volume' 0,0"
cset "name='Capture Volume' 0,0"
cset "name='Aux FM Volume' 0,0"
...
and so on....  and on "hifi" is remove all "index=X" references...

Some things I noticed is that at parse_sequence function in
/ucm/parser.c the 'const char *id' never matches 'cset' or 'sleep' or
'exec' when parsing SectionDevice of the verb file. And in
"execute_sequence" function of the the /ucm/main.c it never gets into
the "list_for_each" cycle which in turn would show me the "
uc_error("cset not yet implemented: '%s'", s->data.cset);"
