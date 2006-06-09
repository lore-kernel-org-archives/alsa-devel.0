From: Lee Revell <rlrevell@joe-job.com>
Subject: Problem with ALSA on PPC
Date: Fri, 09 Jun 2006 18:18:30 -0400
Message-ID: <1149891511.3894.296.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

I am developing an ALSA application for an embedded PPC platform.  I
have alsa-lib and alsa-utils installed and created the device nodes, and
am attempting to test with the dummy driver, but no matter what I do,
aplay fails to find a config.  It just returns "No such file or
directory".

~ # aplay -l
**** List of PLAYBACK Hardware Devices ****
ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
aplay: device_list:232: control open (0): No such file or directory
ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:1
aplay: device_list:232: control open (1): No such file or directory

~ # aplay -D hw:0,0 /usr/share/sounds/alsa/Front_Center.wav 
ALSA lib pcm.c:2146:(snd_pcm_open_noupdate) Unknown PCM hw:0,0
aplay: main:548: audio open error: No such file or directory

I do not have strace on this platform.  How can I determine which file
or directory is missing?

/usr/share/alsa/alsa.conf is present as well as the correct device node:

~ # ls -al /dev/snd/pcmC0D0p 
crw-rw----    1 root     29       116,  16 Jun  9 15:54 /dev/snd/pcmC0D0p

What am I doing wrong?

Lee
