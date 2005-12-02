From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001588]: alsa1.0.10 driver compilation error in adriver.h
Date: Fri, 2 Dec 2005 14:52:25 +0100
Message-ID: <861c12fa5af5c87463efe7f425e988a7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A98AE158
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2005 14:52:25 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1588> 
======================================================================
Reported By:                alanmann
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1588
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.4.99
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-22-2005 15:30 CET
Last Modified:              12-02-2005 14:52 CET
======================================================================
Summary:                    alsa1.0.10 driver compilation error in adriver.h
Description: 
Mainstream alsa1.0.10 downloaded this morning. Make fails in adriver.h
lines 675-713 (added since 1.0.9b); the syntax is wrong?  Has this already
been noticed and fixed?

The section is below:-

static inline unsigned int jiffies_to_msecs(const unsigned long j)
{
#ifndef HAVE_VARIABLE_HZ
	#if HZ <= 1000 && !(1000 % HZ)
		return (1000 / HZ) * j;
	#elif HZ > 1000 && !(HZ % 1000)
		return (j + (HZ / 1000) - 1)/(HZ / 1000);
	#else
		return (j * 1000) / HZ;
	#endif
#else
	if (HZ <= 1000 && !(1000 % HZ))
		return (1000 / HZ) * j;
	else if (HZ > 1000 && !(HZ % 1000))
		return (j + (HZ / 1000) - 1)/(HZ / 1000);
	else
		return (j * 1000) / HZ;
#endif
}
static inline unsigned long msecs_to_jiffies(const unsigned int m)
{
	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
		return MAX_JIFFY_OFFSET;
#ifndef HAVE_VARIABLE_HZ
	#if HZ <= 1000 && !(1000 % HZ)
		return (m + (1000 / HZ) - 1) / (1000 / HZ);
	#elif HZ > 1000 && !(HZ % 1000)
		return m * (HZ / 1000);
	#else
		return (m * HZ + 999) / 1000;
	#endif
#else
	if (HZ <= 1000 && !(1000 % HZ))
		return (m + (1000 / HZ) - 1) / (1000 / HZ);
	else if (HZ > 1000 && !(HZ % 1000))
		return m * (HZ / 1000);
	else
		return (m * HZ + 999) / 1000;
#endif

======================================================================

----------------------------------------------------------------------
 alanmann - 11-24-05 23:43 
----------------------------------------------------------------------
The patch seemed to do the trick, thanks.  Compile successful.

----------------------------------------------------------------------
 tiwai - 12-02-05 14:52 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-22-05 15:30 alanmann       New Issue                                    
11-22-05 15:30 alanmann       Kernel Version            => 2.4.99          
11-22-05 17:28 Clemens LadischNote Added: 0006788                          
11-22-05 18:06 alanmann       Note Added: 0006789                          
11-22-05 18:08 alanmann       Note Edited: 0006789                         
11-22-05 20:01 alanmann       Note Edited: 0006789                         
11-23-05 08:15 Clemens LadischNote Added: 0006808                          
11-23-05 12:52 alanmann       Note Added: 0006809                          
11-23-05 17:20 tiwai          Note Added: 0006812                          
11-23-05 17:20 tiwai          File Added: suse-2.4-fix.diff                    
11-24-05 23:43 alanmann       Note Added: 0006846                          
12-02-05 14:52 tiwai          Status                   assigned => resolved
12-02-05 14:52 tiwai          Resolution               open => fixed       
12-02-05 14:52 tiwai          Note Added: 0006896                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
