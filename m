From: Werner Schweer <ws@seh.de>
Subject: tascam us-122 : invalid synch pipe
Date: Thu, 25 Sep 2003 18:06:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309251806.20116.ws@seh.de>
Reply-To: ws@seh.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello,

i'm unable to get a tascam us-122 usb audio/midi box working.
This device is supported by ALSA us428 driver.

Trying alsaplayer and MusE both return an error on setting
the pcm hw params:

ALSA lib pcm_hw.c:324:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS failed: Invalid argument

The kernel log says:
Sep 25 16:40:58 t10 vmunix: ALSA usbaudio.c:1108: 7:0:1 : invalid synch pipe

I am using current (todays) ALSA cvs and linux 2.4.23pre4.
What i'm doing wrong?

Regards,
Werner




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
