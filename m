From: Paul Davis <pbd@op.net>
Subject: Re: Failed to compile HDSP driver from the CVS
Date: Tue, 14 May 2002 09:07:26 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205141306.g4ED65T06570@post2.fast.net>
References: <1021359094.22878.8.camel@badass-bukvic.dyndns.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA25840
	for <alsa-devel@alsa-project.org>; Tue, 14 May 2002 15:06:19 +0200
In-Reply-To: Your message of "14 May 2002 02:51:34 EDT."
             <1021359094.22878.8.camel@badass-bukvic.dyndns.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>First off, thank you very much for the awesome news Paul, I am extatic
>to hear that HDSP driver is ready! :-)
>
>However, I've been trying to compile it from the CVS and no matter what
>I try I get the same error:

i think you failed to use the "-P" flag to the CVS update
command. Always use this flag, otherwise when someone removes a file
from CVS, its not removed from your local tree. 

as a result, you've still got rme9652_mem.c hanging around, and the
"fastdep" make target looks at *all* sources, not just those that are
listed in the Makefile. you need to remove this file. there are two
versions of it, one under alsa-kernel, one under alsa-driver.

please keep in mind that you should update alsa-lib and alsa-utils as
well, because they have been modified to support the 64 bit register
used by the H-DSP for its RMS meters.

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
