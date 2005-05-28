From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001043]: gstreamer cannot play flacs or oggs when p16v is enabled.
Date: Sat, 28 May 2005 12:27:10 +0200
Message-ID: <8b8c414769a7626206cb59e312a687dc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8A6D0214
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 12:27:10 +0200 (MEST)
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
Status:                     closed
Distribution:               Ubuntu Linux 5.0.4
Kernel Version:             2.6.10-5-686-smp
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             04-09-2005 21:46 CEST
Last Modified:              05-28-2005 12:27 CEST
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
 jcdutton - 04-10-05 13:38 
----------------------------------------------------------------------
Does the latest alsa-driver CVS improve things?
I put a patch in yesterday.

----------------------------------------------------------------------
 jcdutton - 05-28-05 12:27 
----------------------------------------------------------------------
Closed due to lack of feedback.

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
05-28-05 12:27 jcdutton       Status                   feedback => closed  
05-28-05 12:27 jcdutton       Note Added: 0004769                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
