From: Michael <ad@corlett.plus.com>
Subject: [PATCH] small patch for recording in opti92x-ad1848
Date: Tue, 11 Mar 2003 20:27:46 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E6E46C2.9040200@corlett.plus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020408030908030401080005"
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

This is a multi-part message in MIME format.
--------------020408030908030401080005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

The second part of the patch adds a missing line into
snd_opti93x_capture_open to set the substream.  There
is a report on the sourceforge site from someone with
a 933 card which might also be fixed by this.

The first part just introduces a udelay(50) into
snd_opti93x_trigger when starting recording which gives
my card (931) a chance to respond.

I haven't done much testing as my card just produces
noise (but I believe this is a hardware problem).  Part two
I think is correct though, by comparison with
snd_opti93x_playback_open.

/Michael.

--------------020408030908030401080005
Content-Type: text/plain;
 name="opti92x-ad1848.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="opti92x-ad1848.patch"

--- alsa-driver-0.9.0rc8a/alsa-kernel/isa/opti9xx/opti92x-ad1848.c.orig	Tue Mar 11 20:01:19 2003
+++ alsa-driver-0.9.0rc8a/alsa-kernel/isa/opti9xx/opti92x-ad1848.c	Tue Mar 11 20:03:22 2003
@@ -987,8 +987,10 @@
 			s = s->link_next;
 		} while (s != substream);
 		spin_lock(&chip->lock);
-		if (cmd == SNDRV_PCM_TRIGGER_START)
+		if (cmd == SNDRV_PCM_TRIGGER_START) {
 			snd_opti93x_out_mask(chip, OPTi93X_IFACE_CONF, what, what);
+			if(what & OPTi93X_CAPTURE_ENABLE) udelay(50);
+		}
 		else
 			snd_opti93x_out_mask(chip, OPTi93X_IFACE_CONF, what, 0x00);
 		spin_unlock(&chip->lock);
@@ -1207,6 +1209,7 @@
 		return error;
 	runtime->hw = snd_opti93x_capture;
 	snd_pcm_set_sync(substream);
+	chip->capture_substream = substream;
 	snd_pcm_limit_isa_dma_size(chip->dma2, &runtime->hw.buffer_bytes_max);
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates);
 	return error;

--------------020408030908030401080005--



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
