From: Paul Davis <pbd@op.net>
Subject: Re: Failed to compile HDSP driver from the CVS
Date: Tue, 14 May 2002 20:02:28 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205150001.g4F012T12698@post2.fast.net>
References: <1021414588.4152.1.camel@badass-bukvic.dyndns.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "14 May 2002 18:16:27 EDT."
             <1021414588.4152.1.camel@badass-bukvic.dyndns.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I am a bit confused. It is not the fact that I do have this file, but
>that the compile was looking for it. It must have been that issue you
>mentioned about CVS being not up-to-date. 

its a combination of the "fastdep" target looking at *all* existing
sources, whether they are meant to be there or not, plus the CVS sync issue.

					   However, here's the error when
>I try to compile the driver now, after updating it with 

use cvscompile to build it, i think.

--p


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
