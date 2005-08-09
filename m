From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001140]: sine wave generator only works for 16bit cards
Date: Tue, 9 Aug 2005 13:44:20 +0200
Message-ID: <aa2ffdda32c38f911f18ded0febd2e3c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EA1531D1
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:44:20 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1140> 
======================================================================
Reported By:                grabner
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1140
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-29-2005 03:11 CEST
Last Modified:              08-09-2005 13:44 CEST
======================================================================
Summary:                    sine wave generator only works for 16bit cards
Description: 
The simple sine wave generator, which serves as a test program for PCM
audio, only creates 16bit samples. It has no option to switch this
behaviour (although it lists "recognized sample formats"). However, it
doesn't refuse to play to non-16bit devices, which produces noise.

Note: this refers to alsa-lib version 1.0.*9*, but this wasn't available
in the "Product Version" selection.
======================================================================

----------------------------------------------------------------------
 perex - 05-30-05 12:22 
----------------------------------------------------------------------
Thank you for your patch. It was applied to CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-29-05 03:11 grabner        New Issue                                    
05-29-05 03:11 grabner        File Added: pcm.diff                         
05-29-05 03:12 grabner        Issue Monitored: grabner                     
05-30-05 12:22 perex          Status                   new => resolved     
05-30-05 12:22 perex          Resolution               open => fixed       
05-30-05 12:22 perex          Assigned To               => perex           
05-30-05 12:22 perex          Note Added: 0004802                          
08-09-05 13:44 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
