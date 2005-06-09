From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001160]: Compilation hangs on hda_codec.c and ak4114.c
Date: Thu, 9 Jun 2005 11:19:35 +0200
Message-ID: <181360dde912a4cfb081bba472ed3488@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 05C9F1CB
	for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2005 11:19:35 +0200 (MEST)
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
Last Modified:              06-09-2005 11:19 CEST
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

----------------------------------------------------------------------
 tiwai - 06-08-05 15:10 
----------------------------------------------------------------------
Grrr, an old 2.6 kernel...  Need a patch in alsa-driver...

----------------------------------------------------------------------
 Henne - 06-09-05 11:19 
----------------------------------------------------------------------
Aye, I found the Problem!
The Aurox 10.0 werent from the original 2.6 kernels.
 
The create_workqueue macro came to the kernel in 2.6.6, but it should call
the __create_workqueue function with fitting args.

/* Original Kernel Headers *>=2.6.6/
extern struct workqueue_struct *__create_workqueue(const char *name,
						    int singlethread);
#define create_workqueue(name) __create_workqueue((name), 0)

/* Aurox Header Files */
extern struct workqueue_struct *__create_workqueue(const char *name,
						    int singlethread,
						    unsigned long freezer_flag);
#define create_workqueue(name, flags) __create_workqueue((name), 0,
flags)
#define create_singlethread_workqueue(name, flags)
__create_workqueue((name), 1, flags)

I think this is not your prob, the distri was wrong.
That one could be closed! :>

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-05 12:02 Henne          New Issue                                    
06-06-05 12:02 Henne          Distribution              => Aurox 10.0      
06-06-05 12:02 Henne          Kernel Version            => 2.6.7-aurox     
06-08-05 15:10 tiwai          Note Added: 0004931                          
06-09-05 11:19 Henne          Note Added: 0004979                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
