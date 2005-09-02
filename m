From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001390]: aoss script should use $LIB in preload path
Date: Fri, 2 Sep 2005 15:13:19 +0200
Message-ID: <b9ca8d5bb08c260869f0dd021a6d493f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A92E3184
	for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2005 15:13:20 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1390> 
======================================================================
Reported By:                ikonst
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1390
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-01-2005 23:15 CEST
Last Modified:              09-02-2005 15:13 CEST
======================================================================
Summary:                    aoss script should use $LIB in preload path
Description: 
The $LIB variable (the $ should be escaped with \$ in shell scripts) is
substituted by the shared library loader with "lib" in the 32-bit loader
and "lib64" in the 64-bit loader (or whatever policy the distro hardcodes
into their ld.so). By using $LIB, we ensure that when both x86 and x86-64
libalsa-oss packages are installed, the right one will be chosen for each
app.

For example, here's what I put in my aoss script:
LD_PRELOAD=${exec_prefix}/\$LIB/libaoss.so exec "$@"

======================================================================

----------------------------------------------------------------------
 ikonst - 09-02-05 13:00 
----------------------------------------------------------------------
> Or do they all use the same ld.so hack, the only difference being the
directory where 64 bit libs live?

Yes, it is so.

----------------------------------------------------------------------
 tiwai - 09-02-05 15:13 
----------------------------------------------------------------------
Fixed on CVS.  The old aoss is kept as aoss-old in the tree but not
installed as default.

Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-01-05 23:15 ikonst         New Issue                                    
09-01-05 23:50 rlrevell       Note Added: 0005999                          
09-01-05 23:53 ikonst         Note Added: 0006000                          
09-02-05 00:12 rlrevell       Note Added: 0006001                          
09-02-05 11:53 tiwai          Note Added: 0006005                          
09-02-05 13:00 ikonst         Note Added: 0006008                          
09-02-05 13:08 ikonst         File Added: alsa-aoss.patch                    
09-02-05 15:13 tiwai          Status                   new => resolved     
09-02-05 15:13 tiwai          Resolution               open => fixed       
09-02-05 15:13 tiwai          Assigned To               => tiwai           
09-02-05 15:13 tiwai          Note Added: 0006010                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
