From: bugtrack@alsa-project.org
Subject: [ALSA - firmware 0000815]: missing DESTDIR support with hotplug dir
Date: Mon, 14 Feb 2005 19:39:17 +0100
Message-ID: <5a05d05fde406dbbf944fde84b6cbaa6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8E34C248
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 19:39:17 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=815> 
======================================================================
Reported By:                gvy
Assigned To:                
======================================================================
Project:                    ALSA - firmware
Issue ID:                   815
Category:                   
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             01-13-2005 20:21 CET
Last Modified:              02-14-2005 19:39 CET
======================================================================
Summary:                    missing DESTDIR support with hotplug dir
Description: 
with intoruction of hotplug dir I had to kludge in RPM buildroot into
configure parameters -- it doesn't belong there, it's rather install-time
not compile-time (and definitely not configure-time).

hardwiring /usr/lib is no good too -- bringing ilbdir in would be better
too.
======================================================================

----------------------------------------------------------------------
 gvy - 01-13-05 20:48 
----------------------------------------------------------------------
Failed for me with exactly this (expanded rpm macro):

/usr/bin/make 'INSTALL=/bin/install -p'
prefix=/var/tmp/alsa-firmware-buildroot/usr
exec_prefix=/var/tmp/alsa-firmware-buildroot/usr
bindir=/var/tmp/alsa-firmware-buildroot/usr/bin
sbindir=/var/tmp/alsa-firmware-buildroot/usr/sbin
sysconfdir=/var/tmp/alsa-firmware-buildroot/etc
datadir=/var/tmp/alsa-firmware-buildroot/usr/share
includedir=/var/tmp/alsa-firmware-buildroot/usr/include
libdir=/var/tmp/alsa-firmware-buildroot/usr/lib
libexecdir=/var/tmp/alsa-firmware-buildroot/usr/lib
localstatedir=/var/tmp/alsa-firmware-buildroot/var/lib
sharedstatedir=/var/tmp/alsa-firmware-buildroot/usr/com
mandir=/var/tmp/alsa-firmware-buildroot/usr/share/man
infodir=/var/tmp/alsa-firmware-buildroot/usr/share/info install

The inconsistency is that everything else gets installed just fine like
before.
%makeinstall DESTDIR=%buildroot would yield double prefix substitution for
any other installation path, and I'm too dumb this evening to crank up a
Makefile.* patch... so leaving the %configure parameter as is right now.

PS: sorry for typos and thanks for your work, Takashi!  Domo arigato!

----------------------------------------------------------------------
 tiwai - 01-13-05 20:52 
----------------------------------------------------------------------
OK, thanks for checking.

Closing this now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-13-05 20:21 gvy            New Issue                                    
01-13-05 20:33 tiwai          Note Added: 0003199                          
01-13-05 20:48 gvy            Note Added: 0003201                          
01-13-05 20:52 tiwai          Status                   new => resolved     
01-13-05 20:52 tiwai          Resolution               open => not an issue
01-13-05 20:52 tiwai          Assigned To               => tiwai           
01-13-05 20:52 tiwai          Note Added: 0003203                          
01-13-05 20:52 tiwai          Assigned To              tiwai =>            
02-14-05 19:39 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
