From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001160]: Compilation hangs on hda_codec.c and ak4114.c
Date: Mon, 6 Jun 2005 12:02:36 +0200
Message-ID: <af15e4ede2b884ecbf165482b24165e1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [195.113.161.147])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ED7F010F
	for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2005 12:02:36 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1160> 
======================================================================
Reported By:                Henne
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1160
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Aurox 10.0
Kernel Version:             2.6.7-aurox
======================================================================
Date Submitted:             06-06-2005 12:02 CEST
Last Modified:              06-06-2005 12:02 CEST
======================================================================
Summary:                    Compilation hangs on hda_codec.c and ak4114.c
Description: 
I tried to compile the driver package with cvscompile, and it hung at:
alsa-kernel/i2c/other/ak4114.c
alsa-kernel/pci/hda/hda_codec.c
with the message, that the macro create_workqueue needs 2 arguments, not
one.
I browsed the code and found out, that that macro is defined for kernels
lower than 2.6 in the alsa-driver, but I have a greater one. So the macro
wasn't defined and another marco from the kernel source was taken, which
needs 2 arguments.
I've added a zero as a second arg and the compilation worked, but that
imho couldn't be the right solution.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-05 12:02 Henne          New Issue                                    
06-06-05 12:02 Henne          Distribution              => Aurox 10.0      
06-06-05 12:02 Henne          Kernel Version            => 2.6.7-aurox     
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
