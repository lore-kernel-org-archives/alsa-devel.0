From: Art Haas <ahaas@airmail.net>
Subject: [PATCH] Replace obsolete GCC initializer syntax [2/3]
Date: Thu, 17 Jul 2003 07:46:24 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030717124624.GD3788@artsapartment.org>
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

Here's the second patch.

Index: alsa-lib/src/pcm/pcm_file.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_file.c,v
retrieving revision 1.59
diff -u -u -r1.59 pcm_file.c
--- alsa-lib/src/pcm/pcm_file.c	7 Mar 2003 18:46:25 -0000	1.59
+++ alsa-lib/src/pcm/pcm_file.c	16 Jul 2003 15:21:17 -0000
@@ -413,40 +413,39 @@
 }
 
 static snd_pcm_ops_t snd_pcm_file_ops = {
-	close: snd_pcm_file_close,
-	info: snd_pcm_file_info,
-	hw_refine: snd_pcm_file_hw_refine,
-	hw_params: snd_pcm_file_hw_params,
-	hw_free: snd_pcm_file_hw_free,
-	sw_params: snd_pcm_file_sw_params,
-	channel_info: snd_pcm_file_channel_info,
-	dump: snd_pcm_file_dump,
-	nonblock: snd_pcm_file_nonblock,
-	async: snd_pcm_file_async,
-	mmap: snd_pcm_file_mmap,
-	munmap: snd_pcm_file_munmap,
+	.close 		= snd_pcm_file_close,
+	.info 		= snd_pcm_file_info,
+	.hw_refine 	= snd_pcm_file_hw_refine,
+	.hw_params 	= snd_pcm_file_hw_params,
+	.hw_free 	= snd_pcm_file_hw_free,
+	.sw_params 	= snd_pcm_file_sw_params,
+	.channel_info 	= snd_pcm_file_channel_info,
+	.dump 		= snd_pcm_file_dump,
+	.nonblock 	= snd_pcm_file_nonblock,
+	.async 		= snd_pcm_file_async,
+	.mmap 		= snd_pcm_file_mmap,
+	.munmap 	= snd_pcm_file_munmap,
 };
 
 static snd_pcm_fast_ops_t snd_pcm_file_fast_ops = {
-	status: snd_pcm_file_status,
-	state: snd_pcm_file_state,
-	hwsync: snd_pcm_file_hwsync,
-	delay: snd_pcm_file_delay,
-	prepare: snd_pcm_file_prepare,
-	reset: snd_pcm_file_reset,
-	start: snd_pcm_file_start,
-	drop: snd_pcm_file_drop,
-	drain: snd_pcm_file_drain,
-	pause: snd_pcm_file_pause,
-	rewind: snd_pcm_file_rewind,
-	forward: snd_pcm_file_forward,
-	resume: snd_pcm_file_resume,
-	writei: snd_pcm_file_writei,
-	writen: snd_pcm_file_writen,
-	readi: snd_pcm_file_readi,
-	readn: snd_pcm_file_readn,
-	avail_update: snd_pcm_file_avail_update,
-	mmap_commit: snd_pcm_file_mmap_commit,
+	.status 	= snd_pcm_file_status,
+	.state 		= snd_pcm_file_state,
+	.hwsync 	= snd_pcm_file_hwsync,
+	.delay 		= snd_pcm_file_delay,
+	.prepare 	= snd_pcm_file_prepare,
+	.reset 		= snd_pcm_file_reset,
+	.start 		= snd_pcm_file_start,
+	.drop 		= snd_pcm_file_drop,
+	.drain 		= snd_pcm_file_drain,
+	.pause 		= snd_pcm_file_pause,
+	.rewind 	= snd_pcm_file_rewind,
+	.resume 	= snd_pcm_file_resume,
+	.writei 	= snd_pcm_file_writei,
+	.writen 	= snd_pcm_file_writen,
+	.readi 		= snd_pcm_file_readi,
+	.readn 		= snd_pcm_file_readn,
+	.avail_update 	= snd_pcm_file_avail_update,
+	.mmap_commit 	= snd_pcm_file_mmap_commit,
 };
 
 /**
Index: alsa-lib/src/pcm/pcm_hooks.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_hooks.c,v
retrieving revision 1.29
diff -u -u -r1.29 pcm_hooks.c
--- alsa-lib/src/pcm/pcm_hooks.c	7 Mar 2003 18:46:26 -0000	1.29
+++ alsa-lib/src/pcm/pcm_hooks.c	16 Jul 2003 15:21:17 -0000
@@ -287,40 +287,39 @@
 }
 
 static snd_pcm_ops_t snd_pcm_hooks_ops = {
-	close: snd_pcm_hooks_close,
-	info: snd_pcm_hooks_info,
-	hw_refine: snd_pcm_hooks_hw_refine,
-	hw_params: snd_pcm_hooks_hw_params,
-	hw_free: snd_pcm_hooks_hw_free,
-	sw_params: snd_pcm_hooks_sw_params,
-	channel_info: snd_pcm_hooks_channel_info,
-	dump: snd_pcm_hooks_dump,
-	nonblock: snd_pcm_hooks_nonblock,
-	async: snd_pcm_hooks_async,
-	mmap: snd_pcm_hooks_mmap,
-	munmap: snd_pcm_hooks_munmap,
+	.close 		= snd_pcm_hooks_close,
+	.info 		= snd_pcm_hooks_info,
+	.hw_refine 	= snd_pcm_hooks_hw_refine,
+	.hw_params 	= snd_pcm_hooks_hw_params,
+	.hw_free 	= snd_pcm_hooks_hw_free,
+	.sw_params 	= snd_pcm_hooks_sw_params,
+	.channel_info 	= snd_pcm_hooks_channel_info,
+	.dump 		= snd_pcm_hooks_dump,
+	.nonblock 	= snd_pcm_hooks_nonblock,
+	.async 		= snd_pcm_hooks_async,
+	.mmap 		= snd_pcm_hooks_mmap,
+	.munmap 	= snd_pcm_hooks_munmap,
 };
 
 static snd_pcm_fast_ops_t snd_pcm_hooks_fast_ops = {
-	status: snd_pcm_hooks_status,
-	state: snd_pcm_hooks_state,
-	hwsync: snd_pcm_hooks_hwsync,
-	delay: snd_pcm_hooks_delay,
-	prepare: snd_pcm_hooks_prepare,
-	reset: snd_pcm_hooks_reset,
-	start: snd_pcm_hooks_start,
-	drop: snd_pcm_hooks_drop,
-	drain: snd_pcm_hooks_drain,
-	pause: snd_pcm_hooks_pause,
-	rewind: snd_pcm_hooks_rewind,
-	forward: snd_pcm_hooks_forward,
-	resume: snd_pcm_hooks_resume,
-	writei: snd_pcm_hooks_writei,
-	writen: snd_pcm_hooks_writen,
-	readi: snd_pcm_hooks_readi,
-	readn: snd_pcm_hooks_readn,
-	avail_update: snd_pcm_hooks_avail_update,
-	mmap_commit: snd_pcm_hooks_mmap_commit,
+	.status 	= snd_pcm_hooks_status,
+	.state 		= snd_pcm_hooks_state,
+	.hwsync 	= snd_pcm_hooks_hwsync,
+	.delay 		= snd_pcm_hooks_delay,
+	.prepare 	= snd_pcm_hooks_prepare,
+	.reset 		= snd_pcm_hooks_reset,
+	.start 		= snd_pcm_hooks_start,
+	.drop 		= snd_pcm_hooks_drop,
+	.drain 		= snd_pcm_hooks_drain,
+	.pause 		= snd_pcm_hooks_pause,
+	.rewind 	= snd_pcm_hooks_rewind,
+	.resume 	= snd_pcm_hooks_resume,
+	.writei 	= snd_pcm_hooks_writei,
+	.writen 	= snd_pcm_hooks_writen,
+	.readi 		= snd_pcm_hooks_readi,
+	.readn 		= snd_pcm_hooks_readn,
+	.avail_update 	= snd_pcm_hooks_avail_update,
+	.mmap_commit 	= snd_pcm_hooks_mmap_commit,
 };
 
 /**
Index: alsa-lib/src/pcm/pcm_hw.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_hw.c,v
retrieving revision 1.120
diff -u -u -r1.120 pcm_hw.c
--- alsa-lib/src/pcm/pcm_hw.c	4 May 2003 20:07:30 -0000	1.120
+++ alsa-lib/src/pcm/pcm_hw.c	16 Jul 2003 15:21:17 -0000
@@ -843,40 +843,39 @@
 }
 
 static snd_pcm_ops_t snd_pcm_hw_ops = {
-	close: snd_pcm_hw_close,
-	info: snd_pcm_hw_info,
-	hw_refine: snd_pcm_hw_hw_refine,
-	hw_params: snd_pcm_hw_hw_params,
-	hw_free: snd_pcm_hw_hw_free,
-	sw_params: snd_pcm_hw_sw_params,
-	channel_info: snd_pcm_hw_channel_info,
-	dump: snd_pcm_hw_dump,
-	nonblock: snd_pcm_hw_nonblock,
-	async: snd_pcm_hw_async,
-	mmap: snd_pcm_hw_mmap,
-	munmap: snd_pcm_hw_munmap,
+	.close 			= snd_pcm_hw_close,
+	.info 			= snd_pcm_hw_info,
+	.hw_refine 		= snd_pcm_hw_hw_refine,
+	.hw_params 		= snd_pcm_hw_hw_params,
+	.hw_free 		= snd_pcm_hw_hw_free,
+	.sw_params 		= snd_pcm_hw_sw_params,
+	.channel_info 		= snd_pcm_hw_channel_info,
+	.dump 			= snd_pcm_hw_dump,
+	.nonblock 		= snd_pcm_hw_nonblock,
+	.async 			= snd_pcm_hw_async,
+	.mmap 			= snd_pcm_hw_mmap,
+	.munmap 		= snd_pcm_hw_munmap,
 };
 
 static snd_pcm_fast_ops_t snd_pcm_hw_fast_ops = {
-	status: snd_pcm_hw_status,
-	state: snd_pcm_hw_state,
-	hwsync: snd_pcm_hw_hwsync,
-	delay: snd_pcm_hw_delay,
-	prepare: snd_pcm_hw_prepare,
-	reset: snd_pcm_hw_reset,
-	start: snd_pcm_hw_start,
-	drop: snd_pcm_hw_drop,
-	drain: snd_pcm_hw_drain,
-	pause: snd_pcm_hw_pause,
-	rewind: snd_pcm_hw_rewind,
-	forward: snd_pcm_hw_forward,
-	resume: snd_pcm_hw_resume,
-	writei: snd_pcm_hw_writei,
-	writen: snd_pcm_hw_writen,
-	readi: snd_pcm_hw_readi,
-	readn: snd_pcm_hw_readn,
-	avail_update: snd_pcm_hw_avail_update,
-	mmap_commit: snd_pcm_hw_mmap_commit,
+	.status 		= snd_pcm_hw_status,
+	.state 			= snd_pcm_hw_state,
+	.hwsync 		= snd_pcm_hw_hwsync,
+	.delay 			= snd_pcm_hw_delay,
+	.prepare 		= snd_pcm_hw_prepare,
+	.reset 			= snd_pcm_hw_reset,
+	.start 			= snd_pcm_hw_start,
+	.drop 			= snd_pcm_hw_drop,
+	.drain 			= snd_pcm_hw_drain,
+	.pause 			= snd_pcm_hw_pause,
+	.rewind 		= snd_pcm_hw_rewind,
+	.resume 		= snd_pcm_hw_resume,
+	.writei 		= snd_pcm_hw_writei,
+	.writen 		= snd_pcm_hw_writen,
+	.readi 			= snd_pcm_hw_readi,
+	.readn 			= snd_pcm_hw_readn,
+	.avail_update 		= snd_pcm_hw_avail_update,
+	.mmap_commit 		= snd_pcm_hw_mmap_commit,
 };
 
 /**
Index: alsa-lib/src/pcm/pcm_ladspa.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_ladspa.c,v
retrieving revision 1.14
diff -u -u -r1.14 pcm_ladspa.c
--- alsa-lib/src/pcm/pcm_ladspa.c	14 Jun 2003 07:38:28 -0000	1.14
+++ alsa-lib/src/pcm/pcm_ladspa.c	16 Jul 2003 15:21:25 -0000
@@ -697,19 +697,18 @@
 }
 
 static snd_pcm_ops_t snd_pcm_ladspa_ops = {
-	close: snd_pcm_ladspa_close,
-	info: snd_pcm_plugin_info,
-	hw_refine: snd_pcm_ladspa_hw_refine,
-	hw_params: snd_pcm_ladspa_hw_params,
-	hw_free: snd_pcm_ladspa_hw_free,
-	sw_params: snd_pcm_plugin_sw_params,
-	channel_info: snd_pcm_plugin_channel_info,
-	dump: snd_pcm_ladspa_dump,
-	nonblock: snd_pcm_plugin_nonblock,
-	async: snd_pcm_plugin_async,
-	poll_revents: snd_pcm_plugin_poll_revents,
-	mmap: snd_pcm_plugin_mmap,
-	munmap: snd_pcm_plugin_munmap,
+	.close 		= snd_pcm_ladspa_close,
+	.info 		= snd_pcm_plugin_info,
+	.hw_refine 	= snd_pcm_ladspa_hw_refine,
+	.hw_params 	= snd_pcm_ladspa_hw_params,
+	.hw_free 	= snd_pcm_ladspa_hw_free,
+	.sw_params 	= snd_pcm_plugin_sw_params,
+	.channel_info 	= snd_pcm_plugin_channel_info,
+	.dump 		= snd_pcm_ladspa_dump,
+	.nonblock 	= snd_pcm_plugin_nonblock,
+	.async 		= snd_pcm_plugin_async,
+	.mmap 		= snd_pcm_plugin_mmap,
+	.munmap 	= snd_pcm_plugin_munmap,
 };
 
 static int snd_pcm_ladspa_check_file(snd_pcm_ladspa_plugin_t * const plugin,
Index: alsa-lib/src/pcm/pcm_lfloat.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_lfloat.c,v
retrieving revision 1.13
diff -u -u -r1.13 pcm_lfloat.c
--- alsa-lib/src/pcm/pcm_lfloat.c	11 Feb 2003 18:14:47 -0000	1.13
+++ alsa-lib/src/pcm/pcm_lfloat.c	16 Jul 2003 15:21:25 -0000
@@ -350,19 +350,18 @@
 }
 
 static snd_pcm_ops_t snd_pcm_lfloat_ops = {
-	close: snd_pcm_plugin_close,
-	info: snd_pcm_plugin_info,
-	hw_refine: snd_pcm_lfloat_hw_refine,
-	hw_params: snd_pcm_lfloat_hw_params,
-	hw_free: snd_pcm_plugin_hw_free,
-	sw_params: snd_pcm_plugin_sw_params,
-	channel_info: snd_pcm_plugin_channel_info,
-	dump: snd_pcm_lfloat_dump,
-	nonblock: snd_pcm_plugin_nonblock,
-	async: snd_pcm_plugin_async,
-	poll_revents: snd_pcm_plugin_poll_revents,
-	mmap: snd_pcm_plugin_mmap,
-	munmap: snd_pcm_plugin_munmap,
+	.close 		= snd_pcm_plugin_close,
+	.info 		= snd_pcm_plugin_info,
+	.hw_refine 	= snd_pcm_lfloat_hw_refine,
+	.hw_params 	= snd_pcm_lfloat_hw_params,
+	.hw_free 	= snd_pcm_plugin_hw_free,
+	.sw_params 	= snd_pcm_plugin_sw_params,
+	.channel_info 	= snd_pcm_plugin_channel_info,
+	.dump 		= snd_pcm_lfloat_dump,
+	.nonblock 	= snd_pcm_plugin_nonblock,
+	.async 		= snd_pcm_plugin_async,
+	.mmap 		= snd_pcm_plugin_mmap,
+	.munmap 	= snd_pcm_plugin_munmap,
 };
 
 /**
Index: alsa-lib/src/pcm/pcm_linear.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_linear.c,v
retrieving revision 1.55
diff -u -u -r1.55 pcm_linear.c
--- alsa-lib/src/pcm/pcm_linear.c	11 Feb 2003 18:14:47 -0000	1.55
+++ alsa-lib/src/pcm/pcm_linear.c	16 Jul 2003 15:21:25 -0000
@@ -406,19 +406,18 @@
 }
 
 static snd_pcm_ops_t snd_pcm_linear_ops = {
-	close: snd_pcm_plugin_close,
-	info: snd_pcm_plugin_info,
-	hw_refine: snd_pcm_linear_hw_refine,
-	hw_params: snd_pcm_linear_hw_params,
-	hw_free: snd_pcm_plugin_hw_free,
-	sw_params: snd_pcm_plugin_sw_params,
-	channel_info: snd_pcm_plugin_channel_info,
-	dump: snd_pcm_linear_dump,
-	nonblock: snd_pcm_plugin_nonblock,
-	async: snd_pcm_plugin_async,
-	poll_revents: snd_pcm_plugin_poll_revents,
-	mmap: snd_pcm_plugin_mmap,
-	munmap: snd_pcm_plugin_munmap,
+	.close 		= snd_pcm_plugin_close,
+	.info 		= snd_pcm_plugin_info,
+	.hw_refine 	= snd_pcm_linear_hw_refine,
+	.hw_params 	= snd_pcm_linear_hw_params,
+	.hw_free 	= snd_pcm_plugin_hw_free,
+	.sw_params 	= snd_pcm_plugin_sw_params,
+	.channel_info 	= snd_pcm_plugin_channel_info,
+	.dump 		= snd_pcm_linear_dump,
+	.nonblock 	= snd_pcm_plugin_nonblock,
+	.async 		= snd_pcm_plugin_async,
+	.mmap 		= snd_pcm_plugin_mmap,
+	.munmap 	= snd_pcm_plugin_munmap,
 };
 
 
Index: alsa-lib/src/pcm/pcm_meter.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_meter.c,v
retrieving revision 1.42
diff -u -u -r1.42 pcm_meter.c
--- alsa-lib/src/pcm/pcm_meter.c	7 Mar 2003 18:46:26 -0000	1.42
+++ alsa-lib/src/pcm/pcm_meter.c	16 Jul 2003 15:21:30 -0000
@@ -591,40 +591,39 @@
 }
 
 static snd_pcm_ops_t snd_pcm_meter_ops = {
-	close: snd_pcm_meter_close,
-	info: snd_pcm_meter_info,
-	hw_refine: snd_pcm_meter_hw_refine,
-	hw_params: snd_pcm_meter_hw_params,
-	hw_free: snd_pcm_meter_hw_free,
-	sw_params: snd_pcm_meter_sw_params,
-	channel_info: snd_pcm_meter_channel_info,
-	dump: snd_pcm_meter_dump,
-	nonblock: snd_pcm_meter_nonblock,
-	async: snd_pcm_meter_async,
-	mmap: snd_pcm_meter_mmap,
-	munmap: snd_pcm_meter_munmap,
+	.close 		= snd_pcm_meter_close,
+	.info 		= snd_pcm_meter_info,
+	.hw_refine 	= snd_pcm_meter_hw_refine,
+	.hw_params 	= snd_pcm_meter_hw_params,
+	.hw_free 	= snd_pcm_meter_hw_free,
+	.sw_params 	= snd_pcm_meter_sw_params,
+	.channel_info 	= snd_pcm_meter_channel_info,
+	.dump 		= snd_pcm_meter_dump,
+	.nonblock 	= snd_pcm_meter_nonblock,
+	.async 		= snd_pcm_meter_async,
+	.mmap 		= snd_pcm_meter_mmap,
+	.munmap 	= snd_pcm_meter_munmap,
 };
 
 static snd_pcm_fast_ops_t snd_pcm_meter_fast_ops = {
-	status: snd_pcm_meter_status,
-	state: snd_pcm_meter_state,
-	hwsync: snd_pcm_meter_hwsync,
-	delay: snd_pcm_meter_delay,
-	prepare: snd_pcm_meter_prepare,
-	reset: snd_pcm_meter_reset,
-	start: snd_pcm_meter_start,
-	drop: snd_pcm_meter_drop,
-	drain: snd_pcm_meter_drain,
-	pause: snd_pcm_meter_pause,
-	rewind: snd_pcm_meter_rewind,
-	forward: snd_pcm_meter_forward,
-	resume: snd_pcm_meter_resume,
-	writei: snd_pcm_mmap_writei,
-	writen: snd_pcm_mmap_writen,
-	readi: snd_pcm_mmap_readi,
-	readn: snd_pcm_mmap_readn,
-	avail_update: snd_pcm_meter_avail_update,
-	mmap_commit: snd_pcm_meter_mmap_commit,
+	.status 	= snd_pcm_meter_status,
+	.state 		= snd_pcm_meter_state,
+	.hwsync 	= snd_pcm_meter_hwsync,
+	.delay 		= snd_pcm_meter_delay,
+	.prepare 	= snd_pcm_meter_prepare,
+	.reset 		= snd_pcm_meter_reset,
+	.start 		= snd_pcm_meter_start,
+	.drop 		= snd_pcm_meter_drop,
+	.drain 		= snd_pcm_meter_drain,
+	.pause 		= snd_pcm_meter_pause,
+	.rewind 	= snd_pcm_meter_rewind,
+	.resume 	= snd_pcm_meter_resume,
+	.writei 	= snd_pcm_mmap_writei,
+	.writen 	= snd_pcm_mmap_writen,
+	.readi 		= snd_pcm_mmap_readi,
+	.readn 		= snd_pcm_mmap_readn,
+	.avail_update 	= snd_pcm_meter_avail_update,
+	.mmap_commit 	= snd_pcm_meter_mmap_commit,
 };
 
 /**
@@ -1220,13 +1219,13 @@
 }
 
 snd_pcm_scope_ops_t s16_ops = {
-	enable: s16_enable,
-	disable: s16_disable,
-	close: s16_close,
-	start: s16_start,
-	stop: s16_stop,
-	update: s16_update,
-	reset: s16_reset,
+	.enable 	= s16_enable,
+	.disable 	= s16_disable,
+	.close 		= s16_close,
+	.start 		= s16_start,
+	.stop 		= s16_stop,
+	.update 	= s16_update,
+	.reset 		= s16_reset,
 };
 
 #endif
Index: alsa-lib/src/pcm/pcm_mulaw.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_mulaw.c,v
retrieving revision 1.57
diff -u -u -r1.57 pcm_mulaw.c
--- alsa-lib/src/pcm/pcm_mulaw.c	11 Feb 2003 18:14:48 -0000	1.57
+++ alsa-lib/src/pcm/pcm_mulaw.c	16 Jul 2003 15:21:30 -0000
@@ -405,19 +405,18 @@
 }
 
 static snd_pcm_ops_t snd_pcm_mulaw_ops = {
-	close: snd_pcm_plugin_close,
-	info: snd_pcm_plugin_info,
-	hw_refine: snd_pcm_mulaw_hw_refine,
-	hw_params: snd_pcm_mulaw_hw_params,
-	hw_free: snd_pcm_plugin_hw_free,
-	sw_params: snd_pcm_plugin_sw_params,
-	channel_info: snd_pcm_plugin_channel_info,
-	dump: snd_pcm_mulaw_dump,
-	nonblock: snd_pcm_plugin_nonblock,
-	async: snd_pcm_plugin_async,
-	poll_revents: snd_pcm_plugin_poll_revents,
-	mmap: snd_pcm_plugin_mmap,
-	munmap: snd_pcm_plugin_munmap,
+	.close 		= snd_pcm_plugin_close,
+	.info 		= snd_pcm_plugin_info,
+	.hw_refine 	= snd_pcm_mulaw_hw_refine,
+	.hw_params 	= snd_pcm_mulaw_hw_params,
+	.hw_free 	= snd_pcm_plugin_hw_free,
+	.sw_params 	= snd_pcm_plugin_sw_params,
+	.channel_info 	= snd_pcm_plugin_channel_info,
+	.dump 		= snd_pcm_mulaw_dump,
+	.nonblock 	= snd_pcm_plugin_nonblock,
+	.async 		= snd_pcm_plugin_async,
+	.mmap 		= snd_pcm_plugin_mmap,
+	.munmap 	= snd_pcm_plugin_munmap,
 };
 
 /**
Index: alsa-lib/src/pcm/pcm_multi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_multi.c,v
retrieving revision 1.83
diff -u -u -r1.83 pcm_multi.c
--- alsa-lib/src/pcm/pcm_multi.c	7 Mar 2003 18:46:27 -0000	1.83
+++ alsa-lib/src/pcm/pcm_multi.c	16 Jul 2003 15:21:31 -0000
@@ -614,40 +614,39 @@
 }
 
 static snd_pcm_ops_t snd_pcm_multi_ops = {
-	close: snd_pcm_multi_close,
-	info: snd_pcm_multi_info,
-	hw_refine: snd_pcm_multi_hw_refine,
-	hw_params: snd_pcm_multi_hw_params,
-	hw_free: snd_pcm_multi_hw_free,
-	sw_params: snd_pcm_multi_sw_params,
-	channel_info: snd_pcm_multi_channel_info,
-	dump: snd_pcm_multi_dump,
-	nonblock: snd_pcm_multi_nonblock,
-	async: snd_pcm_multi_async,
-	mmap: snd_pcm_multi_mmap,
-	munmap: snd_pcm_multi_munmap,
+	.close 		= snd_pcm_multi_close,
+	.info 		= snd_pcm_multi_info,
+	.hw_refine 	= snd_pcm_multi_hw_refine,
+	.hw_params 	= snd_pcm_multi_hw_params,
+	.hw_free 	= snd_pcm_multi_hw_free,
+	.sw_params 	= snd_pcm_multi_sw_params,
+	.channel_info 	= snd_pcm_multi_channel_info,
+	.dump 		= snd_pcm_multi_dump,
+	.nonblock 	= snd_pcm_multi_nonblock,
+	.async 		= snd_pcm_multi_async,
+	.mmap 		= snd_pcm_multi_mmap,
+	.munmap 	= snd_pcm_multi_munmap,
 };
 
 static snd_pcm_fast_ops_t snd_pcm_multi_fast_ops = {
-	status: snd_pcm_multi_status,
-	state: snd_pcm_multi_state,
-	hwsync: snd_pcm_multi_hwsync,
-	delay: snd_pcm_multi_delay,
-	prepare: snd_pcm_multi_prepare,
-	reset: snd_pcm_multi_reset,
-	start: snd_pcm_multi_start,
-	drop: snd_pcm_multi_drop,
-	drain: snd_pcm_multi_drain,
-	pause: snd_pcm_multi_pause,
-	writei: snd_pcm_mmap_writei,
-	writen: snd_pcm_mmap_writen,
-	readi: snd_pcm_mmap_readi,
-	readn: snd_pcm_mmap_readn,
-	rewind: snd_pcm_multi_rewind,
-	forward: snd_pcm_multi_forward,
-	resume: snd_pcm_multi_resume,
-	avail_update: snd_pcm_multi_avail_update,
-	mmap_commit: snd_pcm_multi_mmap_commit,
+	.status 	= snd_pcm_multi_status,
+	.state 		= snd_pcm_multi_state,
+	.hwsync 	= snd_pcm_multi_hwsync,
+	.delay 		= snd_pcm_multi_delay,
+	.prepare 	= snd_pcm_multi_prepare,
+	.reset 		= snd_pcm_multi_reset,
+	.start 		= snd_pcm_multi_start,
+	.drop 		= snd_pcm_multi_drop,
+	.drain 		= snd_pcm_multi_drain,
+	.pause 		= snd_pcm_multi_pause,
+	.writei 	= snd_pcm_mmap_writei,
+	.writen 	= snd_pcm_mmap_writen,
+	.readi 		= snd_pcm_mmap_readi,
+	.readn 		= snd_pcm_mmap_readn,
+	.rewind 	= snd_pcm_multi_rewind,
+	.resume 	= snd_pcm_multi_resume,
+	.avail_update 	= snd_pcm_multi_avail_update,
+	.mmap_commit 	= snd_pcm_multi_mmap_commit,
 };
 
 /**
Index: alsa-lib/src/pcm/pcm_null.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_null.c,v
retrieving revision 1.47
diff -u -u -r1.47 pcm_null.c
--- alsa-lib/src/pcm/pcm_null.c	28 Feb 2003 17:23:34 -0000	1.47
+++ alsa-lib/src/pcm/pcm_null.c	16 Jul 2003 15:21:33 -0000
@@ -312,40 +312,39 @@
 }
 
 static snd_pcm_ops_t snd_pcm_null_ops = {
-	close: snd_pcm_null_close,
-	info: snd_pcm_null_info,
-	hw_refine: snd_pcm_null_hw_refine,
-	hw_params: snd_pcm_null_hw_params,
-	hw_free: snd_pcm_null_hw_free,
-	sw_params: snd_pcm_null_sw_params,
-	channel_info: snd_pcm_null_channel_info,
-	dump: snd_pcm_null_dump,
-	nonblock: snd_pcm_null_nonblock,
-	async: snd_pcm_null_async,
-	mmap: snd_pcm_null_mmap,
-	munmap: snd_pcm_null_munmap,
+	.close 		= snd_pcm_null_close,
+	.info 		= snd_pcm_null_info,
+	.hw_refine 	= snd_pcm_null_hw_refine,
+	.hw_params 	= snd_pcm_null_hw_params,
+	.hw_free 	= snd_pcm_null_hw_free,
+	.sw_params 	= snd_pcm_null_sw_params,
+	.channel_info 	= snd_pcm_null_channel_info,
+	.dump 		= snd_pcm_null_dump,
+	.nonblock 	= snd_pcm_null_nonblock,
+	.async 		= snd_pcm_null_async,
+	.mmap 		= snd_pcm_null_mmap,
+	.munmap 	= snd_pcm_null_munmap,
 };
 
 static snd_pcm_fast_ops_t snd_pcm_null_fast_ops = {
-	status: snd_pcm_null_status,
-	state: snd_pcm_null_state,
-	hwsync: snd_pcm_null_hwsync,
-	delay: snd_pcm_null_delay,
-	prepare: snd_pcm_null_prepare,
-	reset: snd_pcm_null_reset,
-	start: snd_pcm_null_start,
-	drop: snd_pcm_null_drop,
-	drain: snd_pcm_null_drain,
-	pause: snd_pcm_null_pause,
-	rewind: snd_pcm_null_rewind,
-	forward: snd_pcm_null_forward,
-	resume: snd_pcm_null_resume,
-	writei: snd_pcm_null_writei,
-	writen: snd_pcm_null_writen,
-	readi: snd_pcm_null_readi,
-	readn: snd_pcm_null_readn,
-	avail_update: snd_pcm_null_avail_update,
-	mmap_commit: snd_pcm_null_mmap_commit,
+	.status 	= snd_pcm_null_status,
+	.state 		= snd_pcm_null_state,
+	.hwsync 	= snd_pcm_null_hwsync,
+	.delay 		= snd_pcm_null_delay,
+	.prepare 	= snd_pcm_null_prepare,
+	.reset 		= snd_pcm_null_reset,
+	.start 		= snd_pcm_null_start,
+	.drop 		= snd_pcm_null_drop,
+	.drain 		= snd_pcm_null_drain,
+	.pause 		= snd_pcm_null_pause,
+	.rewind 	= snd_pcm_null_rewind,
+	.resume 	= snd_pcm_null_resume,
+	.writei 	= snd_pcm_null_writei,
+	.writen 	= snd_pcm_null_writen,
+	.readi 		= snd_pcm_null_readi,
+	.readn 		= snd_pcm_null_readn,
+	.avail_update 	= snd_pcm_null_avail_update,
+	.mmap_commit 	= snd_pcm_null_mmap_commit,
 };
 
 /**
Index: alsa-lib/src/pcm/pcm_params.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_params.c,v
retrieving revision 1.53
diff -u -u -r1.53 pcm_params.c
--- alsa-lib/src/pcm/pcm_params.c	28 May 2003 18:49:15 -0000	1.53
+++ alsa-lib/src/pcm/pcm_params.c	16 Jul 2003 15:21:37 -0000
@@ -1731,143 +1731,143 @@
 
 static snd_pcm_hw_rule_t refine_rules[] = {
 	{
-		var: SND_PCM_HW_PARAM_FORMAT,
-		func: snd_pcm_hw_rule_format,
-		deps: { SND_PCM_HW_PARAM_SAMPLE_BITS, -1 },
-		private_data: 0,
+		.var = SND_PCM_HW_PARAM_FORMAT,
+		.func = snd_pcm_hw_rule_format,
+		.deps = { SND_PCM_HW_PARAM_SAMPLE_BITS, -1 },
+		.private_data = 0,
 	},
 	{
-		var: SND_PCM_HW_PARAM_SAMPLE_BITS, 
-		func: snd_pcm_hw_rule_sample_bits,
-		deps: { SND_PCM_HW_PARAM_FORMAT, 
+		.var = SND_PCM_HW_PARAM_SAMPLE_BITS, 
+		.func = snd_pcm_hw_rule_sample_bits,
+		.deps = { SND_PCM_HW_PARAM_FORMAT, 
 			SND_PCM_HW_PARAM_SAMPLE_BITS, -1 },
-		private_data: 0,
+		.private_data = 0,
 	},
 	{
-		var: SND_PCM_HW_PARAM_SAMPLE_BITS, 
-		func: snd_pcm_hw_rule_div,
-		deps: { SND_PCM_HW_PARAM_FRAME_BITS,
+		.var = SND_PCM_HW_PARAM_SAMPLE_BITS, 
+		.func = snd_pcm_hw_rule_div,
+		.deps = { SND_PCM_HW_PARAM_FRAME_BITS,
 			SND_PCM_HW_PARAM_CHANNELS, -1 },
-		private_data: 0,
+		.private_data = 0,
 	},
 	{
-		var: SND_PCM_HW_PARAM_FRAME_BITS, 
-		func: snd_pcm_hw_rule_mul,
-		deps: { SND_PCM_HW_PARAM_SAMPLE_BITS,
+		.var = SND_PCM_HW_PARAM_FRAME_BITS, 
+		.func = snd_pcm_hw_rule_mul,
+		.deps = { SND_PCM_HW_PARAM_SAMPLE_BITS,
 			SND_PCM_HW_PARAM_CHANNELS, -1 },
-		private_data: 0,
+		.private_data = 0,
 	},
 	{
-		var: SND_PCM_HW_PARAM_FRAME_BITS, 
-		func: snd_pcm_hw_rule_mulkdiv,
-		deps: { SND_PCM_HW_PARAM_PERIOD_BYTES,
+		.var = SND_PCM_HW_PARAM_FRAME_BITS, 
+		.func = snd_pcm_hw_rule_mulkdiv,
+		.deps = { SND_PCM_HW_PARAM_PERIOD_BYTES,
 			SND_PCM_HW_PARAM_PERIOD_SIZE, -1 },
-		private_data: (void*) 8,
+		.private_data = (void*) 8,
 	},
 	{
-		var: SND_PCM_HW_PARAM_FRAME_BITS, 
-		func: snd_pcm_hw_rule_mulkdiv,
-		deps: { SND_PCM_HW_PARAM_BUFFER_BYTES,
+		.var = SND_PCM_HW_PARAM_FRAME_BITS, 
+		.func = snd_pcm_hw_rule_mulkdiv,
+		.deps = { SND_PCM_HW_PARAM_BUFFER_BYTES,
 			SND_PCM_HW_PARAM_BUFFER_SIZE, -1 },
-		private_data: (void*) 8,
+		.private_data = (void*) 8,
 	},
 	{
-		var: SND_PCM_HW_PARAM_CHANNELS, 
-		func: snd_pcm_hw_rule_div,
-		deps: { SND_PCM_HW_PARAM_FRAME_BITS,
+		.var = SND_PCM_HW_PARAM_CHANNELS, 
+		.func = snd_pcm_hw_rule_div,
+		.deps = { SND_PCM_HW_PARAM_FRAME_BITS,
 			SND_PCM_HW_PARAM_SAMPLE_BITS, -1 },
-		private_data: 0,
+		.private_data = 0,
 	},
 	{
-		var: SND_PCM_HW_PARAM_RATE, 
-		func: snd_pcm_hw_rule_mulkdiv,
-		deps: { SND_PCM_HW_PARAM_PERIOD_SIZE,
+		.var = SND_PCM_HW_PARAM_RATE, 
+		.func = snd_pcm_hw_rule_mulkdiv,
+		.deps = { SND_PCM_HW_PARAM_PERIOD_SIZE,
 			SND_PCM_HW_PARAM_PERIOD_TIME, -1 },
-		private_data: (void*) 1000000,
+		.private_data = (void*) 1000000,
 	},
 	{
-		var: SND_PCM_HW_PARAM_RATE, 
-		func: snd_pcm_hw_rule_mulkdiv,
-		deps: { SND_PCM_HW_PARAM_BUFFER_SIZE,
+		.var = SND_PCM_HW_PARAM_RATE, 
+		.func = snd_pcm_hw_rule_mulkdiv,
+		.deps = { SND_PCM_HW_PARAM_BUFFER_SIZE,
 			SND_PCM_HW_PARAM_BUFFER_TIME, -1 },
-		private_data: (void*) 1000000,
+		.private_data = (void*) 1000000,
 	},
 	{
-		var: SND_PCM_HW_PARAM_PERIODS, 
-		func: snd_pcm_hw_rule_div,
-		deps: { SND_PCM_HW_PARAM_BUFFER_SIZE,
+		.var = SND_PCM_HW_PARAM_PERIODS, 
+		.func = snd_pcm_hw_rule_div,
+		.deps = { SND_PCM_HW_PARAM_BUFFER_SIZE,
 			SND_PCM_HW_PARAM_PERIOD_SIZE, -1 },
-		private_data: 0,
+		.private_data = 0,
 	},
 	{
-		var: SND_PCM_HW_PARAM_PERIOD_SIZE, 
-		func: snd_pcm_hw_rule_div,
-		deps: { SND_PCM_HW_PARAM_BUFFER_SIZE,
+		.var = SND_PCM_HW_PARAM_PERIOD_SIZE, 
+		.func = snd_pcm_hw_rule_div,
+		.deps = { SND_PCM_HW_PARAM_BUFFER_SIZE,
 			SND_PCM_HW_PARAM_PERIODS, -1 },
-		private_data: 0,
+		.private_data = 0,
 	},
 	{
-		var: SND_PCM_HW_PARAM_PERIOD_SIZE, 
-		func: snd_pcm_hw_rule_mulkdiv,
-		deps: { SND_PCM_HW_PARAM_PERIOD_BYTES,
+		.var = SND_PCM_HW_PARAM_PERIOD_SIZE, 
+		.func = snd_pcm_hw_rule_mulkdiv,
+		.deps = { SND_PCM_HW_PARAM_PERIOD_BYTES,
 			SND_PCM_HW_PARAM_FRAME_BITS, -1 },
-		private_data: (void*) 8,
+		.private_data = (void*) 8,
 	},
 	{
-		var: SND_PCM_HW_PARAM_PERIOD_SIZE, 
-		func: snd_pcm_hw_rule_muldivk,
-		deps: { SND_PCM_HW_PARAM_PERIOD_TIME,
+		.var = SND_PCM_HW_PARAM_PERIOD_SIZE, 
+		.func = snd_pcm_hw_rule_muldivk,
+		.deps = { SND_PCM_HW_PARAM_PERIOD_TIME,
 			SND_PCM_HW_PARAM_RATE, -1 },
-		private_data: (void*) 1000000,
+		.private_data = (void*) 1000000,
 	},
 	{
-		var: SND_PCM_HW_PARAM_BUFFER_SIZE, 
-		func: snd_pcm_hw_rule_mul,
-		deps: { SND_PCM_HW_PARAM_PERIOD_SIZE,
+		.var = SND_PCM_HW_PARAM_BUFFER_SIZE, 
+		.func = snd_pcm_hw_rule_mul,
+		.deps = { SND_PCM_HW_PARAM_PERIOD_SIZE,
 			SND_PCM_HW_PARAM_PERIODS, -1 },
-		private_data: 0,
+		.private_data = 0,
 	},
 	{
-		var: SND_PCM_HW_PARAM_BUFFER_SIZE, 
-		func: snd_pcm_hw_rule_mulkdiv,
-		deps: { SND_PCM_HW_PARAM_BUFFER_BYTES,
+		.var = SND_PCM_HW_PARAM_BUFFER_SIZE, 
+		.func = snd_pcm_hw_rule_mulkdiv,
+		.deps = { SND_PCM_HW_PARAM_BUFFER_BYTES,
 			SND_PCM_HW_PARAM_FRAME_BITS, -1 },
-		private_data: (void*) 8,
+		.private_data = (void*) 8,
 	},
 	{
-		var: SND_PCM_HW_PARAM_BUFFER_SIZE, 
-		func: snd_pcm_hw_rule_muldivk,
-		deps: { SND_PCM_HW_PARAM_BUFFER_TIME,
+		.var = SND_PCM_HW_PARAM_BUFFER_SIZE, 
+		.func = snd_pcm_hw_rule_muldivk,
+		.deps = { SND_PCM_HW_PARAM_BUFFER_TIME,
 			SND_PCM_HW_PARAM_RATE, -1 },
-		private_data: (void*) 1000000,
+		.private_data = (void*) 1000000,
 	},
 	{
-		var: SND_PCM_HW_PARAM_PERIOD_BYTES, 
-		func: snd_pcm_hw_rule_muldivk,
-		deps: { SND_PCM_HW_PARAM_PERIOD_SIZE,
+		.var = SND_PCM_HW_PARAM_PERIOD_BYTES, 
+		.func = snd_pcm_hw_rule_muldivk,
+		.deps = { SND_PCM_HW_PARAM_PERIOD_SIZE,
 			SND_PCM_HW_PARAM_FRAME_BITS, -1 },
-		private_data: (void*) 8,
+		.private_data = (void*) 8,
 	},
 	{
-		var: SND_PCM_HW_PARAM_BUFFER_BYTES, 
-		func: snd_pcm_hw_rule_muldivk,
-		deps: { SND_PCM_HW_PARAM_BUFFER_SIZE,
+		.var = SND_PCM_HW_PARAM_BUFFER_BYTES, 
+		.func = snd_pcm_hw_rule_muldivk,
+		.deps = { SND_PCM_HW_PARAM_BUFFER_SIZE,
 			SND_PCM_HW_PARAM_FRAME_BITS, -1 },
-		private_data: (void*) 8,
+		.private_data = (void*) 8,
 	},
 	{
-		var: SND_PCM_HW_PARAM_PERIOD_TIME, 
-		func: snd_pcm_hw_rule_mulkdiv,
-		deps: { SND_PCM_HW_PARAM_PERIOD_SIZE,
+		.var = SND_PCM_HW_PARAM_PERIOD_TIME, 
+		.func = snd_pcm_hw_rule_mulkdiv,
+		.deps = { SND_PCM_HW_PARAM_PERIOD_SIZE,
 			SND_PCM_HW_PARAM_RATE, -1 },
-		private_data: (void*) 1000000,
+		.private_data = (void*) 1000000,
 	},
 	{
-		var: SND_PCM_HW_PARAM_BUFFER_TIME, 
-		func: snd_pcm_hw_rule_mulkdiv,
-		deps: { SND_PCM_HW_PARAM_BUFFER_SIZE,
+		.var = SND_PCM_HW_PARAM_BUFFER_TIME, 
+		.func = snd_pcm_hw_rule_mulkdiv,
+		.deps = { SND_PCM_HW_PARAM_BUFFER_SIZE,
 			SND_PCM_HW_PARAM_RATE, -1 },
-		private_data: (void*) 1000000,
+		.private_data = (void*) 1000000,
 	},
 };
 
@@ -1875,64 +1875,64 @@
 
 static snd_mask_t refine_masks[SND_PCM_HW_PARAM_LAST_MASK - SND_PCM_HW_PARAM_FIRST_MASK + 1] = {
 	[SND_PCM_HW_PARAM_ACCESS - SND_PCM_HW_PARAM_FIRST_MASK] = {
-		bits: { 0x1f },
+		.bits = { 0x1f },
 	},
 	[SND_PCM_HW_PARAM_FORMAT - SND_PCM_HW_PARAM_FIRST_MASK] = {
-		bits: { 0x81ffffff, 0xfff},
+		.bits = { 0x81ffffff, 0xfff},
 	},
 	[SND_PCM_HW_PARAM_SUBFORMAT - SND_PCM_HW_PARAM_FIRST_MASK] = {
-		bits: { 0x1 },
+		.bits = { 0x1 },
 	},
 };
   
 static snd_interval_t refine_intervals[SND_PCM_HW_PARAM_LAST_INTERVAL - SND_PCM_HW_PARAM_FIRST_INTERVAL + 1] = {
 	[SND_PCM_HW_PARAM_SAMPLE_BITS - SND_PCM_HW_PARAM_FIRST_INTERVAL] = {
-		min: 1, max: UINT_MAX,
-		openmin: 0, openmax: 0, integer: 1, empty: 0,
+		.min = 1, .max = UINT_MAX,
+		.openmin = 0, .openmax = 0, .integer = 1, .empty = 0,
 	},
 	[SND_PCM_HW_PARAM_FRAME_BITS - SND_PCM_HW_PARAM_FIRST_INTERVAL] = {
-		min: 1, max: UINT_MAX,
-		openmin: 0, openmax: 0, integer: 1, empty: 0,
+		.min = 1, .max = UINT_MAX,
+		.openmin = 0, .openmax = 0, .integer = 1, .empty = 0,
 	},
 	[SND_PCM_HW_PARAM_CHANNELS - SND_PCM_HW_PARAM_FIRST_INTERVAL] = {
-		min: 1, max: UINT_MAX,
-		openmin: 0, openmax: 0, integer: 1, empty: 0,
+		.min = 1, .max = UINT_MAX,
+		.openmin = 0, .openmax = 0, .integer = 1, .empty = 0,
 	},
 	[SND_PCM_HW_PARAM_RATE - SND_PCM_HW_PARAM_FIRST_INTERVAL] = {
-		min: 1, max: UINT_MAX,
-		openmin: 0, openmax: 0, integer: 0, empty: 0,
+		.min = 1, .max = UINT_MAX,
+		.openmin = 0, .openmax = 0, .integer = 0, .empty = 0,
 	},
 	[SND_PCM_HW_PARAM_PERIOD_TIME - SND_PCM_HW_PARAM_FIRST_INTERVAL] = {
-		min: 0, max: UINT_MAX,
-		openmin: 0, openmax: 0, integer: 0, empty: 0,
+		.min = 0, .max = UINT_MAX,
+		.openmin = 0, .openmax = 0, .integer = 0, .empty = 0,
 	},
 	[SND_PCM_HW_PARAM_PERIOD_SIZE - SND_PCM_HW_PARAM_FIRST_INTERVAL] = {
-		min: 0, max: UINT_MAX,
-		openmin: 0, openmax: 0, integer: 0, empty: 0,
+		.min = 0, .max = UINT_MAX,
+		.openmin = 0, .openmax = 0, .integer = 0, .empty = 0,
 	},
 	[SND_PCM_HW_PARAM_PERIOD_BYTES - SND_PCM_HW_PARAM_FIRST_INTERVAL] = {
-		min: 0, max: UINT_MAX,
-		openmin: 0, openmax: 0, integer: 0, empty: 0,
+		.min = 0, .max = UINT_MAX,
+		.openmin = 0, .openmax = 0, .integer = 0, .empty = 0,
 	},
 	[SND_PCM_HW_PARAM_PERIODS - SND_PCM_HW_PARAM_FIRST_INTERVAL] = {
-		min: 0, max: UINT_MAX,
-		openmin: 0, openmax: 0, integer: 0, empty: 0,
+		.min = 0, .max = UINT_MAX,
+		.openmin = 0, .openmax = 0, .integer = 0, .empty = 0,
 	},
 	[SND_PCM_HW_PARAM_BUFFER_TIME - SND_PCM_HW_PARAM_FIRST_INTERVAL] = {
-		min: 1, max: UINT_MAX,
-		openmin: 0, openmax: 0, integer: 0, empty: 0,
+		.min = 1, .max = UINT_MAX,
+		.openmin = 0, .openmax = 0, .integer = 0, .empty = 0,
 	},
 	[SND_PCM_HW_PARAM_BUFFER_SIZE - SND_PCM_HW_PARAM_FIRST_INTERVAL] = {
-		min: 1, max: UINT_MAX,
-		openmin: 0, openmax: 0, integer: 1, empty: 0,
+		.min = 1, .max = UINT_MAX,
+		.openmin = 0, .openmax = 0, .integer = 1, .empty = 0,
 	},
 	[SND_PCM_HW_PARAM_BUFFER_BYTES - SND_PCM_HW_PARAM_FIRST_INTERVAL] = {
-		min: 1, max: UINT_MAX,
-		openmin: 0, openmax: 0, integer: 1, empty: 0,
+		.min = 1, .max = UINT_MAX,
+		.openmin = 0, .openmax = 0, .integer = 1, .empty = 0,
 	},
 	[SND_PCM_HW_PARAM_TICK_TIME - SND_PCM_HW_PARAM_FIRST_INTERVAL] = {
-		min: 0, max: UINT_MAX,
-		openmin: 0, openmax: 0, integer: 0, empty: 0,
+		.min = 0, .max = UINT_MAX,
+		.openmin = 0, .openmax = 0, .integer = 0, .empty = 0,
 	},
 };
 
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
