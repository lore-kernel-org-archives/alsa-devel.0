From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [OOPS] Alsa 0.9.4 / kernel 2.6.0-test1-mm1
Date: Mon, 21 Jul 2003 16:10:08 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307211608520.26922-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0307211547570.26922-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0307211547570.26922-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Vince <fuzzy77@free.fr>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 21 Jul 2003, Jaroslav Kysela wrote:

> On Mon, 21 Jul 2003, Vince wrote:
> 
> > Sorry, I still get the oops with the patch...
> 
> Please, change '(src_rate * 105) / 105;' expression from the patch
> to '(src_rate * 105) / 100;'...

Ok, here is also a patch which should solve the error for all cases:

Index: pcm_plugin.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/oss/pcm_plugin.c,v
retrieving revision 1.12
diff -u -r1.12 pcm_plugin.c
--- pcm_plugin.c	21 Jul 2003 13:28:27 -0000	1.12
+++ pcm_plugin.c	21 Jul 2003 14:07:42 -0000
@@ -96,6 +96,7 @@
 	c = plugin->buf_channels;
 	if (plugin->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED) {
 		for (channel = 0; channel < format->channels; channel++, c++) {
+			c->frames = frames / format->channels;
 			c->enabled = 1;
 			c->wanted = 0;
 			c->area.addr = plugin->buf;
@@ -106,6 +107,7 @@
 		snd_assert((size % format->channels) == 0,);
 		size /= format->channels;
 		for (channel = 0; channel < format->channels; channel++, c++) {
+			c->frames = frames / format->channels;
 			c->enabled = 1;
 			c->wanted = 0;
 			c->area.addr = plugin->buf + (channel * size);
Index: pcm_plugin.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/oss/pcm_plugin.h,v
retrieving revision 1.3
diff -u -r1.3 pcm_plugin.h
--- pcm_plugin.h	26 Jun 2002 02:02:49 -0000	1.3
+++ pcm_plugin.h	21 Jul 2003 14:07:42 -0000
@@ -106,6 +106,7 @@
 typedef struct _snd_pcm_plugin_channel {
 	void *aptr;			/* pointer to the allocated area */
 	snd_pcm_channel_area_t area;
+	snd_pcm_uframes_t frames;	/* allocated frames */
 	unsigned int enabled:1;		/* channel need to be processed */
 	unsigned int wanted:1;		/* channel is wanted */
 } snd_pcm_plugin_channel_t;
Index: rate.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/oss/rate.c,v
retrieving revision 1.7
diff -u -r1.7 rate.c
--- rate.c	12 Aug 2002 08:43:45 -0000	1.7
+++ rate.c	21 Jul 2003 14:07:42 -0000
@@ -318,6 +318,8 @@
 #endif
 
 	dst_frames = rate_dst_frames(plugin, frames);
+	if (dst_frames > dst_channels[0].frames)
+		dst_frames = dst_channels[0].frames;
 	data = (rate_t *)plugin->extra_data;
 	data->func(plugin, src_channels, dst_channels, frames, dst_frames);
 	return dst_frames;

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
