From: alfonso_acosta_mail@yahoo.es
Subject: Echoaudio driver problem with Darla24
Date: Sat, 29 Mar 2003 23:06:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E8618E6.5030102@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi:

I downloaded and compiled (it worked only with gcc-2.95 due to compiler
symbols on C++ object files) last non-official-release version from
Giuliano Pochini's site:

http://space.virgilio.it/g_pochini@virgilio.it/ea.html

The module loads with difficulties (it took about 1 min, I had to unload
the video card kernel module and the cards emits a continuous weird beep
which doesnt dissapear until I reboot my PC).

When trying to play something with aplay, I get:


pcm_open  <----- from echoaudio.c pcmout_open()
ALSA ../alsa-kernel/core/pcm_native.c:1659: BUG? (err >= 0) (called from
d0c4f74a)
ALSA echoaudio.c:254: bad MAGIC (0xffffffff)
ALSA echoaudio.c:254: bad MAGIC (0xffffffff)
ALSA lib pcm-hw.c: 1078: (snd-pcm-hw-open) open /dev/snd/pcmC0D0p
failed: Invalid argument
aplay: main: 480: audio open error: Invalid argument

I have no experience programming kernel modules, but I know some C, can
anyone help me finding whats going on?

Alfonso Acosta

PS: Im using debian sid package alsa-source (alsa-driver 0.91) compiled
with detect debug level on a PC with a Darla24 sound card.




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
