From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001588]: alsa1.0.10 driver compilation error in adriver.h
Date: Tue, 22 Nov 2005 18:06:26 +0100
Message-ID: <a549992b5808790963ab30b64501e3e2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2AB02172
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2005 18:06:26 +0100 (MET)
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
Status:                     assigned
Distribution:               
Kernel Version:             2.4.99
======================================================================
Date Submitted:             11-22-2005 15:30 CET
Last Modified:              11-22-2005 18:06 CET
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
 Clemens Ladisch - 11-22-05 17:28 
----------------------------------------------------------------------
Kernel 2.4.99 doesn't exist.  Which distribution are you using?

----------------------------------------------------------------------
 alanmann - 11-22-05 18:06 
----------------------------------------------------------------------
Sorry, I meant 2.4.21-99 kernel!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-22-05 15:30 alanmann       New Issue                                    
11-22-05 15:30 alanmann       Kernel Version            => 2.4.99          
11-22-05 17:28 Clemens LadischNote Added: 0006788                          
11-22-05 18:06 alanmann       Note Added: 0006789                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
