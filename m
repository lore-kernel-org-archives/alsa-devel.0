From: patrick <bizshort@earthlink.net>
Subject: File descriptor in bad state
Date: Tue, 15 Jul 2003 15:25:23 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F146333.B92DC39B@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

alsa: 0.9.3
card: hammerfall
kernel: 2.4.18

FWIW, i'm getting this message after aplay finishes playing a WAV file.  sound is fine
though.

$ aplay file.wav 
Playing WAVE 'file.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
.
.
file plays fine
.
.
ALSA lib pcm_hw.c:510:(snd_pcm_hw_drop) SNDRV_PCM_IOCTL_DROP failed: File descriptor in
bad state
ALSA lib pcm_hw.c:347:(snd_pcm_hw_hw_free) SNDRV_PCM_IOCTL_HW_FREE failed: File descriptor
in bad state

patrick


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
