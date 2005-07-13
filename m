From: Raymond <rayau@netvigator.com>
Subject: snd_hwdep_new and snd_seq_device_new
Date: Thu, 14 Jul 2005 00:25:02 +0800
Message-ID: <42D5405E.9070705@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

There are functions snd_hwdep_free() and snd_seq_device_free(), they are 
not export_symbol


EXPORT_SYMBOL(snd_hwdep_new) in hwdep.c
EXPORT_SYMBOL(snd_seq_device_new) in seq/seq_device.c


Do I need to free the (soundfont loading) hwdep device on the callback
".dev_free" of the sound card ?

Do it mean that I cannot use snd_device_new(card, SNDRV_DEV_SEQUENCER, 
wt, &ops)) to implement a customized version of snd_seq_device_free()
(put the synth code in the sound card driver) ?




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
