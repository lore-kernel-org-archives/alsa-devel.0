From: Art Haas <ahaas@airmail.net>
Subject: [PATCH] Replace obsolete GCC initializers in alsa-lib [1/3]
Date: Thu, 17 Jul 2003 07:45:34 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030717124356.GC3788@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi.

This is the first of three patches.

Index: alsa-lib/aserver/aserver.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/aserver/aserver.c,v
retrieving revision 1.56
diff -u -u -r1.56 aserver.c
--- alsa-lib/aserver/aserver.c	18 Mar 2003 18:00:05 -0000	1.56
+++ alsa-lib/aserver/aserver.c	16 Jul 2003 15:21:03 -0000
@@ -518,9 +518,9 @@
 }
 
 transport_ops_t pcm_shm_ops = {
-	open: pcm_shm_open,
-	cmd: pcm_shm_cmd,
-	close: pcm_shm_close,
+	.open		= pcm_shm_open,
+	.cmd		= pcm_shm_cmd,
+	.close		= pcm_shm_close,
 };
 
 static int ctl_handler(waiter_t *waiter, unsigned short events)
@@ -712,9 +712,9 @@
 }
 
 transport_ops_t ctl_shm_ops = {
-	open: ctl_shm_open,
-	cmd: ctl_shm_cmd,
-	close: ctl_shm_close,
+	.open		= ctl_shm_open,
+	.cmd		= ctl_shm_cmd,
+	.close		= ctl_shm_close,
 };
 
 static int snd_client_open(client_t *client)
Index: alsa-lib/src/input.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/input.c,v
retrieving revision 1.17
diff -u -u -r1.17 input.c
--- alsa-lib/src/input.c	23 Jul 2002 19:51:17 -0000	1.17
+++ alsa-lib/src/input.c	16 Jul 2003 15:21:11 -0000
@@ -158,11 +158,11 @@
 }
 
 static snd_input_ops_t snd_input_stdio_ops = {
-	close: snd_input_stdio_close,
-	scan: snd_input_stdio_scan,
-	gets: snd_input_stdio_gets,
-	getch: snd_input_stdio_getc,
-	ungetch: snd_input_stdio_ungetc,
+	.close		= snd_input_stdio_close,
+	.scan		= snd_input_stdio_scan,
+	.gets		= snd_input_stdio_gets,
+	.getch		= snd_input_stdio_getc,
+	.ungetch	= snd_input_stdio_ungetc,
 };
 #endif
 
@@ -284,11 +284,11 @@
 }
 
 static snd_input_ops_t snd_input_buffer_ops = {
-	close: snd_input_buffer_close,
-	scan: snd_input_buffer_scan,
-	gets: snd_input_buffer_gets,
-	getch: snd_input_buffer_getc,
-	ungetch: snd_input_buffer_ungetc,
+	.close		= snd_input_buffer_close,
+	.scan		= snd_input_buffer_scan,
+	.gets		= snd_input_buffer_gets,
+	.getch		= snd_input_buffer_getc,
+	.ungetch	= snd_input_buffer_ungetc,
 };
 #endif
 
Index: alsa-lib/src/output.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/output.c,v
retrieving revision 1.18
diff -u -u -r1.18 output.c
--- alsa-lib/src/output.c	24 Jun 2003 19:30:09 -0000	1.18
+++ alsa-lib/src/output.c	16 Jul 2003 15:21:11 -0000
@@ -166,11 +166,11 @@
 }
 
 static snd_output_ops_t snd_output_stdio_ops = {
-	close: snd_output_stdio_close,
-	print: snd_output_stdio_print,
-	puts: snd_output_stdio_puts,
-	putch: snd_output_stdio_putc,
-	flush: snd_output_stdio_flush,
+	.close		= snd_output_stdio_close,
+	.print		= snd_output_stdio_print,
+	.puts		= snd_output_stdio_puts,
+	.putch		= snd_output_stdio_putc,
+	.flush		= snd_output_stdio_flush,
 };
 
 #endif
