From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: limits
Date: Mon, 7 Jun 2004 10:40:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0406071038470.3294@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0406070926050.6374-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from outgoing.perex-int.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5613811E
	for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2004 10:37:45 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 1BA9E15B8
	for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2004 10:37:45 +0200 (MEST)
Received: from pnote.perex-int.cz (localhost [127.0.0.1])
	by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 0031226005
	for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2004 10:37:45 +0200 (CEST)
In-Reply-To: <Pine.HPX.4.33n.0406070926050.6374-100000@studcom.urz.uni-halle.de>
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

On Mon, 7 Jun 2004, Clemens Ladisch wrote:

> Florin Andrei wrote:
> > What's the max number of cards in a system that can be used by ALSA
> > simultaneously?
> 
> > The answers to the questions above - are they in the docs?
> 
> Use the Source, Luke!  :-)

Note that applications shouldn't rely on these limits, because we can 
change the driver code to support more cards/devices/sequencer queues etc. 
in future.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
