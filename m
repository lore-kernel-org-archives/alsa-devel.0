From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001040]: ice1724: Invalid EEPROM (size = 255)
Date: Fri, 30 Dec 2005 05:28:19 +0100
Message-ID: <56a278335b1b5cbe0f4f527d9c815f07@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E93B9193
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 05:28:19 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1040> 
======================================================================
Reported By:                lorenb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1040
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.11
======================================================================
Date Submitted:             04-08-2005 14:10 CEST
Last Modified:              12-30-2005 05:28 CET
======================================================================
Summary:                    ice1724: Invalid EEPROM (size = 255)
Description: 
Have a Shuttle SN25P based system:
http://global.shuttle.com/Product/Barebone/SN25P.asp

It comes with VIA Envy24PT audio controller:
http://www.via.com.tw/en/products/audio/controllers/envy24pt/

Every time I tried and load the ice1724 driver I get an error about
invalid EEPROM size.

I saw this old bug:
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000142

Which indicated this issue was resolved in 1.0.5a.  I'm using v1.0.9rc2.

======================================================================

----------------------------------------------------------------------
 lorenb - 04-12-05 21:11 
----------------------------------------------------------------------
I came across this blog entry, where someone with the same system as me was
having the same ice1724 issue:

http://www.nakack.net/?p=19

He wrote a patch and made it available:
http://www.nakack.net/?p=20

I tried it out and it works for me.  The modules load and I have sound
working on my system. 

The only thing not working is esound. It complains it can't open the sound
device for various modes (8-bit|16-bit + mono|stereo).  That just means I
can't listen to sound effects in GNOME, not really a big loss to me.

----------------------------------------------------------------------
 rlrevell - 12-30-05 05:28 
----------------------------------------------------------------------
Any improvement with later ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-08-05 14:10 lorenb         New Issue                                    
04-08-05 14:10 lorenb         Distribution              => Gentoo          
04-08-05 14:10 lorenb         Kernel Version            => 2.6.11          
04-09-05 19:09 ungod          Note Added: 0004427                          
04-12-05 21:11 lorenb         Note Added: 0004464                          
12-30-05 05:28 rlrevell       Note Added: 0007247                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