@@ -318,11 +318,11 @@
 }
 
 static snd_output_ops_t snd_output_buffer_ops = {
-	close: snd_output_buffer_close,
-	print: snd_output_buffer_print,
-	puts: snd_output_buffer_puts,
-	putch: snd_output_buffer_putc,
-	flush: snd_output_buffer_flush,
+	.close		= snd_output_buffer_close,
+	.print		= snd_output_buffer_print,
+	.puts		= snd_output_buffer_puts,
+	.putch		= snd_output_buffer_putc,
+	.flush		= snd_output_buffer_flush,
 };
 #endif
 
Index: alsa-lib/src/control/control_hw.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/control/control_hw.c,v
retrieving revision 1.37
diff -u -u -r1.37 control_hw.c
--- alsa-lib/src/control/control_hw.c	1 Apr 2003 13:58:12 -0000	1.37
+++ alsa-lib/src/control/control_hw.c	16 Jul 2003 15:21:17 -0000
@@ -265,28 +265,28 @@
 }
 
 snd_ctl_ops_t snd_ctl_hw_ops = {
-	close: snd_ctl_hw_close,
-	nonblock: snd_ctl_hw_nonblock,
-	async: snd_ctl_hw_async,
-	subscribe_events: snd_ctl_hw_subscribe_events,
-	card_info: snd_ctl_hw_card_info,
-	element_list: snd_ctl_hw_elem_list,
-	element_info: snd_ctl_hw_elem_info,
-	element_read: snd_ctl_hw_elem_read,
-	element_write: snd_ctl_hw_elem_write,
-	element_lock: snd_ctl_hw_elem_lock,
-	element_unlock: snd_ctl_hw_elem_unlock,
-	hwdep_next_device: snd_ctl_hw_hwdep_next_device,
-	hwdep_info: snd_ctl_hw_hwdep_info,
-	pcm_next_device: snd_ctl_hw_pcm_next_device,
-	pcm_info: snd_ctl_hw_pcm_info,
-	pcm_prefer_subdevice: snd_ctl_hw_pcm_prefer_subdevice,
-	rawmidi_next_device: snd_ctl_hw_rawmidi_next_device,
-	rawmidi_info: snd_ctl_hw_rawmidi_info,
-	rawmidi_prefer_subdevice: snd_ctl_hw_rawmidi_prefer_subdevice,
-	set_power_state: snd_ctl_hw_set_power_state,
-	get_power_state: snd_ctl_hw_get_power_state,
-	read: snd_ctl_hw_read,
+	.close			= snd_ctl_hw_close,
+	.nonblock		= snd_ctl_hw_nonblock,
+	.async			= snd_ctl_hw_async,
+	.subscribe_events	= snd_ctl_hw_subscribe_events,
+	.card_info		= snd_ctl_hw_card_info,
+	.element_list		= snd_ctl_hw_elem_list,
+	.element_info		= snd_ctl_hw_elem_info,
+	.element_read		= snd_ctl_hw_elem_read,
+	.element_write		= snd_ctl_hw_elem_write,
+	.element_lock		= snd_ctl_hw_elem_lock,
+	.element_unlock		= snd_ctl_hw_elem_unlock,
+	.hwdep_next_device	= snd_ctl_hw_hwdep_next_device,
+	.hwdep_info		= snd_ctl_hw_hwdep_info,
+	.pcm_next_device	= snd_ctl_hw_pcm_next_device,
+	.pcm_info		= snd_ctl_hw_pcm_info,
+	.pcm_prefer_subdevice	= snd_ctl_hw_pcm_prefer_subdevice,
+	.rawmidi_next_device	= snd_ctl_hw_rawmidi_next_device,
+	.rawmidi_info		= snd_ctl_hw_rawmidi_info,
+	.rawmidi_prefer_subdevice	= snd_ctl_hw_rawmidi_prefer_subdevice,
+	.set_power_state	= snd_ctl_hw_set_power_state,
+	.get_power_state	= snd_ctl_hw_get_power_state,
+	.read			= snd_ctl_hw_read,
 };
 
 int snd_ctl_hw_open(snd_ctl_t **handle, const char *name, int card, int mode)
