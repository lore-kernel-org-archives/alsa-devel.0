From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001637]: Channel duplication messes up sound
Date: Sat, 10 Dec 2005 20:42:24 +0100
Message-ID: <518ed8b41207f8e0d3e64a2f2dd75ad5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C4084169
	for <alsa-devel@alsa-project.org>; Sat, 10 Dec 2005 20:42:24 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1637> 
======================================================================
Reported By:                Nikratio
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1637
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Breezy
Kernel Version:             2.6.12
======================================================================
Date Submitted:             12-10-2005 20:42 CET
Last Modified:              12-10-2005 20:42 CET
======================================================================
Summary:                    Channel duplication messes up sound
Description: 
I'm using the following asoundrc:

ctl.aureon {
   type hw
   card 1
}

pcm.aureon {
    type hw
    card 1
}

pcm.ch51dup {
    type route
    slave.pcm aureon
    slave.channels 6
    ttable.0.0 1
    ttable.1.1 1
    ttable.0.2 1
    ttable.1.3 1
    ttable.0.4 1
    ttable.1.4 1
    ttable.0.5 1
    ttable.1.5 1
}

When I play a soundfile using xmms on ch51dep the output on all speakers
except front left and front right is messed up. All lower frequency sounds
produce a kind of crackling.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-10-05 20:42 Nikratio       New Issue                                    
12-10-05 20:42 Nikratio       Distribution              => Ubuntu Breezy   
12-10-05 20:42 Nikratio       Kernel Version            => 2.6.12          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
