From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: USB devices should not oops after disconnect now
Date: Wed, 27 Nov 2002 10:33:30 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211271031190.532-100000@pnote.perex-int.cz>
References: <3DE44B42.8070601@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA03980
	for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2002 21:46:17 +0100
In-Reply-To: <3DE44B42.8070601@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Nov 2002, Patrick Shirkey wrote:

> Jaroslav Kysela wrote:
> > Hello all,
> > 
> > 	the subject says everything. CVS contains first code to avoid 
> > oops / systems hangs when a "running" hotplug device is removed from the 
> > system. Please, test and report problems.
> > 
> 
> I have updated and now when I disconnect the device it will not register 
> on reconnect. No "connection found" messages are written to dmesg an it 
> doesn't appear in /proc/asound/cards. However it doesn't hang or cause 
> an oops either :) This is with the maudio quattro.

Note that you'll have to terminate all applications using that soundcard
before you'll try to reconnect the device again. In next code, hopefully
the applications will be somehow terminated to make the cleanup process
automatic.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
