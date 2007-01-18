From: Robert Huitl <alsa-devel@huitl.de>
Subject: snd_pcm_status_get_avail() and external I/O plugins
Date: Thu, 18 Jan 2007 14:51:33 +0100
Message-ID: <200701181451.34160.alsa-devel@huitl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
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

Hello,

I have some trouble to get mplayer working with an external pcm I/O plugin 
(a2dp from bluez). The problem is that mplayer needs to know how much space 
is left in the ring buffer:

  snd_pcm_status(alsa_handler, status)
  ret = snd_pcm_status_get_avail(status) * bytes_per_sample;

Now with the ALSA kernel driver, ret will vary, depending on how much data was 
written to the device, and how much time passed.

However, with the I/O plugin, snd_pcm_status_get_avail() always returns the 
maximum value (causing mplayer to think that all samples have been played). I 
can't find a callback function for the status in snd_pcm_ioplug_callback_t 
where I could adjust the avail value.

I'd appreciate any hints.

Robert


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