Index: alsa-lib/src/control/control_shm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/control/control_shm.c,v
retrieving revision 1.36
diff -u -u -r1.36 control_shm.c
--- alsa-lib/src/control/control_shm.c	5 May 2003 14:24:11 -0000	1.36
+++ alsa-lib/src/control/control_shm.c	16 Jul 2003 15:21:17 -0000
@@ -396,28 +396,28 @@
 }
 
 snd_ctl_ops_t snd_ctl_shm_ops = {
-	close: snd_ctl_shm_close,
-	nonblock: snd_ctl_shm_nonblock,
-	async: snd_ctl_shm_async,
-	subscribe_events: snd_ctl_shm_subscribe_events,
-	card_info: snd_ctl_shm_card_info,
-	element_list: snd_ctl_shm_elem_list,
-	element_info: snd_ctl_shm_elem_info,
-	element_read: snd_ctl_shm_elem_read,
-	element_write: snd_ctl_shm_elem_write,
-	element_lock: snd_ctl_shm_elem_lock,
-	element_unlock: snd_ctl_shm_elem_unlock,
-	hwdep_next_device: snd_ctl_shm_hwdep_next_device,
-	hwdep_info: snd_ctl_shm_hwdep_info,
-	pcm_next_device: snd_ctl_shm_pcm_next_device,
-	pcm_info: snd_ctl_shm_pcm_info,
-	pcm_prefer_subdevice: snd_ctl_shm_pcm_prefer_subdevice,
-	rawmidi_next_device: snd_ctl_shm_rawmidi_next_device,
-	rawmidi_info: snd_ctl_shm_rawmidi_info,
-	rawmidi_prefer_subdevice: snd_ctl_shm_rawmidi_prefer_subdevice,
-	set_power_state: snd_ctl_shm_set_power_state,
-	get_power_state: snd_ctl_shm_get_power_state,
-	read: snd_ctl_shm_read,
+	.close			= snd_ctl_shm_close,
+	.nonblock		= snd_ctl_shm_nonblock,
+	.async			= snd_ctl_shm_async,
+	.subscribe_events	= snd_ctl_shm_subscribe_events,
+	.card_info		= snd_ctl_shm_card_info,
+	.element_list		= snd_ctl_shm_elem_list,
+	.element_info		= snd_ctl_shm_elem_info,
+	.element_read		= snd_ctl_shm_elem_read,
+	.element_write		= snd_ctl_shm_elem_write,
+	.element_lock		= snd_ctl_shm_elem_lock,
+	.element_unlock		= snd_ctl_shm_elem_unlock,
+	.hwdep_next_device	= snd_ctl_shm_hwdep_next_device,
+	.hwdep_info		= snd_ctl_shm_hwdep_info,
+	.pcm_next_device	= snd_ctl_shm_pcm_next_device,
+	.pcm_info		= snd_ctl_shm_pcm_info,
+	.pcm_prefer_subdevice	= snd_ctl_shm_pcm_prefer_subdevice,
+	.rawmidi_next_device	= snd_ctl_shm_rawmidi_next_device,
+	.rawmidi_info		= snd_ctl_shm_rawmidi_info,
+	.rawmidi_prefer_subdevice	= snd_ctl_shm_rawmidi_prefer_subdevice,
+	.set_power_state	= snd_ctl_shm_set_power_state,
+	.get_power_state	= snd_ctl_shm_get_power_state,
+	.read			= snd_ctl_shm_read,
 };
 
 static int make_local_socket(const char *filename)
