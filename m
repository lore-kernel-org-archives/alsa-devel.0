From: Paul Davis <pbd@op.net>
Subject: Re: DMA: do all drivers need it?
Date: Sat, 04 May 2002 07:41:28 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205041140.g44BeoD09284@post2.fast.net>
References: <20020423191053.81397.qmail@web11507.mail.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA18554
	for <alsa-devel@alsa-project.org>; Sat, 4 May 2002 13:41:00 +0200
In-Reply-To: Your message of "Tue, 23 Apr 2002 12:10:53 PDT."
             <20020423191053.81397.qmail@web11507.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guilhem Tardy <guilhem_tardy@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>I am starting to write an sound driver for a card with no previous support and
>would like to know if DMA is necessary as per the ALSA framework itself. My
>card doesn't support DMA, yet. So if your answer is no, I would need to
>fallback on OSS for the time being.

its not. ALSA doesn't require anything but a fairly small set of
function pointers to be initialized so that the "mid-level" code can
manage the device. as long as there is some way to move data to and
from the audio interface (which seems like a pretty basic assumption),
you just have to wrap it up and present it to the mid-level code.

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
