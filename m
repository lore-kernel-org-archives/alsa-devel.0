From: Chris Raphael <raphael@math.umass.edu>
Subject: underrun behavior
Date: Thu, 17 Jul 2003 15:17:00 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307171917.h6HJH0T01638@fafner.math.umass.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org




Thanks to the many people who have helped with my earlier questions.

I am working on an application that simultaneously collects and plays
sound.  About 4 out of 5 times the program runs fine, but occasionally
I have a problem with the input audio and output audio drifting apart.  
This seems to happen when I get playing underruns, although not all
underruns seem to affect the synchronization.  It isn't possible for
me to completely avoid underruns, because my application can only
compute the output audio about 20 ms before it is actually played.

What I would like is for the audio driver to plays sample from the ring buffer in
a circular manner, *whether or not there is an underrun*.  That is,
if there is an underrun, I would like the driver to continue writing
samples in a circular fashion, even though some of them are garbage.
In the event of an underrun, I don't care what is played before
my application supplies the driver with audio data.  But when the
driver gets the audio I would like it to put it in the appropriate
place in the ring buffer even though some garbage samples are *substituted*
for my audio data.

Put another way,  I would like the driver to ignore underruns and simply
allow the start and end pointers to cross over one another.

Is this possible (or clear)?

Chris



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
