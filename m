From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001103]: Please support /dev/snd/aload* as well
Date: Fri, 13 May 2005 19:45:01 +0200
Message-ID: <e84cfeeb17166a3f7b440d50ae6d9816@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D713C2A8
	for <alsa-devel@alsa-project.org>; Fri, 13 May 2005 19:45:01 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1103> 
======================================================================
Reported By:                jordi
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1103
Category:                   general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-13-2005 13:49 CEST
Last Modified:              05-13-2005 19:45 CEST
======================================================================
Summary:                    Please support /dev/snd/aload* as well
Description: 
Currently, alsa-lib looks for aload* files in /dev.

I think it would be nice if these files could live in /dev/snd, with the
rest of ALSA devices.

Can alsa-lib be modified to support aload* devices in both /dev and
/dev/snd?

Maybe in the future, after people have transitioned, support for
/dev/aload* could be dropped. Defaulting to /dev/snd and falling back to
/dev could be the way to work for now.

The udev maintainer thinks this would be a good enhancement.
======================================================================

----------------------------------------------------------------------
 jdthood - 05-13-05 15:36 
----------------------------------------------------------------------
> FYI, the support of /dev/aload* can be disabled via --disable-aload
> configure option.


What is the advantage of disabling this support?


> This is better together with udev.


Why is it better to disable aload support with udev?  I was assuming
that the whole point of having the aload devices was to allow the
ALSA library to induce module loading on udev systems.

----------------------------------------------------------------------
 tiwai - 05-13-05 19:45 
----------------------------------------------------------------------
Enabling /dev/aload* might cause the strange side-effect together with
udev.  At least I have problems with modprobe and udev.

/dev/aload* was introduced far earlier than udev.  It was for 2.2/2.4
kernels.  The reason it stand in /dev and not in /dev/snd is that /dev/snd
was a symlink to /proc/asound/dev in early days.

I don't mind to change the path of these files.  The files are accessed
only internally by alsa-lib, so changing the path won't be a big problem. 
But this kind of thing should be specified in configure option.  Feel free
to send a patch :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-13-05 13:49 jordi          New Issue                                    
05-13-05 14:15 tiwai          Note Added: 0004644                          
05-13-05 15:36 jdthood        Note Added: 0004649                          
05-13-05 19:45 tiwai          Note Added: 0004653                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
