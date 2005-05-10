From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: Device name lists
Date: Tue, 10 May 2005 17:32:15 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0505101728550.5641-100000@studcom.urz.uni-halle.de>
References: <1115738349.12058.7.camel@pegasus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1DE88E2
	for <alsa-devel@alsa-project.org>; Tue, 10 May 2005 17:32:16 +0200 (MEST)
In-Reply-To: <1115738349.12058.7.camel@pegasus>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jaroslav Kysela <perex@suse.cz>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Marcel Holtmann wrote:
> 1) What is the reason for not merging /etc/asound.names and ~/.asoundnm?

Probably the ability to remove names (otherwise we'd need some special
syntax for this).

> 2) Is another config file really needed? Why not add another parameter
> called "name" to the current config file. So that I can simply create
> this entry for my Bluetooth headphone from HP:
>
> 	pcm.hp {
> 	        type a2dp
> 	        name "HP stereo headphone"
> 	        bdaddr "00:0D:44:xx:xx:xx"
> 	}

This wouldn't work for definitions having parameters.  It would force
users to create a separate definition just so that it can be named.

Logically, these names are one abstraction level above the exising
device names.


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
