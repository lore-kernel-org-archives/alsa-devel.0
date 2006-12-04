From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [UDEV] Persitent ordering of ALSA-devices
Date: Mon, 04 Dec 2006 12:21:39 +0100
Message-ID: <1165231299.10319.278726991@webmail.messagingengine.com>
References: <7nhSg-2Ow-9@gated-at.bofh.it> <7nk3R-84O-35@gated-at.bofh.it>
	<7nnbg-77Q-11@gated-at.bofh.it> <7no7s-PV-23@gated-at.bofh.it>
	<4570C14B.6090107@cc.fh-luh.de> <20061202080348.GB9422@kroah.com>
	<4571C735.6050403@cc.fh-luh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <4571C735.6050403@cc.fh-luh.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jan 'RedBully' Seiffert <redbully@cc.fh-luh.de>, linux-hotplug-devel@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net, Greg KH <gregkh@gentoo.org>
List-Id: alsa-devel@alsa-project.org

Jan 'RedBully' Seiffert wrote:
> After Gentoo switched to udev-coldplug, my two soundcards get randomly
> reordered on reboot. Now I need to write a udev rule to give them a
> persistent ordering, but failed to do so until now, partly because i
> don't know on what key ALSA orders devices so they become card0 and 1,
> hw0 and hw1, partly because this feature of udev is so new.

ALSA's card ordering mechanism predates udev and isn't compatible with
it.

The ALSA framework has its own internal card list (that is shown in
/proc/asound/cards).  Drivers can be instructed to take a specific card
number with the 'index' option, and this is the only official way of
reordering cards.

It is, in theory, possible to rename the device files, but you have to
be aware that
1) all devices files of one card must be renamed consistently, i.e,
   the card number in the controlC*/hwdepC*D*/rawmidiC*D*/pcmC*D*p/
   pcmC*D*c files (the number after the "C") must be the same for all
   device files belonging to each card; and
2) enumerating cards will no longer work correctly (the card number
   returned by ALSA will still be the number specified with the index
   parameter), i.e., card names/descriptions will be wrong when a
   program tries to show them.


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
