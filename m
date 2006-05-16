From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002124]: snd_config_update_free_global kills applications using user space alsa plugins
Date: Tue, 16 May 2006 20:06:48 +0200
Message-ID: <dd0094810084e29f4cd7418ae33f3400@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0860E172
	for <alsa-devel@alsa-project.org>; Tue, 16 May 2006 20:06:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2124> 
======================================================================
Reported By:                fchevalier
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2124
Category:                   0_general
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-14-2006 19:10 CEST
Last Modified:              05-16-2006 20:06 CEST
======================================================================
Summary:                    snd_config_update_free_global kills applications
using user space alsa plugins
Description: 

Calling snd_config_update_free_global will make applications using user
space alsa plugins SIGSEGV in hard to disover way.

This is due due the fact that snd_config_update_free_global calls
snd_dlobj_cache_cleanup, which in turns unloads the user space plugins,
even if symbols are still in use.
The result is that the next call to *any* alsa function is likely to crash
if it ends up calling a plugin function.

It took me a whole day to troubleshoot the issue in ekiga 2.0.1 :-)
======================================================================

----------------------------------------------------------------------
 tiwai - 05-15-06 11:01 
----------------------------------------------------------------------
Maybe we should add a refcount so that the objects won't be released when
used.

----------------------------------------------------------------------
 fchevalier - 05-16-06 20:06 
----------------------------------------------------------------------
What is sure is there should be something done... finding the best way is a
bit more complicated :-)
A few other suggestions:

1°)add another alsa cleanup function somewhere that would call
snd_dlobj_cache_cleanup, and document the fact it should not be called
under some circumstances ==> however this puts the burden on the
application as it will have to to call yet another cleanup function

2°)register snd_dlobj_cache_cleanup using atexit() : however this consumes
one slot in the 32 availables for atexit functions registration

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-14-06 19:10 fchevalier     New Issue                                    
05-15-06 11:01 tiwai          Note Added: 0009817                          
05-16-06 20:06 fchevalier     Note Added: 0009841                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
