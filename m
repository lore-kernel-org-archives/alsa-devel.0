From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Strange messages after running aplay; current CVS
Date: Thu, 1 May 2003 22:57:02 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030501215702.27094.qmail@web40601.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

$ aplay /usr/lib/sounds/jungle_exit.wav 
Playing WAVE '/usr/lib/sounds/jungle_exit.wav' :
Signed 16 bit Little Endian, Rate 22050 Hz, Stereo
ALSA lib pcm_hw.c:510:(snd_pcm_hw_drop)
SNDRV_PCM_IOCTL_DROP failed: File descriptor in bad
state
ALSA lib pcm_hw.c:347:(snd_pcm_hw_hw_free)
SNDRV_PCM_IOCTL_HW_FREE failed: File descriptor in bad
state

This is on a Linux 2.4.20-SMP machine; glibc-2.3.2.

Cheers,
Chris

__________________________________________________
Yahoo! Plus
For a better Internet experience
http://www.yahoo.co.uk/btoffer


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
