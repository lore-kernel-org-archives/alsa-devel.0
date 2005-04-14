From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000729]: arts error on boot: AudioSubSystem:handleIO:write failed
Date: Thu, 14 Apr 2005 12:47:25 +0200
Message-ID: <fb8a5d4a3e60efc65255f995f27c07e3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 69366221
	for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2005 12:47:25 +0200 (MEST)
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


The following issue requires your FEEDBACK.
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
Status:                     feedback
Distribution:               Suse 9.1
Kernel Version:             2.6.5-7.11
======================================================================
Date Submitted:             12-19-2004 11:50 CET
Last Modified:              04-14-2005 12:47 CEST
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
 jbailo - 03-04-05 03:39 
----------------------------------------------------------------------
I just cvs installed the 1.08 alsa system with the ca0106 driver which is
now in the supported drivers list for my card, the Sound Blaster Live!
24-bit.

However, after modprobe, the same error as originally reported appears:

Sound server fatal error:
AudioSubSystem::handleIO: write failed
len = 3760, can_write = 3762, errno = 32 (Broken pipe)
This might be a sound hardware/driver specific problem (see aRts FAQ)

I was originally using a OSS driver in the interim, however, I uninstalled
it completely before installing the 1.08 Alsa system and ca0106 driver.

----------------------------------------------------------------------
 jcdutton - 04-14-05 12:47 
----------------------------------------------------------------------
The latest alsa-driver CVS has some improvements. Please try it and report.

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
