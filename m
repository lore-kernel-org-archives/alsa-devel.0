From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: proper suspend / resume for PCM streams
Date: Mon, 15 Aug 2005 21:55:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0508152153230.9682@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0508152139420.9682@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 76BA71D1
	for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2005 21:55:03 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 49D0B8A6D5
	for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2005 21:55:03 +0200 (MEST)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 16D1D2E002
	for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2005 21:55:03 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0508152139420.9682@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 15 Aug 2005, Jaroslav Kysela wrote:

> Hi,
> 
> 	I'm digging to add the proper suspend and resume to the HDA intel 
> driver (PCM) and I noticed that some drivers incorrectly uses 
> the SNDRV_PCM_INFO_RESUME flag (notably intel8x0.c, intel8x0m.c, 
> hda_intel.c and perhaps more - I'll check).
> 	The semantics of this flag is: The driver can do full recovery
> for the suspended stream and can trigger it back to previous state 
> (including position in the ring buffer and all other related things).
> If the PCM stream must be restarted with the prepare callback, this flag 
> MUST NOT be set.
> 	For the first glance: cs4281.c and es1968.c drivers are restoring 
> the registers, so it appears that the full resume should work for them.

And here is the simplest way to test the suspend/resume for PCM:

first console : aplay -Dplughw:0 <some_file>
second console: alsactl power off ; alsactl power on

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
