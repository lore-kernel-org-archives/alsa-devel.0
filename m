From: Andy Alexander <andy@TheAlexanders.ws>
Subject: arecord Segmentation Fault
Date: Tue, 07 Feb 2006 22:57:35 -0500
Message-ID: <43E96C2F.5913BB69@TheAlexanders.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
I'm trying to put together an embedded Linux system out of a kernel
(2.6.14.3) uClibc and the alsa sound drivers (1.0.10rc1) and
libraries/utilities (1.0.10)

I've gotten the libraries and utils to compile.  I can successfully play
using alsamixer and aplay with no problem.

When I try to record, I can get a seg fault:  arecord -fcd -d5 x.wav
produces "Segmentation fault".

If I use "arecord -Dhw:0,0 -fcd -d5 x.wav" I can record successfully but
I get a strange message:

Recording WAVE 'x.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz)
         please, try the plug plugin (-Dplug:hw:0,0)

The driver reports a VIA8235 with a CMI9761 chip from
/proc/asound/cards.

Have I configured something wrong here?  Am I missing something under
/usr/share/alsa?

Best regards,

Andy Alexander





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
