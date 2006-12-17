From: "Matthias Urlichs" <matthias@urlichs.de>
Subject: BROKEN: Support for non-standard rates in USB audio
	driver
Date: Sun, 17 Dec 2006 06:53:48 +0000 (UTC)
Message-ID: <em2phs$kff$1@sea.gmane.org>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I had to revert this change:

commit a79eee8d3d8a80c37d235e1181d67c3705c7bbfe
Author: Luke Ross <luke@lukeross.name>
Date:   Tue Aug 29 10:46:32 2006 +0200

    [ALSA] Support for non-standard rates in USB audio driver

    There's at least one USB audio chipset out there which supports only one
    non-standard rate (ID 0e6a:0310 supports 46875Hz). There's a few other
    patches for this card which are unsatisfactory because they attempt to
    map this rate to 44.1k leading to sound distortion.
    The patch below uses SNDRV_PCM_RATE_KNOT to properly support the
    non-standard rates where they are available.

    Signed-off-by: Luke Ross <luke@lukeross.name>
    Signed-off-by: Takashi Iwai <tiwai@suse.de>
    Signed-off-by: Jaroslav Kysela <perex@suse.cz>

:100644 100644 087f9b6... 664dd4c... M  sound/usb/usbaudio.c


... because it caused this crash in snd_interval_list:

 EIP:    0060:[<f0a30916>]    Not tainted VLI
 EFLAGS: 00010202   (2.6.18-1.33 #10)
  [<f0a326a4>] snd_pcm_hw_rule_list+0x22/0x29 [snd_pcm]
  [<f0a2e8d2>] snd_pcm_hw_refine+0x260/0x3b5 [snd_pcm]
  [<f0a2ee0d>] snd_pcm_hw_refine_user+0x42/0x6e [snd_pcm]
  [<f0a2efca>] snd_pcm_common_ioctl1+0x191/0xf90 [snd_pcm]
  [<f0a30137>] snd_pcm_capture_ioctl1+0x36e/0x385 [snd_pcm]
  [<f0a30175>] snd_pcm_capture_ioctl+0x27/0x34 [snd_pcm]
  [<b0165236>] do_ioctl+0x22/0x67
  [<b01654d3>] vfs_ioctl+0x258/0x26b
  [<b016552d>] sys_ioctl+0x47/0x62
  [<b0102aad>] sysenter_past_esp+0x56/0x8d

Since I know next to nothing about this code: any ideas where to dig
deeper are appreciated.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
clairvoyant, n.:
	A person, commonly a woman, who has the power of seeing that
	which is invisible to her patron -- namely, that he is a blockhead.
		-- Ambrose Bierce, "The Devil's Dictionary"


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
