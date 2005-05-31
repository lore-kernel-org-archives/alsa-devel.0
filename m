From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000557]: SNDCTL_DSP_GETOPTR not working correctly in specific situation
Date: Tue, 31 May 2005 15:54:12 +0200
Message-ID: <ef7dcb84dafe695846b76e1e862e622b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 70C1B186
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 15:54:13 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=557> 
======================================================================
Reported By:                minmax
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   557
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian unstable
Kernel Version:             vanilla 2.6.7
======================================================================
Date Submitted:             10-01-2004 16:18 CEST
Last Modified:              05-31-2005 15:54 CEST
======================================================================
Summary:                    SNDCTL_DSP_GETOPTR not working correctly in specific
situation
Description: 
When the first few writes to the oss emulation device are done in specific
way, SNDCTL_DSP_GETOPTR returns wrongly huge results in info.bytes
======================================================================

----------------------------------------------------------------------
 jdthood - 04-09-05 16:09 
----------------------------------------------------------------------
Submitter: Does this bug still exist?  Can you give more details about the
specific situation in which it appears?

----------------------------------------------------------------------
 minmax - 04-09-05 16:22 
----------------------------------------------------------------------
i've got new laptop since i reported this bug.

I've stumbled upon a bug when using Cinelerra (video editing software),
and since then i have patched the software to ignore the excessively wrong
results gotten from SNDCTL_DSP_GETOPTR

        if(!ioctl(get_output(0), SNDCTL_DSP_GETOPTR, &info))
        {
//printf("AudioOSS::device_position %d %d %d\n", info.bytes,
device->get_obits(), device->get_ochannels());
// workaround for ALSA OSS emulation driver's bug
// the problem is that if the first write to sound device was not full
lenght fragment then
// _GETOPTR returns insanely large numbers at first moments of play
                if (info.bytes > 2100000000)
                        return 0;
                else
                        return info.bytes /
                                (device->get_obits() / 8) /
                                device->get_ochannels();
        }

----------------------------------------------------------------------
 gk4 - 05-13-05 15:20 
----------------------------------------------------------------------
We are seeing the same problem for ibmtts on Fedora Core 3 using Gnome
2.10.1 & gnome-speech 0.3.6.  I would like to request increasing the
priority on this 8 month old bug because it is impacting accessibility on
Linux.

----------------------------------------------------------------------
 perex - 05-13-05 15:24 
----------------------------------------------------------------------
Can someone write a short program / test utility which triggers this bug?

----------------------------------------------------------------------
 tiwai - 05-13-05 15:26 
----------------------------------------------------------------------
Did you try the latest ALSA driver?
It's not clear which version causes this problem.

----------------------------------------------------------------------
 gk4 - 05-13-05 19:35 
----------------------------------------------------------------------
FC3 is using alsa-utils-1.0.6-3.   Have you expclicitly fixed this problem
in a particular release?

----------------------------------------------------------------------
 tiwai - 05-13-05 19:38 
----------------------------------------------------------------------
It's not the alsa-utils but ALSA drivers in kernel.
I won't be surprised if it was already fixed in ALSA 1.0.9rc3 :)

----------------------------------------------------------------------
 gk4 - 05-13-05 19:48 
----------------------------------------------------------------------
I'm running FC3 with the 2.6.10-1.766_FC3 kernel.  How can I determine
which level of ALSA the kernel is using?

----------------------------------------------------------------------
 tiwai - 05-15-05 15:50 
----------------------------------------------------------------------
Check /proc/asound/version.

----------------------------------------------------------------------
 gk4 - 05-16-05 16:08 
----------------------------------------------------------------------
My /proc/asound/version file has:

Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15
07:17:53 2004 UTC).  Compiled on Feb  9 2005 for kernel 2.6.10-1.766_FC3.

----------------------------------------------------------------------
 parente - 05-19-05 15:28 
----------------------------------------------------------------------
I'm trying to test this on FC4 test 3 with alsa driver 1.0.9rc3. grep isn't
turning up the original lines reported as causing the problem so maybe
they've been removed. Can someone point me to the file where this
problematic code was originally located?

There's still a clipping problem using alsa with gnome speech. I'd like to
see if it's being caused by this same bug.

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

----------------------------------------------------------------------
 perex - 05-27-05 10:56 
----------------------------------------------------------------------
It seems like a wrong patch to me. We cannot mix frames with bytes (see
last expression). I think that there might be an overflow in the return
expression.

----------------------------------------------------------------------
 perex - 05-27-05 11:04 
----------------------------------------------------------------------
Ok, attached fix2.patch might fix this issue properly. Could you test it?

----------------------------------------------------------------------
 parente - 05-27-05 15:41 
----------------------------------------------------------------------
perex: The fix2.patch does not work on my system. It compiles, but refuses
to be inserted into the kernel with a "symbol error." (Probably because
int64 isn't recognized on my system?)

I also tried just casting to regular "int" but that does not solve the
problem. Output from gnome-speech is still clipped.

What about the patch submitted by Roger Mach? I can compile and install
it, and it appears to correct the problem without introducing others.
Maybe the last expression computes the number of bytes properly using the
number of frames?

----------------------------------------------------------------------
 perex - 05-30-05 09:51 
----------------------------------------------------------------------
Could you try 1.0.9 final? My patch is there and compilation should be
fixed.

----------------------------------------------------------------------
 parente - 05-31-05 14:04 
----------------------------------------------------------------------
perex: I can now compile and insert the module into the kernel on my
machine.

However, the clipping problem still remains. Considering that Roger Mach's
patch works, I do not believe this is an overflow problem. Rather, the bug
seems to stem from an incorrect calculation involving bytes instead of the
desired frames.

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
05-27-05 10:56 perex          Note Added: 0004742                          
05-27-05 11:03 perex          File Added: fix2.patch                       
05-27-05 11:04 perex          Note Added: 0004743                          
05-27-05 15:41 parente        Note Added: 0004752                          
05-30-05 09:51 perex          Note Added: 0004798                          
05-31-05 14:04 parente        Note Added: 0004831                          
05-31-05 15:54 perex          Status                   new => assigned     
05-31-05 15:54 perex          Assigned To               => perex           
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
