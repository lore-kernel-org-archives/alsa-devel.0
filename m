From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: More hotplug problems
Date: Mon, 29 Nov 2004 18:59:25 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411291856520.9175-100000@studcom.urz.uni-halle.de>
References: <200411291454.17595.carlosjosepita@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200411291454.17595.carlosjosepita@yahoo.com.ar>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlos Pita <carlosjosepita@yahoo.com.ar>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Carlos Pita wrote:
> > it tries to open /dev/aloadSEQ (minor number 1) to trigger the autoloading.
>
> Mmmm. But udev hasn't created that one either.

Because snd-seq isn't loaded yet.  Make this a static device node, or
tell udev to create it at startup.

> Another problem I had is when loading snd-virmidi from /etc/modules.
> In my debian (sarge), /etc/rcS.d/S20modutils would be executed before
> /etc/rcS.d/S40hotplug (S20 < S40), so I get virmidi as my first soundcard, ugly.

Add

	options snd-whatever index=0
	options snd-virmidi index=1

to /etc/modprobe.conf or whatever file Debian uses.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
