From: Dave <inssomniak@mountaincable.net>
Subject: [Fwd: iec958 controls dissapeared from alsamixer/amixer and spdif
 no longer works]
Date: Mon, 06 Feb 2006 23:09:02 -0500
Message-ID: <43E81D5E.4010501@mountaincable.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I tried this on the -user mailing list with no luck, maybe someone here 
can help me troubleshoot my problem

Recently without changing any thing regarding sound configuration on 
this one machine, the iec958 mixer controls dissapeared, and can no 
longer use the iec958/spdif port of my SI7012/alc655 chipset using the 
snd-intel8x0 driver in kernel 2.6.15 using alsa-lib/tools/headers 
1.0.11-rc2 and rc3 versions of alsa.

Analog controls are all there, and work, I try to use the spdif port and 
get:

alsa-init: 1 soundcard found, using: spdif
ALSA lib setup.c:549:(add_elem) Cannot obtain info for CTL elem 
(MIXER,'IEC958 Playback Default',0,0,0): No such file or directory


using mplayer as an example

and:

Using PCM device 'plug:iec958:{AES0 0x2 AES1 0x82 AES2 0x0 AES3 0x2}'
ALSA lib setup.c:549:(add_elem) Cannot obtain info for CTL elem 
(MIXER,'IEC958 Playback Default',0,0,0): No such file or directory
snd_pcm_open: No such file or directory
Output open failed

trying with ac3dec.


I changed nothing originally, but updated to -rc3 to try to fix it.
It all worked perfectly before some unknown force caused it to cease.





Thanks!






-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
