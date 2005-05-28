From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000729]: arts error on boot: AudioSubSystem:handleIO:write failed
Date: Sat, 28 May 2005 12:27:53 +0200
Message-ID: <89bcd4ab2bd0e0b34127bacb4a0086de@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 24DDD214
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 12:27:54 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=729> 
======================================================================
Reported By:                jbailo
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   729
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Suse 9.1
Kernel Version:             2.6.5-7.11
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             12-19-2004 11:50 CET
Last Modified:              05-28-2005 12:27 CEST
======================================================================
Summary:                    arts error on boot: AudioSubSystem:handleIO:write
failed
Description: 
On book, an arts error message alert appears:

AudioSubSystem:handleIO: write failed
len = 3760, can_write = 3762, errno=32 (Broken pipe)
This mightbe a sound hardware/driver specific problem (see aRts FAQ)


======================================================================

----------------------------------------------------------------------
 jcdutton - 04-14-05 12:47 
----------------------------------------------------------------------
The latest alsa-driver CVS has some improvements. Please try it and report.

----------------------------------------------------------------------
 jcdutton - 05-28-05 12:27 
----------------------------------------------------------------------
Closed due to lack of feedback.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-19-04 11:50 jbailo         New Issue                                    
12-19-04 11:50 jbailo         File Added: boot.msg                         
12-19-04 11:50 jbailo         Distribution              => Suse 9.1        
12-19-04 11:50 jbailo         Kernel Version            => 2.6.5-7.11      
12-19-04 11:51 jbailo         Issue Monitored: jbailo                      
03-04-05 03:39 jbailo         Note Added: 0003796                          
04-14-05 12:47 jcdutton       Note Added: 0004488                          
04-14-05 12:47 jcdutton       Status                   assigned => feedback
05-28-05 12:27 jcdutton       Status                   feedback => closed  
05-28-05 12:27 jcdutton       Note Added: 0004770                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
