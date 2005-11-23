From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001579]: code.c test uses x86 asm, it should be x86/amd64 only
Date: Wed, 23 Nov 2005 17:36:09 +0100
Message-ID: <edf5a6496fea9d50d8feb47c4f7f5e12@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 553E9176
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2005 17:36:09 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1579> 
======================================================================
Reported By:                Flameeyes
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1579
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-19-2005 20:17 CET
Last Modified:              11-23-2005 17:36 CET
======================================================================
Summary:                    code.c test uses x86 asm, it should be x86/amd64
only
Description: 
As per summary, the code.c test can't be built for any other system but x86
or amd64, as it uses inline asm focused on i386.

The attached patch makes it conditional to those arches.

HTH,
Diego
======================================================================

----------------------------------------------------------------------
 tiwai - 11-23-05 17:34 
----------------------------------------------------------------------
It's easier just to remove code from check_PROGRAMS.  It's nothing but a
test code for dmix, and shouldn't be used as "check".

----------------------------------------------------------------------
 tiwai - 11-23-05 17:36 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-19-05 20:17 Flameeyes      New Issue                                    
11-19-05 20:17 Flameeyes      File Added: alsa-lib-1.0.10-test-ppc.patch        
           
11-23-05 17:34 tiwai          Note Added: 0006817                          
11-23-05 17:36 tiwai          Status                   new => resolved     
11-23-05 17:36 tiwai          Resolution               open => fixed       
11-23-05 17:36 tiwai          Assigned To               => tiwai           
11-23-05 17:36 tiwai          Note Added: 0006818                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
