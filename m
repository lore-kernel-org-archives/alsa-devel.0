From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA UCM
Date: Thu, 4 Nov 2010 19:31:26 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011041926390.29422@eeebox2.perex-int.cz>
References: <AANLkTimFdKg=_KDv8fbSJry6XTEsZqyQz7GhzaPxXDYP@mail.gmail.com>
	<1288865349.3277.14.camel@odin>
	<AANLkTim1Aopc2ALEXoWorPjzua0gGoSef8CpH+At4_cp@mail.gmail.com>
	<1288890598.3277.81.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F79824403
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 19:31:27 +0100 (CET)
In-Reply-To: <1288890598.3277.81.camel@odin>
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
Cc: alsa-devel@alsa-project.org, abraham duenas <aduejazz@gmail.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 4 Nov 2010, Liam Girdwood wrote:

>>> Jaroslav did make some changes to the config file format so maybe we
>>> have a formatting problem here.
>>>
>
> Jaroslav, any ideas ?

The cset command is not implemented yet. I'm actually porting the parsing 
routines from amixer to alsa-lib.

The actual implementation should print error messages something like:

cset not yet implemented

If these messages are not printed, I think that there is an issue with 
the parser. I'm sorry, but I fight with free time to finish this API.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
