From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001729]: Only output through headphone jack
Date: Tue, 10 Jan 2006 09:16:44 +0100
Message-ID: <2984790593fc52df44e255ff81c1a14c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DAAAA13D
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2006 09:16:44 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1729> 
======================================================================
Reported By:                Jeff250
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1729
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Breezy 5.10
Kernel Version:             2.6.12-10-686
======================================================================
Date Submitted:             01-10-2006 09:16 CET
Last Modified:              01-10-2006 09:16 CET
======================================================================
Summary:                    Only output through headphone jack
Description: 
I have an HDA Intel card with a Sigmatel STAC9200 chip on a Dell XPS m140
laptop.
In Alsa 1.0.10, sound was outputted to both the speakers and headphones. 
I tried updating to a newer version of ALSA to see if there was any way to
disable speaker output when my headphones are plugged in.

However, in Alsa 1.0.11rc2 and latest CVS, sound is only outputted through
the headphone jack and never through the speakers, regardless of any
alsamixer tinkering.  (I suppose that's irony).  Reverting back to 1.0.10
solves the speaker output problem.

Thank you for your time.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-10-06 09:16 Jeff250        New Issue                                    
01-10-06 09:16 Jeff250        Distribution              => Ubuntu Breezy 5.10
01-10-06 09:16 Jeff250        Kernel Version            => 2.6.12-10-686   
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
