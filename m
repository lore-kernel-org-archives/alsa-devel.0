From: Arnaud de Bossoreille de Ribou <arnaud.debossoreille@via.ecp.fr>
Subject: emu10k1 bug and patch (0.9.0rc7)
Date: Mon, 10 Feb 2003 18:21:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030210172112.GA12226@via.ecp.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Resent-To: alsa-devel@lists.sourceforge.net
Resent-Message-Id: <20030213105609.711593AD28@zen.via.ecp.fr>
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


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, I discovered a bug in the emu10k1 driver which I'll explain here:

I was developing an application which uses the timestamps given in the
status of the device to send S/PDIF data to it. This app worked pretty
well except that sometimes I heard sound discontinuities and then a
constant time delay between the sound and the video.

I finally found where was the problem, my results is based on the
emu10k1-debug.patch file attached. The "frame" argument is equal to 0
when the app gets the status of the device. With this patch applied I
saw some output on the console exactly at the same time the bug occured.
Adding a "else" after the "if" to prevent sw_ready from being updated
fixed the problem and the output looked like

----------------
plop 0 -1536 A B
plop 0 1536 B A
----------------

where B == A - 1536 (1536 is the period_size). These two lines were
repeated a few times during playback.

So the bug looks like a signedness problem since sw_ready is unsigned
and there is a while(sw_ready > 0), which explain the constant delay,
next in the "snd_emu10k1_fx8010_playback_transfer" function.

So the emu10k1.patch file attached fixes the problem and seems not to
introduce new ones.

Note: patches were made with the 0.9.0rc7 version of the alsa-driver
package.

Regards,

-- 
Arnaud.

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="emu10k1-debug.patch"

--- alsa-kernel/pci/emu10k1/emufx.c.orig	2003-02-08 23:02:50.000000000 +0100
+++ alsa-kernel/pci/emu10k1/emufx.c	2003-02-08 23:17:09.000000000 +0100
@@ -531,6 +531,11 @@
 	if (diff) {
 		if (diff < -(snd_pcm_sframes_t) (runtime->boundary / 2))
 			diff += runtime->boundary;
+		if(frames == 0)
+		{
+			printk("plop %d %ld (%lu %u)\n",
+				pcm->sw_ready, diff, appl_ptr, pcm->appl_ptr);
+		}
 		pcm->sw_ready += diff;
 	}
 	pcm->sw_ready += frames;

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="emu10k1.patch"

--- alsa-kernel/include/emu10k1.h.orig	2003-02-08 23:00:43.000000000 +0100
+++ alsa-kernel/include/emu10k1.h	2003-02-08 23:02:02.000000000 +0100
@@ -879,7 +879,8 @@
 	unsigned char etram[32];	/* external TRAM address & data */
 	unsigned int sw_data, hw_data;
 	unsigned int sw_io, hw_io;
-	unsigned int sw_ready, hw_ready;
+	int sw_ready;
+	unsigned int hw_ready;
 	unsigned int appl_ptr;
 	unsigned int tram_pos;
 	unsigned int tram_shift;

--vkogqOf2sHV7VnPd--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
