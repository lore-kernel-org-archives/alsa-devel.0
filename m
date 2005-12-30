From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001564]: default 'External Amplifier' sound setting
Date: Sat, 31 Dec 2005 00:24:27 +0100
Message-ID: <2735bdc7de01f08413f3d1f3bfd795f2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 58F63194
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 00:24:27 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1564> 
======================================================================
Reported By:                Miguel
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1564
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 4
Kernel Version:             2.6.14-1.1637_FC4
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             11-16-2005 16:23 CET
Last Modified:              12-31-2005 00:24 CET
======================================================================
Summary:                    default 'External Amplifier' sound setting
Description: 
I am a sound newbie. I apologize for this FAQ ... I searched through
bugzilla but was unable to piece together the answer. 

This bug seems related, but it looked like to me that you were waiting for
information from the submitter:

  https://bugtrack.alsa-project.org/alsa-bug/view.php?id=79

On Dell Latitude D600 and D400 laptops, with a clean install of FC4 ... or
with all the updates, there is no sound from the built-in speakers. 

Headphones do produce sound. 

Using alsamixer and typing 'm' on the 'External Amplifier' *does* enable
the built-in speakers. 

I filed a bug at bugzilla.redhat.com ... 

  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=173250

... they essentially rejected it, saying that some systems need it ON and
other systems need it OFF


Q: Was this answer from RedHat correct? 


>From messages I have seen on mailing lists, this is a problem on more
systems than just Dell Systems. 

I would like to understand this problem a bit more and try to assist in
getting it resolved. 
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-31-05 00:24 
----------------------------------------------------------------------
This is correct - some systems need it on and some need it off so there's
no good default.  It's important to try all mixer settings if you don't
get any sound.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-16-05 16:23 Miguel         New Issue                                    
11-16-05 16:23 Miguel         Distribution              => Fedora Core 4   
11-16-05 16:23 Miguel         Kernel Version            => 2.6.14-1.1637_FC4
11-17-05 15:59 Miguel         Issue Monitored: Miguel                      
12-31-05 00:24 rlrevell       Status                   new => closed       
12-31-05 00:24 rlrevell       Note Added: 0007317                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
