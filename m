From: Art Haas <ahaas@airmail.net>
Subject: [PATCH] Replace obsolete GCC initializer syntax [3/3]
Date: Thu, 17 Jul 2003 07:47:14 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030717124714.GE3788@artsapartment.org>
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

Here's the third patch.

Index: alsa-lib/src/pcm/pcm_plug.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_plug.c,v
retrieving revision 1.122
diff -u -u -r1.122 pcm_plug.c
--- alsa-lib/src/pcm/pcm_plug.c	12 Feb 2003 21:57:51 -0000	1.122
+++ alsa-lib/src/pcm/pcm_plug.c	16 Jul 2003 15:21:41 -0000
@@ -955,19 +955,18 @@
 }
 
 static snd_pcm_ops_t snd_pcm_plug_ops = {
-	close: snd_pcm_plug_close,
-	info: snd_pcm_plug_info,
-	hw_refine: snd_pcm_plug_hw_refine,
-	hw_params: snd_pcm_plug_hw_params,
-	hw_free: snd_pcm_plug_hw_free,
-	sw_params: snd_pcm_plug_sw_params,
-	channel_info: snd_pcm_plug_channel_info,
-	dump: snd_pcm_plug_dump,
-	nonblock: snd_pcm_plug_nonblock,
-	async: snd_pcm_plug_async,
-	poll_revents: snd_pcm_plug_poll_revents,
-	mmap: snd_pcm_plug_mmap,
-	munmap: snd_pcm_plug_munmap,
+	.close 		= snd_pcm_plug_close,
+	.info 		= snd_pcm_plug_info,
+	.hw_refine 	= snd_pcm_plug_hw_refine,
+	.hw_params 	= snd_pcm_plug_hw_params,
+	.hw_free 	= snd_pcm_plug_hw_free,
+	.sw_params 	= snd_pcm_plug_sw_params,
+	.channel_info 	= snd_pcm_plug_channel_info,
+	.dump 		= snd_pcm_plug_dump,
+	.nonblock 	= snd_pcm_plug_nonblock,
+	.async 		= snd_pcm_plug_async,
+	.mmap 		= snd_pcm_plug_mmap,
+	.munmap 	= snd_pcm_plug_munmap,
 };
 
 /**
Index: alsa-lib/src/pcm/pcm_plugin.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_plugin.c,v
retrieving revision 1.90
diff -u -u -r1.90 pcm_plugin.c
--- alsa-lib/src/pcm/pcm_plugin.c	8 Mar 2003 16:35:20 -0000	1.90
+++ alsa-lib/src/pcm/pcm_plugin.c	16 Jul 2003 15:21:42 -0000
@@ -646,25 +646,24 @@
 }
 
 snd_pcm_fast_ops_t snd_pcm_plugin_fast_ops = {
-	status: snd_pcm_plugin_status,
-	state: snd_pcm_plugin_state,
-	hwsync: snd_pcm_plugin_hwsync,
-	delay: snd_pcm_plugin_delay,
-	prepare: snd_pcm_plugin_prepare,
-	reset: snd_pcm_plugin_reset,
-	start: snd_pcm_plugin_start,
-	drop: snd_pcm_plugin_drop,
-	drain: snd_pcm_plugin_drain,
-	pause: snd_pcm_plugin_pause,
-	rewind: snd_pcm_plugin_rewind,
-	forward: snd_pcm_plugin_forward,
-	resume: snd_pcm_plugin_resume,
-	writei: snd_pcm_plugin_writei,
-	writen: snd_pcm_plugin_writen,
-	readi: snd_pcm_plugin_readi,
-	readn: snd_pcm_plugin_readn,
-	avail_update: snd_pcm_plugin_avail_update,
-	mmap_commit: snd_pcm_plugin_mmap_commit,
+	.status 	= snd_pcm_plugin_status,
+	.state 		= snd_pcm_plugin_state,
+	.hwsync 	= snd_pcm_plugin_hwsync,
+	.delay 		= snd_pcm_plugin_delay,
+	.prepare 	= snd_pcm_plugin_prepare,
+	.reset 		= snd_pcm_plugin_reset,
+	.start 		= snd_pcm_plugin_start,
+	.drop 		= snd_pcm_plugin_drop,
+	.drain 		= snd_pcm_plugin_drain,
+	.pause 		= snd_pcm_plugin_pause,
+	.rewind 	= snd_pcm_plugin_rewind,
+	.resume 	= snd_pcm_plugin_resume,
+	.writei 	= snd_pcm_plugin_writei,
+	.writen 	= snd_pcm_plugin_writen,
+	.readi 		= snd_pcm_plugin_readi,
+	.readn 		= snd_pcm_plugin_readn,
+	.avail_update 	= snd_pcm_plugin_avail_update,
+	.mmap_commit 	= snd_pcm_plugin_mmap_commit,
 };
 
 
Index: alsa-lib/src/pcm/pcm_rate.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_rate.c,v
retrieving revision 1.71
diff -u -u -r1.71 pcm_rate.c
--- alsa-lib/src/pcm/pcm_rate.c	8 Mar 2003 16:35:20 -0000	1.71
+++ alsa-lib/src/pcm/pcm_rate.c	16 Jul 2003 15:21:46 -0000
@@ -568,19 +568,18 @@
 }
 
 static snd_pcm_ops_t snd_pcm_rate_ops = {
-	close: snd_pcm_plugin_close,
-	info: snd_pcm_plugin_info,
-	hw_refine: snd_pcm_rate_hw_refine,
-	hw_params: snd_pcm_rate_hw_params,
-	hw_free: snd_pcm_rate_hw_free,
-	sw_params: snd_pcm_rate_sw_params,
-	channel_info: snd_pcm_plugin_channel_info,
-	dump: snd_pcm_rate_dump,
-	nonblock: snd_pcm_plugin_nonblock,
-	async: snd_pcm_plugin_async,
-	poll_revents: snd_pcm_plugin_poll_revents,
-	mmap: snd_pcm_plugin_mmap,
-	munmap: snd_pcm_plugin_munmap,
+	.close 		= snd_pcm_plugin_close,
+	.info 		= snd_pcm_plugin_info,
+	.hw_refine 	= snd_pcm_rate_hw_refine,
+	.hw_params 	= snd_pcm_rate_hw_params,
+	.hw_free 	= snd_pcm_rate_hw_free,
+	.sw_params 	= snd_pcm_rate_sw_params,
+	.channel_info 	= snd_pcm_plugin_channel_info,
+	.dump 		= snd_pcm_rate_dump,
+	.nonblock 	= snd_pcm_plugin_nonblock,
+	.async 		= snd_pcm_plugin_async,
+	.mmap 		= snd_pcm_plugin_mmap,
+	.munmap 	= snd_pcm_plugin_munmap,
 };
 
 
Index: alsa-lib/src/pcm/pcm_route.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_route.c,v
retrieving revision 1.72
diff -u -u -r1.72 pcm_route.c
--- alsa-lib/src/pcm/pcm_route.c	16 May 2003 14:36:26 -0000	1.72
+++ alsa-lib/src/pcm/pcm_route.c	16 Jul 2003 15:21:46 -0000
@@ -722,19 +722,18 @@
 }
 
 static snd_pcm_ops_t snd_pcm_route_ops = {
-	close: snd_pcm_route_close,
-	info: snd_pcm_plugin_info,
-	hw_refine: snd_pcm_route_hw_refine,
-	hw_params: snd_pcm_route_hw_params,
-	hw_free: snd_pcm_plugin_hw_free,
-	sw_params: snd_pcm_plugin_sw_params,
-	channel_info: snd_pcm_plugin_channel_info,
-	dump: snd_pcm_route_dump,
-	nonblock: snd_pcm_plugin_nonblock,
-	async: snd_pcm_plugin_async,
-	poll_revents: snd_pcm_plugin_poll_revents,
-	mmap: snd_pcm_plugin_mmap,
-	munmap: snd_pcm_plugin_munmap,
+	.close 		= snd_pcm_route_close,
+	.info 		= snd_pcm_plugin_info,
+	.hw_refine 	= snd_pcm_route_hw_refine,
+	.hw_params 	= snd_pcm_route_hw_params,
+	.hw_free 	= snd_pcm_plugin_hw_free,
+	.sw_params 	= snd_pcm_plugin_sw_params,
+	.channel_info 	= snd_pcm_plugin_channel_info,
+	.dump 		= snd_pcm_route_dump,
+	.nonblock 	= snd_pcm_plugin_nonblock,
+	.async 		= snd_pcm_plugin_async,
+	.mmap 		= snd_pcm_plugin_mmap,
+	.munmap 	= snd_pcm_plugin_munmap,
 };
 
 static int route_load_ttable(snd_pcm_route_params_t *params, snd_pcm_stream_t stream,
Index: alsa-lib/src/pcm/pcm_share.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_share.c,v
retrieving revision 1.75
diff -u -u -r1.75 pcm_share.c
--- alsa-lib/src/pcm/pcm_share.c	1 Jul 2003 09:24:30 -0000	1.75
+++ alsa-lib/src/pcm/pcm_share.c	16 Jul 2003 15:21:51 -0000
@@ -1264,40 +1264,39 @@
 }
 
 static snd_pcm_ops_t snd_pcm_share_ops = {
-	close: snd_pcm_share_close,
-	info: snd_pcm_share_info,
-	hw_refine: snd_pcm_share_hw_refine,
-	hw_params: snd_pcm_share_hw_params,
-	hw_free: snd_pcm_share_hw_free,
-	sw_params: snd_pcm_share_sw_params,
-	channel_info: snd_pcm_share_channel_info,
-	dump: snd_pcm_share_dump,
-	nonblock: snd_pcm_share_nonblock,
-	async: snd_pcm_share_async,
-	mmap: snd_pcm_share_mmap,
-	munmap: snd_pcm_share_munmap,
+	.close 		= snd_pcm_share_close,
+	.info 		= snd_pcm_share_info,
+	.hw_refine 	= snd_pcm_share_hw_refine,
+	.hw_params 	= snd_pcm_share_hw_params,
+	.hw_free 	= snd_pcm_share_hw_free,
+	.sw_params 	= snd_pcm_share_sw_params,
+	.channel_info 	= snd_pcm_share_channel_info,
+	.dump 		= snd_pcm_share_dump,
+	.nonblock 	= snd_pcm_share_nonblock,
+	.async 		= snd_pcm_share_async,
+	.mmap 		= snd_pcm_share_mmap,
+	.munmap 	= snd_pcm_share_munmap,
 };
 
 static snd_pcm_fast_ops_t snd_pcm_share_fast_ops = {
-	status: snd_pcm_share_status,
-	state: snd_pcm_share_state,
-	hwsync: snd_pcm_share_hwsync,
-	delay: snd_pcm_share_delay,
-	prepare: snd_pcm_share_prepare,
-	reset: snd_pcm_share_reset,
-	start: snd_pcm_share_start,
-	drop: snd_pcm_share_drop,
-	drain: snd_pcm_share_drain,
-	pause: snd_pcm_share_pause,
-	writei: snd_pcm_mmap_writei,
-	writen: snd_pcm_mmap_writen,
-	readi: snd_pcm_mmap_readi,
-	readn: snd_pcm_mmap_readn,
-	rewind: snd_pcm_share_rewind,
-	forward: snd_pcm_share_forward,
-	resume: snd_pcm_share_resume,
-	avail_update: snd_pcm_share_avail_update,
-	mmap_commit: snd_pcm_share_mmap_commit,
+	.status 	= snd_pcm_share_status,
+	.state 		= snd_pcm_share_state,
+	.hwsync 	= snd_pcm_share_hwsync,
+	.delay 		= snd_pcm_share_delay,
+	.prepare 	= snd_pcm_share_prepare,
+	.reset 		= snd_pcm_share_reset,
+	.start 		= snd_pcm_share_start,
+	.drop 		= snd_pcm_share_drop,
+	.drain 		= snd_pcm_share_drain,
+	.pause 		= snd_pcm_share_pause,
+	.writei 	= snd_pcm_mmap_writei,
+	.writen 	= snd_pcm_mmap_writen,
+	.readi 		= snd_pcm_mmap_readi,
+	.readn 		= snd_pcm_mmap_readn,
+	.rewind 	= snd_pcm_share_rewind,
+	.resume 	= snd_pcm_share_resume,
+	.avail_update 	= snd_pcm_share_avail_update,
+	.mmap_commit 	= snd_pcm_share_mmap_commit,
 };
 
 /**
Index: alsa-lib/src/pcm/pcm_shm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_shm.c,v
retrieving revision 1.57
diff -u -u -r1.57 pcm_shm.c
--- alsa-lib/src/pcm/pcm_shm.c	18 Mar 2003 18:00:21 -0000	1.57
+++ alsa-lib/src/pcm/pcm_shm.c	16 Jul 2003 15:21:55 -0000
@@ -574,40 +574,39 @@
 }
 
 static snd_pcm_ops_t snd_pcm_shm_ops = {
-	close: snd_pcm_shm_close,
-	info: snd_pcm_shm_info,
-	hw_refine: snd_pcm_shm_hw_refine,
-	hw_params: snd_pcm_shm_hw_params,
-	hw_free: snd_pcm_shm_hw_free,
-	sw_params: snd_pcm_shm_sw_params,
-	channel_info: snd_pcm_shm_channel_info,
-	dump: snd_pcm_shm_dump,
-	nonblock: snd_pcm_shm_nonblock,
-	async: snd_pcm_shm_async,
-	mmap: snd_pcm_shm_mmap,
-	munmap: snd_pcm_shm_munmap,
+	.close 		= snd_pcm_shm_close,
+	.info 		= snd_pcm_shm_info,
+	.hw_refine 	= snd_pcm_shm_hw_refine,
+	.hw_params 	= snd_pcm_shm_hw_params,
+	.hw_free 	= snd_pcm_shm_hw_free,
+	.sw_params 	= snd_pcm_shm_sw_params,
+	.channel_info 	= snd_pcm_shm_channel_info,
+	.dump 		= snd_pcm_shm_dump,
+	.nonblock 	= snd_pcm_shm_nonblock,
+	.async 		= snd_pcm_shm_async,
+	.mmap 		= snd_pcm_shm_mmap,
+	.munmap 	= snd_pcm_shm_munmap,
 };
 
 static snd_pcm_fast_ops_t snd_pcm_shm_fast_ops = {
-	status: snd_pcm_shm_status,
-	state: snd_pcm_shm_state,
-	hwsync: snd_pcm_shm_hwsync,
-	delay: snd_pcm_shm_delay,
-	prepare: snd_pcm_shm_prepare,
-	reset: snd_pcm_shm_reset,
-	start: snd_pcm_shm_start,
-	drop: snd_pcm_shm_drop,
-	drain: snd_pcm_shm_drain,
-	pause: snd_pcm_shm_pause,
-	rewind: snd_pcm_shm_rewind,
-	forward: snd_pcm_shm_forward,
-	resume: snd_pcm_shm_resume,
-	writei: snd_pcm_mmap_writei,
-	writen: snd_pcm_mmap_writen,
-	readi: snd_pcm_mmap_readi,
-	readn: snd_pcm_mmap_readn,
-	avail_update: snd_pcm_shm_avail_update,
-	mmap_commit: snd_pcm_shm_mmap_commit,
+	.status 	= snd_pcm_shm_status,
+	.state 		= snd_pcm_shm_state,
+	.hwsync 	= snd_pcm_shm_hwsync,
+	.delay 		= snd_pcm_shm_delay,
+	.prepare 	= snd_pcm_shm_prepare,
+	.reset 		= snd_pcm_shm_reset,
+	.start 		= snd_pcm_shm_start,
+	.drop 		= snd_pcm_shm_drop,
+	.drain 		= snd_pcm_shm_drain,
+	.pause 		= snd_pcm_shm_pause,
+	.rewind 	= snd_pcm_shm_rewind,
+	.resume 	= snd_pcm_shm_resume,
+	.writei 	= snd_pcm_mmap_writei,
+	.writen 	= snd_pcm_mmap_writen,
+	.readi 		= snd_pcm_mmap_readi,
+	.readn 		= snd_pcm_mmap_readn,
+	.avail_update 	= snd_pcm_shm_avail_update,
+	.mmap_commit 	= snd_pcm_shm_mmap_commit,
 };
 
 static int make_local_socket(const char *filename)
Index: alsa-lib/src/pcm/scopes/level.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/scopes/level.c,v
retrieving revision 1.5
diff -u -u -r1.5 level.c
--- alsa-lib/src/pcm/scopes/level.c	12 Jun 2002 16:44:01 -0000	1.5
+++ alsa-lib/src/pcm/scopes/level.c	16 Jul 2003 15:21:56 -0000
@@ -170,13 +170,13 @@
 }
 
 snd_pcm_scope_ops_t level_ops = {
-	enable: level_enable,
-	disable: level_disable,
-	close: level_close,
-	start: level_start,
-	stop: level_stop,
-	update: level_update,
-	reset: level_reset,
+	.enable 	= level_enable,
+	.disable 	= level_disable,
+	.close 		= level_close,
+	.start 		= level_start,
+	.stop 		= level_stop,
+	.update 	= level_update,
+	.reset 		= level_reset,
 };
 
 int snd_pcm_scope_level_open(snd_pcm_t *pcm, const char *name,
Index: alsa-lib/src/rawmidi/rawmidi_hw.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/rawmidi/rawmidi_hw.c,v
retrieving revision 1.26
diff -u -u -r1.26 rawmidi_hw.c
--- alsa-lib/src/rawmidi/rawmidi_hw.c	5 Feb 2003 11:00:24 -0000	1.26
+++ alsa-lib/src/rawmidi/rawmidi_hw.c	16 Jul 2003 15:21:58 -0000
@@ -153,15 +153,15 @@
 }
 
 snd_rawmidi_ops_t snd_rawmidi_hw_ops = {
-	close: snd_rawmidi_hw_close,
-	nonblock: snd_rawmidi_hw_nonblock,
-	info: snd_rawmidi_hw_info,
-	params: snd_rawmidi_hw_params,
-	status: snd_rawmidi_hw_status,
-	drop: snd_rawmidi_hw_drop,
-	drain: snd_rawmidi_hw_drain,
-	write: snd_rawmidi_hw_write,
-	read: snd_rawmidi_hw_read,
+	.close 		= snd_rawmidi_hw_close,
+	.nonblock 	= snd_rawmidi_hw_nonblock,
+	.info 		= snd_rawmidi_hw_info,
+	.params 	= snd_rawmidi_hw_params,
+	.status 	= snd_rawmidi_hw_status,
+	.drop 		= snd_rawmidi_hw_drop,
+	.drain 		= snd_rawmidi_hw_drain,
+	.write 		= snd_rawmidi_hw_write,
+	.read 		= snd_rawmidi_hw_read,
 };
 
 
Index: alsa-lib/src/seq/seq_hw.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/seq/seq_hw.c,v
retrieving revision 1.20
diff -u -u -r1.20 seq_hw.c
--- alsa-lib/src/seq/seq_hw.c	5 Feb 2003 11:00:26 -0000	1.20
+++ alsa-lib/src/seq/seq_hw.c	16 Jul 2003 15:21:58 -0000
@@ -378,38 +378,38 @@
 }
 
 snd_seq_ops_t snd_seq_hw_ops = {
-	close: snd_seq_hw_close,
-	nonblock: snd_seq_hw_nonblock,
-	system_info: snd_seq_hw_system_info,
-	get_client_info: snd_seq_hw_get_client_info,
-	set_client_info: snd_seq_hw_set_client_info,
-	create_port: snd_seq_hw_create_port,
-	delete_port: snd_seq_hw_delete_port,
-	get_port_info: snd_seq_hw_get_port_info,
-	set_port_info: snd_seq_hw_set_port_info,
-	get_port_subscription: snd_seq_hw_get_port_subscription,
-	subscribe_port: snd_seq_hw_subscribe_port,
-	unsubscribe_port: snd_seq_hw_unsubscribe_port,
-	query_port_subscribers: snd_seq_hw_query_port_subscribers,
-	get_queue_status: snd_seq_hw_get_queue_status,
-	get_queue_tempo: snd_seq_hw_get_queue_tempo,
-	set_queue_tempo: snd_seq_hw_set_queue_tempo,
-	get_queue_timer: snd_seq_hw_get_queue_timer,
-	set_queue_timer: snd_seq_hw_set_queue_timer,
-	get_queue_client: snd_seq_hw_get_queue_client,
-	set_queue_client: snd_seq_hw_set_queue_client,
-	create_queue: snd_seq_hw_create_queue,
-	delete_queue: snd_seq_hw_delete_queue,
-	get_queue_info: snd_seq_hw_get_queue_info,
-	set_queue_info: snd_seq_hw_set_queue_info,
-	get_named_queue: snd_seq_hw_get_named_queue,
-	write: snd_seq_hw_write,
-	read: snd_seq_hw_read,
-	remove_events: snd_seq_hw_remove_events,
-	get_client_pool: snd_seq_hw_get_client_pool,
-	set_client_pool: snd_seq_hw_set_client_pool,
-	query_next_client: snd_seq_hw_query_next_client,
-	query_next_port: snd_seq_hw_query_next_port,
+	.close 			= snd_seq_hw_close,
+	.nonblock 		= snd_seq_hw_nonblock,
+	.system_info 		= snd_seq_hw_system_info,
+	.get_client_info 	= snd_seq_hw_get_client_info,
+	.set_client_info 	= snd_seq_hw_set_client_info,
+	.create_port 		= snd_seq_hw_create_port,
+	.delete_port 		= snd_seq_hw_delete_port,
+	.get_port_info 		= snd_seq_hw_get_port_info,
+	.set_port_info 		= snd_seq_hw_set_port_info,
+	.get_port_subscription 	= snd_seq_hw_get_port_subscription,
+	.subscribe_port 	= snd_seq_hw_subscribe_port,
+	.unsubscribe_port 	= snd_seq_hw_unsubscribe_port,
+	.query_port_subscribers = snd_seq_hw_query_port_subscribers,
+	.get_queue_status 	= snd_seq_hw_get_queue_status,
+	.get_queue_tempo 	= snd_seq_hw_get_queue_tempo,
+	.set_queue_tempo 	= snd_seq_hw_set_queue_tempo,
+	.get_queue_timer 	= snd_seq_hw_get_queue_timer,
+	.set_queue_timer 	= snd_seq_hw_set_queue_timer,
+	.get_queue_client 	= snd_seq_hw_get_queue_client,
+	.set_queue_client 	= snd_seq_hw_set_queue_client,
+	.create_queue 		= snd_seq_hw_create_queue,
+	.delete_queue 		= snd_seq_hw_delete_queue,
+	.get_queue_info 	= snd_seq_hw_get_queue_info,
+	.set_queue_info 	= snd_seq_hw_set_queue_info,
+	.get_named_queue 	= snd_seq_hw_get_named_queue,
+	.write 			= snd_seq_hw_write,
+	.read 			= snd_seq_hw_read,
+	.remove_events 		= snd_seq_hw_remove_events,
+	.get_client_pool 	= snd_seq_hw_get_client_pool,
+	.set_client_pool 	= snd_seq_hw_set_client_pool,
+	.query_next_client 	= snd_seq_hw_query_next_client,
+	.query_next_port 	= snd_seq_hw_query_next_port,
 };
 
 int snd_seq_hw_open(snd_seq_t **handle, const char *name, int streams, int mode)
Index: alsa-lib/src/timer/timer_hw.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/timer/timer_hw.c,v
retrieving revision 1.11
diff -u -u -r1.11 timer_hw.c
--- alsa-lib/src/timer/timer_hw.c	4 Mar 2003 20:01:09 -0000	1.11
+++ alsa-lib/src/timer/timer_hw.c	16 Jul 2003 15:21:58 -0000
@@ -188,16 +188,15 @@
 }
 
 static snd_timer_ops_t snd_timer_hw_ops = {
-	.close = snd_timer_hw_close,
-	.nonblock = snd_timer_hw_nonblock,
-	.async = snd_timer_hw_async,
-	.info = snd_timer_hw_info,
-	.params = snd_timer_hw_params,
-	.status = snd_timer_hw_status,
-	.rt_start = snd_timer_hw_start,
-	.rt_stop = snd_timer_hw_stop,
-	.rt_continue = snd_timer_hw_continue,
-	.read = snd_timer_hw_read,
+	.close 		= snd_timer_hw_close,
+	.nonblock 	= snd_timer_hw_nonblock,
+	.info 		= snd_timer_hw_info,
+	.params 	= snd_timer_hw_params,
+	.status 	= snd_timer_hw_status,
+	.rt_start 	= snd_timer_hw_start,
+	.rt_stop 	= snd_timer_hw_stop,
+	.rt_continue 	= snd_timer_hw_continue,
+	.read 		= snd_timer_hw_read,
 };
 
 int snd_timer_hw_open(snd_timer_t **handle, const char *name, int dev_class, int dev_sclass, int card, int device, int subdevice, int mode)
Index: alsa-lib/src/timer/timer_query_hw.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/timer/timer_query_hw.c,v
retrieving revision 1.6
diff -u -u -r1.6 timer_query_hw.c
--- alsa-lib/src/timer/timer_query_hw.c	4 Mar 2003 20:01:10 -0000	1.6
+++ alsa-lib/src/timer/timer_query_hw.c	16 Jul 2003 15:21:58 -0000
@@ -82,11 +82,11 @@
 }
 
 static snd_timer_query_ops_t snd_timer_query_hw_ops = {
-	close: snd_timer_query_hw_close,
-	next_device: snd_timer_query_hw_next_device,
-	info: snd_timer_query_hw_info,
-	params: snd_timer_query_hw_params,
-	status: snd_timer_query_hw_status
+	.close		= snd_timer_query_hw_close,
+	.next_device	= snd_timer_query_hw_next_device,
+	.info		= snd_timer_query_hw_info,
+	.params		= snd_timer_query_hw_params,
+	.status		= snd_timer_query_hw_status,
 };
 
 int snd_timer_query_hw_open(snd_timer_query_t **handle, const char *name, int mode)
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
