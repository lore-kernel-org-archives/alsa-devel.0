From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: patches for rme9652
Date: Thu, 9 May 2002 08:54:33 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0205090849560.544-100000@pnote.perex-int.cz>
References: <200205090304.g4934QP23771@op.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA21488
	for <alsa-devel@alsa-project.org>; Thu, 9 May 2002 08:54:51 +0200
In-Reply-To: <200205090304.g4934QP23771@op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 8 May 2002, Paul Davis wrote:

> this patch fixes a bug in the hammerfall driver, and improves the code
> logic in a couple of places. the bug was that when we trigger the
> capture substream and there is no playback substream, we failed to
> silence the playback buffer. this leads to some potentially horrible
> noises during capture-only software execution (such as arecord). the
> code is also slightly rearranged to check h/w versions before doing
> resource allocation.
> 
> there is still a hard-to-solve bug in the driver: if you try to change
> between a "single-speed" sample rate and a "double-speed" sample rate
> by using the params API, it will fail because there is a substream
> already open. this was 100% by design - the speed change alters the
> number of channels and their memory locations. but its a silly
> restriction that needs to be fixed at some point.

Note: We have hw_free callback for PCM resources which should clear all 
used resources. After this point, driver should allow to change ANY
parameters.

> please let me know when this is applied to CVS.

Applied (the later one).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
