From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001043]: gstreamer cannot play flacs or oggs when p16v is enabled.
Date: Sun, 10 Apr 2005 13:38:40 +0200
Message-ID: <963933351704697fc867cdbb09bdcef6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7AFE522B
	for <alsa-devel@alsa-project.org>; Sun, 10 Apr 2005 13:38:40 +0200 (MEST)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1043> 
======================================================================
Reported By:                stuNNed
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1043
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Ubuntu Linux 5.0.4
Kernel Version:             2.6.10-5-686-smp
======================================================================
Date Submitted:             04-09-2005 21:46 CEST
Last Modified:              04-10-2005 13:38 CEST
======================================================================
Summary:                    gstreamer cannot play flacs or oggs when p16v is
enabled.
Description: 
Please see bug report at gnome.org:

http://bugzilla.gnome.org/show_bug.cgi?id=171131

gstreamer apps muine and rhythmbox can play mp3 files fine but cannot play
ogg vorbis files or flac files.  i'm guessing this might be an issue with
the driver and alsa-lib?
======================================================================

----------------------------------------------------------------------
 stuNNed - 04-09-05 22:37 
----------------------------------------------------------------------
/etc/asound.conf reads:

pcm.emu10k1 { type plug  slave.pcm "hw:0,4" }  ctl.emu10k1 { type hw  card
0 }

custom alsasink reads:

audioscale ! audioconvert ! alsasink device="hw:0,4"

----------------------------------------------------------------------
 jcdutton - 04-10-05 13:38 
----------------------------------------------------------------------
Does the latest alsa-driver CVS improve things?
I put a patch in yesterday.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-09-05 21:46 stuNNed        New Issue                                    
04-09-05 21:46 stuNNed        Distribution              => Ubuntu Linux 5.0.4
04-09-05 21:46 stuNNed        Kernel Version            => 2.6.10-5-686-smp
04-09-05 21:49 stuNNed        Note Added: 0004430                          
04-09-05 22:11 stuNNed        Issue Monitored: stuNNed                     
04-09-05 22:37 stuNNed        Note Added: 0004431                          
04-10-05 13:38 jcdutton       Note Added: 0004438                          
04-10-05 13:38 jcdutton       Assigned To               => jcdutton        
04-10-05 13:38 jcdutton       Status                   new => feedback     
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
