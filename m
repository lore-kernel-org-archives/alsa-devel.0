From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001160]: Compilation hangs on hda_codec.c and ak4114.c
Date: Fri, 8 Jul 2005 10:15:34 +0200
Message-ID: <5be93db4757f01326d64489b3c757ff1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 84F25186
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:15:34 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0001240.
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
Status:                     resolved
Distribution:               Aurox 10.0
Kernel Version:             2.6.7-aurox
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-06-2005 12:02 CEST
Last Modified:              06-28-2005 11:28 CEST
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
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001240 compile fails on ak4114, macro missing ...
======================================================================

----------------------------------------------------------------------
 tiwai - 06-08-05 15:10 
----------------------------------------------------------------------
Grrr, an old 2.6 kernel...  Need a patch in alsa-driver...

----------------------------------------------------------------------
 Henne - 06-14-05 11:49 
----------------------------------------------------------------------
Aye, I found the Problem!
The Aurox 10.0 has some changes from the original 2.6 kernels.
 
In the "old" 2.6 kernels(<2.6.6) create_workqueue was a function with one
argument. The create_workqueue macro (1 arg) came to the kernel in 2.6.6,
but it calls the __create_workqueue function with fitting args.
The Aurox-2.6.7-10.0 kernel added one argument. Look! :
 
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

I think this is not your prob, the distri broke the compatibility.

This can be closed, but should be mentioned in README.



----------------------------------------------------------------------
 perex - 06-28-05 11:28 
----------------------------------------------------------------------
I added detection for modified macro to configure.in. The code is in CVS
(and will be in next release).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-05 12:02 Henne          New Issue                                    
06-06-05 12:02 Henne          Distribution              => Aurox 10.0      
06-06-05 12:02 Henne          Kernel Version            => 2.6.7-aurox     
06-08-05 15:10 tiwai          Note Added: 0004931                          
06-09-05 11:19 Henne          Note Added: 0004979                          
06-09-05 11:39 Henne          Note Edited: 0004979                         
06-09-05 12:04 Henne          Note Edited: 0004979                         
06-09-05 12:21 Henne          Note Edited: 0004979                         
06-14-05 11:49 Henne          Note Edited: 0004979                         
06-28-05 11:28 perex          Status                   assigned => resolved
06-28-05 11:28 perex          Resolution               open => fixed       
06-28-05 11:28 perex          Note Added: 0005295                          
07-08-05 10:15 perex          Relationship added       related to 0001240  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
