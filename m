From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000783]: Bug in handling of NONBLOCK in core/oss/pcm_oss.c?
Date: Mon, 3 Jan 2005 17:27:21 +0100
Message-ID: <d4409d28464d368d6ffa41f1cc79c92c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5A99F2AB
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2005 17:27:21 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=783> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   783
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-03-2005 16:40 CET
Last Modified:              01-03-2005 17:27 CET
======================================================================
Summary:                    Bug in handling of NONBLOCK in core/oss/pcm_oss.c?
Description: 
I just discovered that Ubuntu is applying the patch presented below.  It
adds three lines to snd_pcm_oss_read1().

(The patch comes from this file:
http://people.ubuntu.com/~scott/ongoing-merge/alsa-driver/alsa-driver_merged.patch
)

The patch doesn't appear in your cvs.  I decided that I should forward it
to you for consideration.  If it's correct, it's probably obvious to you
that it is; if it isn't correct, it's probably obvious to you that it
isn't.

Note that the three lines added by the patch are copied verbatim out of
snd_pcm_oss_write1().

--- alsa-driver_1.0.7-2/sound/core/oss/pcm_oss.c	2004-11-11
06:41:05.000000000 +0000
+++ alsa-driver_1.0.7-2ubuntu1/sound/core/oss/pcm_oss.c	2004-12-11
12:46:11.806838912 +0000
@@ -926,6 +926,9 @@ static ssize_t snd_pcm_oss_read1(snd_pcm
 			buf += tmp;
 			bytes -= tmp;
 			xfer += tmp;
+			if ((substream->ffile->f_flags & O_NONBLOCK) != 0 &&
+			    tmp != runtime->oss.period_bytes)
+				break;
 		}
 	}
 	return xfer;

======================================================================

----------------------------------------------------------------------
 tiwai - 01-03-05 16:52 
----------------------------------------------------------------------
Any bug reports about this?

I don't think the patch is necessary.  When the returned value is less
than the expected, it's still OK.  At the next read, it should receive
-EAGAIN.  So, the code will get out of loop anyway at the next read.

----------------------------------------------------------------------
 jdthood - 01-03-05 17:27 
----------------------------------------------------------------------
> Any bug reports about this?

No.

I have forwarded your reply to Matt Zimmerman who maintains the ubuntu
package.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-03-05 16:40 jdthood        New Issue                                    
01-03-05 16:52 tiwai          Note Added: 0003068                          
01-03-05 17:27 jdthood        Note Added: 0003070                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
