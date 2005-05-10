From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: Device name lists
Date: Tue, 10 May 2005 17:57:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0505101751170.1834@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0505101728550.5641-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 030FA308
	for <alsa-devel@alsa-project.org>; Tue, 10 May 2005 17:59:49 +0200 (MEST)
In-Reply-To: <Pine.HPX.4.33n.0505101728550.5641-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 10 May 2005, Clemens Ladisch wrote:

> Marcel Holtmann wrote:
> > 1) What is the reason for not merging /etc/asound.names and ~/.asoundnm?
> 
> Probably the ability to remove names (otherwise we'd need some special
> syntax for this).

Exactly. It's not easy to do the merging.

> > 2) Is another config file really needed? Why not add another parameter
> > called "name" to the current config file. So that I can simply create
> > this entry for my Bluetooth headphone from HP:
> >
> > 	pcm.hp {
> > 	        type a2dp
> > 	        name "HP stereo headphone"
> > 	        bdaddr "00:0D:44:xx:xx:xx"
> > 	}
> 
> This wouldn't work for definitions having parameters.  It would force
> users to create a separate definition just so that it can be named.
> 
> Logically, these names are one abstraction level above the exising
> device names.

Yes, I discovered this when I was doing the implementation preparation.
While we agreed with Takashi not to describe the parameters (it would be 
very complex), the simple list of device names must be totaly separate 
outside the plugin specification.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
