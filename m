From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001101]: [VIA 8237 with ALC850] gstreamer alsasink with default device does not work but with "device=hw:0" it does
Date: Fri, 13 Jan 2006 09:53:38 +0100
Message-ID: <bf1a2b6868c489ed634377be691f59ef@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DC83310C
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2006 09:53:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1101> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1101
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-11-2005 22:15 CEST
Last Modified:              01-13-2006 09:53 CET
======================================================================
Summary:                    [VIA 8237 with ALC850] gstreamer alsasink with
default device does not work but with "device=hw:0" it does
Description: 
The submitter of #305189 and an interlocutor have discovered that
gstreaming to "alsasink" does not work but the same to "alsasink
device=hw:0" does work.

Please see http://bugs.debian.org/305189 for the discussion which includes
lots more detail.
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-13-06 00:18 
----------------------------------------------------------------------
Is this fixed in later ALSA releases?

----------------------------------------------------------------------
 lool - 01-13-06 09:53 
----------------------------------------------------------------------
Now it's hard to tell for gstreamer users, as upstream now queries the
underlying hardware device via snd_pcm_info_get_subdevice() /
snd_pcm_info_get_subdevice_name() and tries both the logical and the
hardware device.

Would be nice to have a C test case.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-11-05 22:15 jdthood        New Issue                                    
05-13-05 14:17 tiwai          Note Added: 0004645                          
05-13-05 15:38 jdthood        Note Added: 0004650                          
05-15-05 22:58 lool           Issue Monitored: lool                        
05-15-05 22:59 lool           Note Added: 0004674                          
06-09-05 14:04 GhePeU         Note Added: 0004980                          
06-09-05 14:04 GhePeU         Issue Monitored: GhePeU                      
06-09-05 14:10 GhePeU         Note Edited: 0004980                         
01-13-06 00:18 rlrevell       Note Added: 0007600                          
01-13-06 09:53 lool           Note Added: 0007634                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
