From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000557]: SNDCTL_DSP_GETOPTR not working correctly in specific situation
Date: Thu, 26 May 2005 17:27:45 +0200
Message-ID: <ea585bb21353f1f2b4cd644ec750e240@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BDDE2202
	for <alsa-devel@alsa-project.org>; Thu, 26 May 2005 17:27:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=557> 
======================================================================
Reported By:                minmax
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   557
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             vanilla 2.6.7
======================================================================
Date Submitted:             10-01-2004 16:18 CEST
Last Modified:              05-26-2005 17:27 CEST
======================================================================
Summary:                    SNDCTL_DSP_GETOPTR not working correctly in specific
situation
Description: 
When the first few writes to the oss emulation device are done in specific
way, SNDCTL_DSP_GETOPTR returns wrongly huge results in info.bytes
======================================================================

----------------------------------------------------------------------
 minmax - 05-20-05 00:38 
----------------------------------------------------------------------
parente: The code that i posted is an example of WORKAROUND for the bug.
not the code from alsa, but something an application writer can do to get
around of the bug in ALSA. I have not investigated where in ALSA the bug
actually lies.

----------------------------------------------------------------------
 Roger Mach - 05-26-05 17:27 
----------------------------------------------------------------------
Summary: Fixes bug 557: SNDCTL_DSP_GETOPTR not working correctly

This patch changes snd_pcm_oss_bytes() by adding a local variable
for the frames -> bytes conversion, which means that the frame count
is no longer corrupted by this conversion.

Signed-off-by: Roger Mach <bigmach@us.ibm.com>

--- alsa-kernel/core/oss/pcm_oss.c.orig 2005-05-24 09:13:47.000000000
-0700
+++ alsa-kernel/core/oss/pcm_oss.c      2005-05-24 09:11:40.000000000
-0700
@@ -124,11 +124,12 @@ int snd_pcm_plugin_append(snd_pcm_plugin

 static long snd_pcm_oss_bytes(snd_pcm_substream_t *substream, long
frames)
 {
+       long bytes = 0;
        snd_pcm_runtime_t *runtime = substream->runtime;
        snd_pcm_uframes_t buffer_size =
snd_pcm_lib_buffer_bytes(substream);
-       frames = frames_to_bytes(runtime, frames);
+       bytes = frames_to_bytes(runtime, frames);
        if (buffer_size == runtime->oss.buffer_bytes)
-               return frames;
+               return bytes;
        return (runtime->oss.buffer_bytes * frames) / buffer_size;
 }

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-01-04 16:18 minmax         New Issue                                    
10-01-04 16:18 minmax         Distribution              => Debian unstable 
10-01-04 16:18 minmax         Kernel Version            => vanilla 2.6.7   
10-02-04 10:52 minmax         Issue Monitored: minmax                      
04-09-05 16:09 jdthood        Note Added: 0004406                          
04-09-05 16:22 minmax         Note Added: 0004410                          
05-13-05 15:20 gk4            Note Added: 0004646                          
05-13-05 15:24 perex          Note Added: 0004647                          
05-13-05 15:26 tiwai          Note Added: 0004648                          
05-13-05 19:35 gk4            Note Added: 0004651                          
05-13-05 19:38 tiwai          Note Added: 0004652                          
05-13-05 19:48 gk4            Note Added: 0004655                          
05-15-05 15:50 tiwai          Note Added: 0004663                          
05-16-05 16:08 gk4            Note Added: 0004676                          
05-19-05 15:28 parente        Note Added: 0004693                          
05-20-05 00:38 minmax         Note Added: 0004698                          
05-26-05 17:27 Roger Mach     Note Added: 0004738                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
