From: "Ryan Cassidy" <rcassidy@stanford.edu>
Subject: Writing a test jack application to determine scheduling latency
Date: Mon, 29 Dec 2003 17:28:16 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000001c3ce74$3328b5a0$264440ab@roboserv1>
Reply-To: <rcassidy@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Greetings ALSA comrades:

I would like to right a small jack playback application that
accomplishes the following:

- Accurately determines (via the IA32 TSC register, perhaps) how long it
takes after the interrupt (i.e. the audio device's PCI interrupt
signaling the need for new playback samples) for the jack process
callback to be called.  Otherwise, if this is not possible,

- Accurately determine (via the IA32 TSC register, perhaps) how many
processor cycles (or milliseconds) are available after jack's process
callback is called for transfer of playback samples until a buffer
under-run/xrun occurs.

For this task, does anyone know how to do the following:

- Instrument the audio device's PCI ISR to read a value from the IA-32
TSC register, or

(BTW, I assume that a short hardware ISR will run immediately after the
PCI interrupt occurs no matter what (i.e. even if the kernel is in a
non-preemptible section), but perhaps I am tragically wrong here)

- Figure out from within a jack process callback how many
cycles/milliseconds remain until an xrun occurs?

As I think about it, the second task is starting to sound easier than
the first.

Any assistance greatly appreciated.

Cheers, rjc.
--
Ryan J. Cassidy
Electrical Engineering Graduate Student, CCRMA Researcher
Stanford University
E-mail: ryanc@ieee.org
 




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