Index: alsa-lib/src/hwdep/hwdep_hw.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/hwdep/hwdep_hw.c,v
retrieving revision 1.9
diff -u -u -r1.9 hwdep_hw.c
--- alsa-lib/src/hwdep/hwdep_hw.c	25 Feb 2003 12:45:45 -0000	1.9
+++ alsa-lib/src/hwdep/hwdep_hw.c	16 Jul 2003 15:21:17 -0000
@@ -95,12 +95,12 @@
 }
 
 static snd_hwdep_ops_t snd_hwdep_hw_ops = {
-	close: snd_hwdep_hw_close,
-	nonblock: snd_hwdep_hw_nonblock,
-	info: snd_hwdep_hw_info,
-	ioctl: snd_hwdep_hw_ioctl,
-	write: snd_hwdep_hw_write,
-	read: snd_hwdep_hw_read,
+	.close 		= snd_hwdep_hw_close,
+	.nonblock 	= snd_hwdep_hw_nonblock,
+	.info 		= snd_hwdep_hw_info,
+	.ioctl 		= snd_hwdep_hw_ioctl,
+	.write 		= snd_hwdep_hw_write,
+	.read 		= snd_hwdep_hw_read,
 };
 
 int snd_hwdep_hw_open(snd_hwdep_t **handle, const char *name, int card, int device, int mode)
