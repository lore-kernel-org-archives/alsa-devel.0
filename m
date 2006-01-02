From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000984]: No Sound
Date: Mon, 2 Jan 2006 20:25:02 +0100
Message-ID: <f335947ee2bc550761a5f19aa767dcbd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 014D8162
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2006 20:25:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=984> 
======================================================================
Reported By:                mailavj
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   984
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.7-2
Resolution:                 reopened
Fixed in Version:           
======================================================================
Date Submitted:             03-12-2005 19:09 CET
Last Modified:              01-02-2006 20:25 CET
======================================================================
Summary:                    No Sound
Description: 
my sound card is Sound MAX integrated Audio with Intel D865 GBF
motherboard..
i'm not getting sound output..
kernel version is 2.6.7-2 and my alsa driver version is 1.0.6-a
Is there any way to get sound out put on this card using this driver.. 
please help

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000970 No Sound
======================================================================

----------------------------------------------------------------------
 jdthood - 03-23-05 16:02 
----------------------------------------------------------------------
Please send the output of 

   lsmod
   uname -a
   lspci
   cat /proc/asound/version
   cat /proc/asound/cards

----------------------------------------------------------------------
 rlrevell - 01-02-06 20:25 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-12-05 19:09 mailavj        New Issue                                    
03-16-05 13:00 tiwai          Note Added: 0003952                          
03-16-05 14:56 tiwai          Relationship added       duplicate of 0000970
03-16-05 14:56 tiwai          Duplicate ID             0 => 970            
03-16-05 14:56 tiwai          Status                   new => resolved     
03-16-05 14:56 tiwai          Resolution               open => duplicate   
03-16-05 14:56 tiwai          Assigned To               => tiwai           
03-16-05 14:56 tiwai          Assigned To              tiwai =>            
03-17-05 18:49 mailavj        Distribution              => Debian          
03-17-05 18:49 mailavj        Kernel Version            => 2.6.7-2         
03-17-05 18:49 mailavj        Status                   resolved => feedback
03-17-05 18:49 mailavj        Resolution               duplicate => reopened
03-17-05 18:49 mailavj        Note Added: 0003981                          
03-17-05 18:49 mailavj        Assigned To               => tiwai           
03-17-05 18:50 mailavj        Note Added: 0003982                          
03-17-05 18:55 rlrevell       Note Added: 0003983                          
03-18-05 18:14 tiwai          Note Added: 0003999                          
03-23-05 16:02 jdthood        Note Added: 0004169                          
01-02-06 20:25 rlrevell       Status                   feedback => closed  
01-02-06 20:25 rlrevell       Note Added: 0007380                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
