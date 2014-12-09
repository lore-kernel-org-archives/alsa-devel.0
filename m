From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Possible GPL-licensed header included in alsa-lib
Date: Tue, 09 Dec 2014 19:40:07 +0100
Message-ID: <54874207.5030609@perex.cz>
References: <20141209174917.GC22300@ulm-bmuc496424.bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A3832602AD
 for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2014 19:40:10 +0100 (CET)
In-Reply-To: <20141209174917.GC22300@ulm-bmuc496424.bmw-carit.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: clemens.lang@bmw-carit.de
List-Id: alsa-devel@alsa-project.org

Dne 9.12.2014 v 18:49 Clemens Lang napsal(a):
> Hi,
> 
> I recently reviewed the alsa-lib 1.0.27.2 source code from a licensing
> perspective to ensure compliant usage and distribution. It seems the
> intention is for the libraries to be covered by LGPL.
>
> I had a look at include/list.h, which seems to be licensed under
> GPL-2.0. It does not have a license header or any other copyright
> information, but it states it was taken from Linux 2.4.0:
> 
> include/list.h, line 5:
> | This code was taken from the Linux 2.4.0 kernel. [jaroslav]
> 
> I'm not sure one could argue that the header was trivial, especially
> since it does not only contain constants, structures and interface
> definitions, but also implementations of inline functions.

Fro my view, it's really trivial, but ...

> 
> I found one previous inquiry about a similar issue[1], but it does not
> cover the include/list.h header.
> 
> 
> Two questions:
>  1. Have the copyright holders of the code in question agreed to
>     re-license under a different, LGPL-preserving license and, if yes,
> 	is there some documentation about that?

I don't think so.. Not sure how difficult would be to gather the
original authors from the 2.4 code.


>  2. If the header is indeed covered by GPL-2.0, would you accept patches
>     to replace it with a different implementation, e.g. Rusty Russell's
> 	MIT-licensed list from ccan[2]?

It could be solution, but the current code seems a bit less complicated.

Could you try to obtain list of original authors from linux 2.4 ? I
think I can ask about the licence change.

				Thanks,
					Jaroslav

> 
> 
> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2011-March/038267.html
> [2] http://ccodearchive.net/info/list.html
> 
> 
> Thank you for your time,
> Clemens Lang
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