Index: alsa-lib/src/pcm/pcm_adpcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_adpcm.c,v
retrieving revision 1.58
diff -u -u -r1.58 pcm_adpcm.c
--- alsa-lib/src/pcm/pcm_adpcm.c	11 Feb 2003 18:14:45 -0000	1.58
+++ alsa-lib/src/pcm/pcm_adpcm.c	16 Jul 2003 15:21:17 -0000
@@ -517,19 +517,19 @@
 }
 
 static snd_pcm_ops_t snd_pcm_adpcm_ops = {
-	close: snd_pcm_plugin_close,
-	info: snd_pcm_plugin_info,
-	hw_refine: snd_pcm_adpcm_hw_refine,
-	hw_params: snd_pcm_adpcm_hw_params,
-	hw_free: snd_pcm_adpcm_hw_free,
-	sw_params: snd_pcm_plugin_sw_params,
-	channel_info: snd_pcm_plugin_channel_info,
-	dump: snd_pcm_adpcm_dump,
-	nonblock: snd_pcm_plugin_nonblock,
-	async: snd_pcm_plugin_async,
-	poll_revents: snd_pcm_plugin_poll_revents,
-	mmap: snd_pcm_plugin_mmap,
-	munmap: snd_pcm_plugin_munmap,
+	.close		= snd_pcm_plugin_close,
+	.info		= snd_pcm_plugin_info,
+	.hw_refine	= snd_pcm_adpcm_hw_refine,
+	.hw_params	= snd_pcm_adpcm_hw_params,
+	.hw_free	= snd_pcm_adpcm_hw_free,
+	.sw_params	= snd_pcm_plugin_sw_params,
+	.channel_info	= snd_pcm_plugin_channel_info,
+	.dump		= snd_pcm_adpcm_dump,
+	.nonblock	= snd_pcm_plugin_nonblock,
+	.async		= snd_pcm_plugin_async,
+	.poll_revents	= snd_pcm_plugin_poll_revents,
+	.mmap		= snd_pcm_plugin_mmap,
+	.munmap		= snd_pcm_plugin_munmap,
 };
 
 /**
Index: alsa-lib/src/pcm/pcm_alaw.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_alaw.c,v
retrieving revision 1.56
diff -u -u -r1.56 pcm_alaw.c
--- alsa-lib/src/pcm/pcm_alaw.c	11 Feb 2003 18:14:45 -0000	1.56
+++ alsa-lib/src/pcm/pcm_alaw.c	16 Jul 2003 15:21:17 -0000
@@ -390,19 +390,18 @@
 }
 
 static snd_pcm_ops_t snd_pcm_alaw_ops = {
-	close: snd_pcm_plugin_close,
-	info: snd_pcm_plugin_info,
-	hw_refine: snd_pcm_alaw_hw_refine,
-	hw_params: snd_pcm_alaw_hw_params,
-	hw_free: snd_pcm_plugin_hw_free,
-	sw_params: snd_pcm_plugin_sw_params,
-	channel_info: snd_pcm_plugin_channel_info,
-	dump: snd_pcm_alaw_dump,
-	nonblock: snd_pcm_plugin_nonblock,
-	async: snd_pcm_plugin_async,
-	poll_revents: snd_pcm_plugin_poll_revents,
-	mmap: snd_pcm_plugin_mmap,
-	munmap: snd_pcm_plugin_munmap,
+	.close 		= snd_pcm_plugin_close,
+	.info 		= snd_pcm_plugin_info,
+	.hw_refine 	= snd_pcm_alaw_hw_refine,
+	.hw_params 	= snd_pcm_alaw_hw_params,
+	.hw_free 	= snd_pcm_plugin_hw_free,
+	.sw_params 	= snd_pcm_plugin_sw_params,
+	.channel_info 	= snd_pcm_plugin_channel_info,
+	.dump 		= snd_pcm_alaw_dump,
+	.nonblock 	= snd_pcm_plugin_nonblock,
+	.async 		= snd_pcm_plugin_async,
+	.mmap 		= snd_pcm_plugin_mmap,
+	.munmap 	= snd_pcm_plugin_munmap,
 };
 
 /**
Index: alsa-lib/src/pcm/pcm_copy.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_copy.c,v
retrieving revision 1.36
diff -u -u -r1.36 pcm_copy.c
--- alsa-lib/src/pcm/pcm_copy.c	11 Feb 2003 18:14:46 -0000	1.36
+++ alsa-lib/src/pcm/pcm_copy.c	16 Jul 2003 15:21:17 -0000
@@ -153,19 +153,18 @@
 }
 
 static snd_pcm_ops_t snd_pcm_copy_ops = {
-	close: snd_pcm_plugin_close,
-	info: snd_pcm_plugin_info,
-	hw_refine: snd_pcm_copy_hw_refine,
-	hw_params: snd_pcm_copy_hw_params,
-	hw_free: snd_pcm_plugin_hw_free,
-	sw_params: snd_pcm_plugin_sw_params,
-	channel_info: snd_pcm_plugin_channel_info,
-	dump: snd_pcm_copy_dump,
-	nonblock: snd_pcm_plugin_nonblock,
-	async: snd_pcm_plugin_async,
-	poll_revents: snd_pcm_plugin_poll_revents,
-	mmap: snd_pcm_plugin_mmap,
-	munmap: snd_pcm_plugin_munmap,
+	.close 		= snd_pcm_plugin_close,
+	.info 		= snd_pcm_plugin_info,
+	.hw_refine 	= snd_pcm_copy_hw_refine,
+	.hw_params 	= snd_pcm_copy_hw_params,
+	.hw_free 	= snd_pcm_plugin_hw_free,
+	.sw_params 	= snd_pcm_plugin_sw_params,
+	.channel_info 	= snd_pcm_plugin_channel_info,
+	.dump 		= snd_pcm_copy_dump,
+	.nonblock 	= snd_pcm_plugin_nonblock,
+	.async 		= snd_pcm_plugin_async,
+	.mmap 		= snd_pcm_plugin_mmap,
+	.munmap 	= snd_pcm_plugin_munmap,
 };
 
 /**
Index: alsa-lib/src/pcm/pcm_dmix.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_dmix.c,v
retrieving revision 1.38
diff -u -u -r1.38 pcm_dmix.c
--- alsa-lib/src/pcm/pcm_dmix.c	1 Jul 2003 09:24:30 -0000	1.38
+++ alsa-lib/src/pcm/pcm_dmix.c	16 Jul 2003 15:21:17 -0000
@@ -832,41 +832,41 @@
 }
 
 static snd_pcm_ops_t snd_pcm_dmix_ops = {
-	close: snd_pcm_dmix_close,
-	info: snd_pcm_dmix_info,
-	hw_refine: snd_pcm_dmix_hw_refine,
-	hw_params: snd_pcm_dmix_hw_params,
-	hw_free: snd_pcm_dmix_hw_free,
-	sw_params: snd_pcm_dmix_sw_params,
-	channel_info: snd_pcm_dmix_channel_info,
-	dump: snd_pcm_dmix_dump,
-	nonblock: snd_pcm_dmix_nonblock,
-	async: snd_pcm_dmix_async,
-	poll_revents: snd_pcm_dmix_poll_revents,
-	mmap: snd_pcm_dmix_mmap,
-	munmap: snd_pcm_dmix_munmap,
+	.close		= snd_pcm_dmix_close,
+	.info		= snd_pcm_dmix_info,
+	.hw_refine	= snd_pcm_dmix_hw_refine,
+	.hw_params	= snd_pcm_dmix_hw_params,
+	.hw_free	= snd_pcm_dmix_hw_free,
+	.sw_params	= snd_pcm_dmix_sw_params,
+	.channel_info	= snd_pcm_dmix_channel_info,
+	.dump		= snd_pcm_dmix_dump,
+	.nonblock	= snd_pcm_dmix_nonblock,
+	.async		= snd_pcm_dmix_async,
+	.poll_revents	= snd_pcm_dmix_poll_revents,
+	.mmap		= snd_pcm_dmix_mmap,
+	.munmap		= snd_pcm_dmix_munmap,
 };
 
 static snd_pcm_fast_ops_t snd_pcm_dmix_fast_ops = {
-	status: snd_pcm_dmix_status,
-	state: snd_pcm_dmix_state,
-	hwsync: snd_pcm_dmix_hwsync,
-	delay: snd_pcm_dmix_delay,
-	prepare: snd_pcm_dmix_prepare,
-	reset: snd_pcm_dmix_reset,
-	start: snd_pcm_dmix_start,
-	drop: snd_pcm_dmix_drop,
-	drain: snd_pcm_dmix_drain,
-	pause: snd_pcm_dmix_pause,
-	rewind: snd_pcm_dmix_rewind,
-	forward: snd_pcm_dmix_forward,
-	resume: snd_pcm_dmix_resume,
-	writei: snd_pcm_mmap_writei,
-	writen: snd_pcm_mmap_writen,
-	readi: snd_pcm_dmix_readi,
-	readn: snd_pcm_dmix_readn,
-	avail_update: snd_pcm_dmix_avail_update,
-	mmap_commit: snd_pcm_dmix_mmap_commit,
+	.status		= snd_pcm_dmix_status,
+	.state		= snd_pcm_dmix_state,
+	.hwsync		= snd_pcm_dmix_hwsync,
+	.delay		= snd_pcm_dmix_delay,
+	.prepare	= snd_pcm_dmix_prepare,
+	.reset		= snd_pcm_dmix_reset,
+	.start		= snd_pcm_dmix_start,
+	.drop		= snd_pcm_dmix_drop,
+	.drain		= snd_pcm_dmix_drain,
+	.pause		= snd_pcm_dmix_pause,
+	.rewind		= snd_pcm_dmix_rewind,
+	.forward	= snd_pcm_dmix_forward,
+	.resume		= snd_pcm_dmix_resume,
+	.writei		= snd_pcm_mmap_writei,
+	.writen		= snd_pcm_mmap_writen,
+	.readi		= snd_pcm_dmix_readi,
+	.readn		= snd_pcm_dmix_readn,
+	.avail_update	= snd_pcm_dmix_avail_update,
+	.mmap_commit	= snd_pcm_dmix_mmap_commit,
 };
 
 /**
Index: alsa-lib/src/pcm/pcm_dshare.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_dshare.c,v
retrieving revision 1.5
diff -u -u -r1.5 pcm_dshare.c
--- alsa-lib/src/pcm/pcm_dshare.c	1 Jul 2003 09:24:30 -0000	1.5
+++ alsa-lib/src/pcm/pcm_dshare.c	16 Jul 2003 15:21:17 -0000
@@ -622,41 +622,41 @@
 }
 
 static snd_pcm_ops_t snd_pcm_dshare_ops = {
-	close: snd_pcm_dshare_close,
-	info: snd_pcm_dshare_info,
-	hw_refine: snd_pcm_dshare_hw_refine,
-	hw_params: snd_pcm_dshare_hw_params,
-	hw_free: snd_pcm_dshare_hw_free,
-	sw_params: snd_pcm_dshare_sw_params,
-	channel_info: snd_pcm_dshare_channel_info,
-	dump: snd_pcm_dshare_dump,
-	nonblock: snd_pcm_dshare_nonblock,
-	async: snd_pcm_dshare_async,
-	poll_revents: snd_pcm_dshare_poll_revents,
-	mmap: snd_pcm_dshare_mmap,
-	munmap: snd_pcm_dshare_munmap,
+	.close		= snd_pcm_dshare_close,
+	.info		= snd_pcm_dshare_info,
+	.hw_refine	= snd_pcm_dshare_hw_refine,
+	.hw_params	= snd_pcm_dshare_hw_params,
+	.hw_free	= snd_pcm_dshare_hw_free,
+	.sw_params	= snd_pcm_dshare_sw_params,
+	.channel_info	= snd_pcm_dshare_channel_info,
+	.dump		= snd_pcm_dshare_dump,
+	.nonblock	= snd_pcm_dshare_nonblock,
+	.async		= snd_pcm_dshare_async,
+	.poll_revents	= snd_pcm_dshare_poll_revents,
+	.mmap		= snd_pcm_dshare_mmap,
+	.munmap		= snd_pcm_dshare_munmap,
 };
 
 static snd_pcm_fast_ops_t snd_pcm_dshare_fast_ops = {
-	status: snd_pcm_dshare_status,
-	state: snd_pcm_dshare_state,
-	hwsync: snd_pcm_dshare_hwsync,
-	delay: snd_pcm_dshare_delay,
-	prepare: snd_pcm_dshare_prepare,
-	reset: snd_pcm_dshare_reset,
-	start: snd_pcm_dshare_start,
-	drop: snd_pcm_dshare_drop,
-	drain: snd_pcm_dshare_drain,
-	pause: snd_pcm_dshare_pause,
-	rewind: snd_pcm_dshare_rewind,
-	forward: snd_pcm_dshare_forward,
-	resume: snd_pcm_dshare_resume,
-	writei: snd_pcm_mmap_writei,
-	writen: snd_pcm_mmap_writen,
-	readi: snd_pcm_dshare_readi,
-	readn: snd_pcm_dshare_readn,
-	avail_update: snd_pcm_dshare_avail_update,
-	mmap_commit: snd_pcm_dshare_mmap_commit,
+	.status		= snd_pcm_dshare_status,
+	.state		= snd_pcm_dshare_state,
+	.hwsync		= snd_pcm_dshare_hwsync,
+	.delay		= snd_pcm_dshare_delay,
+	.prepare	= snd_pcm_dshare_prepare,
+	.reset		= snd_pcm_dshare_reset,
+	.start		= snd_pcm_dshare_start,
+	.drop		= snd_pcm_dshare_drop,
+	.drain		= snd_pcm_dshare_drain,
+	.pause		= snd_pcm_dshare_pause,
+	.rewind		= snd_pcm_dshare_rewind,
+	.forward	= snd_pcm_dshare_forward,
+	.resume		= snd_pcm_dshare_resume,
+	.writei		= snd_pcm_mmap_writei,
+	.writen		= snd_pcm_mmap_writen,
+	.readi		= snd_pcm_dshare_readi,
+	.readn		= snd_pcm_dshare_readn,
+	.avail_update	= snd_pcm_dshare_avail_update,
+	.mmap_commit	= snd_pcm_dshare_mmap_commit,
 };
 
 /**
Index: alsa-lib/src/pcm/pcm_dsnoop.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_dsnoop.c,v
retrieving revision 1.5
diff -u -u -r1.5 pcm_dsnoop.c
--- alsa-lib/src/pcm/pcm_dsnoop.c	1 Jul 2003 09:24:30 -0000	1.5
+++ alsa-lib/src/pcm/pcm_dsnoop.c	16 Jul 2003 15:21:17 -0000
@@ -590,41 +590,41 @@
 }
 
 static snd_pcm_ops_t snd_pcm_dsnoop_ops = {
-	close: snd_pcm_dsnoop_close,
-	info: snd_pcm_dsnoop_info,
-	hw_refine: snd_pcm_dsnoop_hw_refine,
-	hw_params: snd_pcm_dsnoop_hw_params,
-	hw_free: snd_pcm_dsnoop_hw_free,
-	sw_params: snd_pcm_dsnoop_sw_params,
-	channel_info: snd_pcm_dsnoop_channel_info,
-	dump: snd_pcm_dsnoop_dump,
-	nonblock: snd_pcm_dsnoop_nonblock,
-	async: snd_pcm_dsnoop_async,
-	poll_revents: snd_pcm_dsnoop_poll_revents,
-	mmap: snd_pcm_dsnoop_mmap,
-	munmap: snd_pcm_dsnoop_munmap,
+	.close		= snd_pcm_dsnoop_close,
+	.info		= snd_pcm_dsnoop_info,
+	.hw_refine	= snd_pcm_dsnoop_hw_refine,
+	.hw_params	= snd_pcm_dsnoop_hw_params,
+	.hw_free	= snd_pcm_dsnoop_hw_free,
+	.sw_params	= snd_pcm_dsnoop_sw_params,
+	.channel_info	= snd_pcm_dsnoop_channel_info,
+	.dump		= snd_pcm_dsnoop_dump,
+	.nonblock	= snd_pcm_dsnoop_nonblock,
+	.async		= snd_pcm_dsnoop_async,
+	.poll_revents	= snd_pcm_dsnoop_poll_revents,
+	.mmap		= snd_pcm_dsnoop_mmap,
+	.munmap		= snd_pcm_dsnoop_munmap,
 };
 
 static snd_pcm_fast_ops_t snd_pcm_dsnoop_fast_ops = {
-	status: snd_pcm_dsnoop_status,
-	state: snd_pcm_dsnoop_state,
-	hwsync: snd_pcm_dsnoop_hwsync,
-	delay: snd_pcm_dsnoop_delay,
-	prepare: snd_pcm_dsnoop_prepare,
-	reset: snd_pcm_dsnoop_reset,
-	start: snd_pcm_dsnoop_start,
-	drop: snd_pcm_dsnoop_drop,
-	drain: snd_pcm_dsnoop_drain,
-	pause: snd_pcm_dsnoop_pause,
-	rewind: snd_pcm_dsnoop_rewind,
-	forward: snd_pcm_dsnoop_forward,
-	resume: snd_pcm_dsnoop_resume,
-	writei: snd_pcm_dsnoop_writei,
-	writen: snd_pcm_dsnoop_writen,
-	readi: snd_pcm_mmap_readi,
-	readn: snd_pcm_mmap_readn,
-	avail_update: snd_pcm_dsnoop_avail_update,
-	mmap_commit: snd_pcm_dsnoop_mmap_commit,
+	.status		= snd_pcm_dsnoop_status,
+	.state		= snd_pcm_dsnoop_state,
+	.hwsync		= snd_pcm_dsnoop_hwsync,
+	.delay		= snd_pcm_dsnoop_delay,
+	.prepare	= snd_pcm_dsnoop_prepare,
+	.reset		= snd_pcm_dsnoop_reset,
+	.start		= snd_pcm_dsnoop_start,
+	.drop		= snd_pcm_dsnoop_drop,
+	.drain		= snd_pcm_dsnoop_drain,
+	.pause		= snd_pcm_dsnoop_pause,
+	.rewind		= snd_pcm_dsnoop_rewind,
+	.forward	= snd_pcm_dsnoop_forward,
+	.resume		= snd_pcm_dsnoop_resume,
+	.writei		= snd_pcm_dsnoop_writei,
+	.writen		= snd_pcm_dsnoop_writen,
+	.readi		= snd_pcm_mmap_readi,
+	.readn		= snd_pcm_mmap_readn,
+	.avail_update	= snd_pcm_dsnoop_avail_update,
+	.mmap_commit	= snd_pcm_dsnoop_mmap_commit,
 };
 
 /**
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
