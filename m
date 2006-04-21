From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001934]: make problem
Date: Fri, 21 Apr 2006 05:39:42 +0200
Message-ID: <d08798ef8a36f3b94fe3d929a8c29a21@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 35F45165
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2006 05:39:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1934> 
======================================================================
Reported By:                kvo
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1934
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               RHEL4 Update 3
Kernel Version:             2.6.9-34.EL
======================================================================
Date Submitted:             03-17-2006 12:19 CET
Last Modified:              04-21-2006 05:39 CEST
======================================================================
Summary:                    make problem
Description: 
./configure works OK. running make give error during compilation: module
'include/asound.h' (line 210) has some 'typedef' that doesn't match with
(probably) OS include. As a result, compilation stops and driver can not
be produced.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0002042 Compile error : /usr/local/src/alsa/als...
======================================================================

----------------------------------------------------------------------
 mnemotronic - 04-21-06 00:03 
----------------------------------------------------------------------
FYI, in an attempt to get a working driver, I commented out this line in
adriver.h:
// typedef unsigned __nocast gfp_t

and recompiled.  This returned a different error:
...etc.../acore/pcm_native.c:74: error: syntax error before
"snd_pcm_link_rwlock"
...etc.../acore/pcm_native.c:74: warning: type defaults to `int' in
declaration of `snd_pcm_link_rwlock'
...etc.../acore/pcm_native.c:74: error: conflicting types for
'snd_pcm_link_rwlock'
...etc.../include/sound/pcm.h:454: error: previous declaration of
'snd_pcm_link_rwlock' was here
...etc.../acore/pcm_native.c:74: error: conflicting types for
'snd_pcm_link_rwlock'
...etc.../include/sound/pcm.h:454: error: previous declaration of
'snd_pcm_link_rwlock' was here
...etc.../acore/pcm_native.c:74: error: incompatible types in
initialization
...etc.../acore/pcm_native.c:74: error: initializer element is not
constant
...etc.../acore/pcm_native.c:74: warning: data definition has no type or
storage class
...etc.../acore/pcm_native.c: In function `snd_pcm_action_lock_irq':

heavy sigh.

----------------------------------------------------------------------
 Raymond - 04-21-06 05:39 
----------------------------------------------------------------------
http://lwn.net/Articles/128951/

The __nocast attribute

Since the GFP flags passed to kmalloc() are explicitly defined as unsigned
values, they will not cause a warning to be issued. Any normal integer
variable or constant, however, will be flagged. Similarly, the use of an
integer value where an enumerated type is expected will be caught.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-17-06 12:19 kvo            New Issue                                    
03-17-06 12:19 kvo            Distribution              => RHEL4 Update 3  
03-17-06 12:19 kvo            Kernel Version            => 2.6.9-34.EL     
03-17-06 12:25 tiwai          Note Added: 0008643                          
03-19-06 22:26 kvo            Note Added: 0008697                          
03-21-06 17:33 tiwai          Note Added: 0008749                          
03-25-06 20:47 kvo            File Added: config.log                       
03-25-06 22:19 kvo            Note Added: 0008952                          
04-09-06 18:47 kvo            File Added: info.zip                         
04-09-06 18:56 kvo            Note Added: 0009181                          
04-09-06 19:05 kvo            Issue Monitored: tiwai                       
04-09-06 19:05 kvo            Note Added: 0009182                          
04-10-06 16:46 tiwai          Note Added: 0009196                          
04-10-06 18:38 kvo            Note Added: 0009213                          
04-10-06 18:43 tiwai          Note Added: 0009214                          
04-20-06 15:30 tiwai          Relationship added       has duplicate 0002042
04-20-06 22:04 mnemotronic    Issue Monitored: mnemotronic                    
04-21-06 00:03 mnemotronic    Note Added: 0009402                          
04-21-06 05:39 Raymond        Note Added: 0009406                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
