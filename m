From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001060]: snd-azx rear speakers volume is too low
Date: Mon, 19 Dec 2005 05:53:53 +0100
Message-ID: <e383e8804f61e73f5a0f492d5c430470@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 203C217E
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2005 05:53:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1060> 
======================================================================
Reported By:                maranik
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1060
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu Linux
Kernel Version:             2.6.11.7
======================================================================
Date Submitted:             04-17-2005 23:56 CEST
Last Modified:              12-19-2005 05:53 CET
======================================================================
Summary:                    snd-azx rear speakers volume is too low
Description: 
I have a Azalia sound chip, sound works with snd-azx module, but i can only
listen to front speakers. Rear speakers are like inesistent. 
Sound is too low. 
I set 6ch in alsamixer.

TIA.
======================================================================

----------------------------------------------------------------------
 maranik - 04-19-05 20:56 
----------------------------------------------------------------------
I installed 1.0.9rc2 and i loaded snd-hda-intel. The problem persists, and
the sound quality is worse than before.
I hope you can help me. 

TIA

----------------------------------------------------------------------
 rlrevell - 12-19-05 05:53 
----------------------------------------------------------------------
Please try 1.0.11rc1, lots of bugs have been fixed in this driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-17-05 23:56 maranik        New Issue                                    
04-17-05 23:56 maranik        Distribution              => Ubuntu Linux    
04-17-05 23:56 maranik        Kernel Version            => 2.6.11.7        
04-19-05 17:41 tiwai          Note Added: 0004525                          
04-19-05 17:41 tiwai          Category                 PCI - azx => PCI -
hda-intel
04-19-05 20:53 maranik        File Added: asound.state                     
04-19-05 20:53 maranik        File Added: codec#2                          
04-19-05 20:56 maranik        Note Added: 0004539                          
12-19-05 05:53 rlrevell       Note Added: 0007089                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
