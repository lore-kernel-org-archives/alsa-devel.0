From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001727]: After un-muting the soundcard and detecting the ca0106 module it is unable to produce any sound.
Date: Mon, 9 Jan 2006 22:27:15 +0100
Message-ID: <5c13ddc8749348d6d268b1aaf4778e16@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 97839144
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2006 22:27:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1727> 
======================================================================
Reported By:                domsmith
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1727
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Slackware 10.1, 10.2, ubuntu 5.10 kubuntu unstable
(dapper)
Kernel Version:             2.6.12 ,  2.6.14
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             01-09-2006 10:56 CET
Last Modified:              01-09-2006 22:27 CET
======================================================================
Summary:                    After un-muting the soundcard and detecting the
ca0106 module it is unable to produce any sound.
Description: 
Tested under Slackware 10.1, 10.2, ubuntu 5.10 kubuntu unstable (dapper)

The ca0106 module gets detected under all these versions but it is unable
to produce any sound. The Soundcard is a on-board soundblaster live built
into a shuttle SD11G5. Under ubuntu i rebuilt the kernel and alsa drivers
but still couldn't get any sound what so ever.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001600 On a Shuttle SD11G5 the audio card is r...
duplicate of        0001675 Shuttle SD11G5 (pentium M) CA0106 sound...
======================================================================

----------------------------------------------------------------------
 jcdutton - 01-09-06 22:27 
----------------------------------------------------------------------
Fixed in alsa-driver 1.0.11rc3 or above.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-09-06 10:56 domsmith       New Issue                                    
01-09-06 10:56 domsmith       Distribution              => Slackware 10.1, 10.2,
ubuntu 5.10 kubuntu unstable (dapper)
01-09-06 10:56 domsmith       Kernel Version            => 2.6.12 ,  2.6.14
01-09-06 22:26 jcdutton       Relationship added       duplicate of 0001600
01-09-06 22:26 jcdutton       Relationship added       duplicate of 0001675
01-09-06 22:27 jcdutton       Status                   assigned => closed  
01-09-06 22:27 jcdutton       Note Added: 0007545                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
