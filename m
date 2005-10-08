From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: surround51 problems. (problem patch identified)
Date: Sat, 08 Oct 2005 19:40:23 +0100
Message-ID: <43481297.6080504@superbug.co.uk>
References: <E1EBEWw-0006Qa-Li@sc8-pr-cvs1.sourceforge.net> <4348105C.2050809@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010301080808060801000406"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4348105C.2050809@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010301080808060801000406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

James Courtier-Dutton wrote:
> Hi,
> 
> I did a lot of different checkouts, and it starts failing immediately 
> after this patch, dated: 2nd September 2005.
> So, I conclude that this patch is to blame for the surround51 problems 
> with the Audigy 2 sound card.
> 
> This does not seem to effect the intel8x0 driver for surround51.
> The major difference between these two cards is that the intel8x0 takes 
> the samples as 6 channels interleaved, but the emu10k1 takes the sound 
> as 3 separate stereo interleaved channels.
> 
> I hope this helps you fix the problem that you introduced.
>  From reading the patch, it looks like you were trying to remove an 
> slave buffer when it is not needed, but you seem to assume that it is 
> never needed, instead of actually doing a runtime check before disabling 
> it.
> 
> James
> 

See attached patch that I use to reverse out these changes, in order to 
get the current alsa-lib cvs working with the emu10k1.

James

--------------010301080808060801000406
Content-Type: text/plain;
 name="emu10k1-surround51-fix.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="emu10k1-surround51-fix.diff.txt"

diff -ur alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_file.c alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_file.c
--- alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_file.c	2005-08-17 18:27:16.000000000 +0100
+++ alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_file.c	2005-09-02 17:36:40.000000000 +0100
@@ -302,26 +302,6 @@
 	return 0;
 }
 
-static int snd_pcm_file_mmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
-{
-	snd_pcm_file_t *file = pcm->private_data;
-	snd_pcm_t *slave = file->gen.slave;
-	pcm->running_areas = slave->running_areas;
-	pcm->stopped_areas = slave->stopped_areas;
-	pcm->mmap_channels = slave->mmap_channels;
-	pcm->mmap_shadow = 1;
-	return 0;
-}
-
-static int snd_pcm_file_munmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
-{
-	pcm->mmap_channels = NULL;
-	pcm->running_areas = NULL;
-	pcm->stopped_areas = NULL;
-	pcm->mmap_shadow = 0;
-	return 0;
-}
-
 static void snd_pcm_file_dump(snd_pcm_t *pcm, snd_output_t *out)
 {
 	snd_pcm_file_t *file = pcm->private_data;
@@ -348,8 +328,8 @@
 	.dump = snd_pcm_file_dump,
 	.nonblock = snd_pcm_generic_nonblock,
 	.async = snd_pcm_generic_async,
-	.mmap = snd_pcm_file_mmap,
-	.munmap = snd_pcm_file_munmap,
+	.mmap = snd_pcm_generic_mmap,
+	.munmap = snd_pcm_generic_munmap,
 };
 
 static snd_pcm_fast_ops_t snd_pcm_file_fast_ops = {
diff -ur alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_generic.c alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_generic.c
--- alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_generic.c	2005-05-19 17:50:24.000000000 +0100
+++ alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_generic.c	2005-09-02 17:36:40.000000000 +0100
@@ -113,7 +113,16 @@
 int snd_pcm_generic_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t *info)
 {
 	snd_pcm_generic_t *generic = pcm->private_data;
-	return snd_pcm_channel_info(generic->slave, info);
+	if (pcm->mmap_shadow) {
+		/* No own buffer is required - the plugin won't change
+		 * the data on the buffer, or do safely on-the-place
+		 * conversion
+		 */
+		return snd_pcm_channel_info(generic->slave, info);
+	} else {
+		/* Allocate own buffer */
+		return snd_pcm_channel_info_shm(generic->slave, info, -1);
+	}
 }
 
 int snd_pcm_generic_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
@@ -290,13 +299,26 @@
 	return snd_pcm_avail_update(generic->slave);
 }
 
-int snd_pcm_generic_mmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
+int snd_pcm_generic_mmap(snd_pcm_t *pcm)
 {
+	if (pcm->mmap_shadow) {
+		/* Copy the slave mmapped buffer data */
+		snd_pcm_generic_t *generic = pcm->private_data;
+		pcm->mmap_channels = generic->slave->mmap_channels;
+		pcm->running_areas = generic->slave->running_areas;
+		pcm->stopped_areas = generic->slave->stopped_areas;
+	}
 	return 0;
 }
 
-int snd_pcm_generic_munmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
+int snd_pcm_generic_munmap(snd_pcm_t *pcm)
 {
+	if (pcm->mmap_shadow) {
+		/* Clean up */
+		pcm->mmap_channels = NULL;
+		pcm->running_areas = NULL;
+		pcm->stopped_areas = NULL;
+	}
 	return 0;
 }
 
diff -ur alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_generic.h alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_generic.h
--- alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_generic.h	2005-05-19 17:50:24.000000000 +0100
+++ alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_generic.h	2005-09-02 17:36:40.000000000 +0100
@@ -36,6 +36,7 @@
 int snd_pcm_generic_hw_refine(snd_pcm_t *pcm, snd_pcm_hw_params_t *params);
 int snd_pcm_generic_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t *params);
 int snd_pcm_generic_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t * info);
+int snd_pcm_generic_channel_info_no_buffer(snd_pcm_t *pcm, snd_pcm_channel_info_t * info);
 int snd_pcm_generic_status(snd_pcm_t *pcm, snd_pcm_status_t * status);
 snd_pcm_state_t snd_pcm_generic_state(snd_pcm_t *pcm);
 int snd_pcm_generic_prepare(snd_pcm_t *pcm);
diff -ur alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_local.h alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_local.h
--- alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_local.h	2005-05-23 10:03:19.000000000 +0100
+++ alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_local.h	2005-09-02 17:36:40.000000000 +0100
@@ -212,7 +212,9 @@
 	snd_pcm_rbptr_t hw;
 	snd_pcm_uframes_t min_align;
 	unsigned int mmap_rw: 1;	/* use always mmapped buffer */
-	unsigned int mmap_shadow: 1;	/* don't call actual mmap */
+	unsigned int mmap_shadow: 1;	/* don't call actual mmap,
+					 * use the mmaped buffer of the slave
+					 */
 	unsigned int donot_close: 1;	/* don't close this PCM */
 	snd_pcm_channel_info_t *mmap_channels;
 	snd_pcm_channel_area_t *running_areas;
@@ -266,7 +268,10 @@
 				      snd_pcm_xfer_areas_func_t func);
 snd_pcm_sframes_t snd_pcm_read_mmap(snd_pcm_t *pcm, snd_pcm_uframes_t size);
 snd_pcm_sframes_t snd_pcm_write_mmap(snd_pcm_t *pcm, snd_pcm_uframes_t size);
-int snd_pcm_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t *info);
+static inline int snd_pcm_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t *info)
+{
+	return pcm->ops->channel_info(pcm, info);
+}
 int snd_pcm_channel_info_shm(snd_pcm_t *pcm, snd_pcm_channel_info_t *info, int shmid);
 int _snd_pcm_poll_descriptor(snd_pcm_t *pcm);
 int _snd_pcm_link_descriptors(snd_pcm_t *pcm, int *fds, int size, int (**failed)(snd_pcm_t *, int));
diff -ur alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_mmap.c alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_mmap.c
--- alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_mmap.c	2005-05-23 10:04:15.000000000 +0100
+++ alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_mmap.c	2005-09-02 17:36:40.000000000 +0100
@@ -262,11 +262,6 @@
 				  snd_pcm_mmap_read_areas);
 }
 
-int snd_pcm_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t *info)
-{
-	return pcm->ops->channel_info(pcm, info);
-}
-
 int snd_pcm_channel_info_shm(snd_pcm_t *pcm, snd_pcm_channel_info_t *info, int shmid)
 {
 	switch (pcm->access) {
diff -ur alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_null.c alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_null.c
--- alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_null.c	2005-06-28 11:24:45.000000000 +0100
+++ alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_null.c	2005-09-02 17:36:40.000000000 +0100
@@ -79,11 +79,6 @@
 	return 0;
 }
 
-static int snd_pcm_null_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t * info)
-{
-	return snd_pcm_channel_info_shm(pcm, info, -1);
-}
-
 static int snd_pcm_null_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 {
 	snd_pcm_null_t *null = pcm->private_data;
@@ -276,16 +271,6 @@
 	return 0;
 }
 
-static int snd_pcm_null_mmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
-{
-	return 0;
-}
-
-static int snd_pcm_null_munmap(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
-{
-	return 0;
-}
-
 static void snd_pcm_null_dump(snd_pcm_t *pcm, snd_output_t *out)
 {
 	snd_output_printf(out, "Null PCM\n");
@@ -302,12 +287,12 @@
 	.hw_params = snd_pcm_null_hw_params,
 	.hw_free = snd_pcm_null_hw_free,
 	.sw_params = snd_pcm_null_sw_params,
-	.channel_info = snd_pcm_null_channel_info,
+	.channel_info = snd_pcm_generic_channel_info,
 	.dump = snd_pcm_null_dump,
 	.nonblock = snd_pcm_null_nonblock,
 	.async = snd_pcm_null_async,
-	.mmap = snd_pcm_null_mmap,
-	.munmap = snd_pcm_null_munmap,
+	.mmap = snd_pcm_generic_mmap,
+	.munmap = snd_pcm_generic_munmap,
 };
 
 static snd_pcm_fast_ops_t snd_pcm_null_fast_ops = {
diff -ur alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_plug.c alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_plug.c
--- alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_plug.c	2005-05-24 15:14:35.000000000 +0100
+++ alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_plug.c	2005-09-02 17:36:40.000000000 +0100
@@ -917,26 +917,6 @@
 	return err;
 }
 
-static int snd_pcm_plug_mmap(snd_pcm_t *pcm)
-{
-	snd_pcm_plug_t *plug = pcm->private_data;
-	pcm->mmap_channels = plug->gen.slave->mmap_channels;
-	pcm->running_areas = plug->gen.slave->running_areas;
-	pcm->stopped_areas = plug->gen.slave->stopped_areas;
-	pcm->mmap_shadow = 1;
-	return 0;
-}
-
-static int snd_pcm_plug_munmap(snd_pcm_t *pcm)
-{
-	// snd_pcm_plug_t *plug = pcm->private_data;
-	pcm->mmap_channels = NULL;
-	pcm->running_areas = NULL;
-	pcm->stopped_areas = NULL;
-	pcm->mmap_shadow = 0;
-	return 0;
-}
-
 static void snd_pcm_plug_dump(snd_pcm_t *pcm, snd_output_t *out)
 {
 	snd_pcm_plug_t *plug = pcm->private_data;
@@ -955,8 +935,8 @@
 	.dump = snd_pcm_plug_dump,
 	.nonblock = snd_pcm_generic_nonblock,
 	.async = snd_pcm_generic_async,
-	.mmap = snd_pcm_plug_mmap,
-	.munmap = snd_pcm_plug_munmap,
+	.mmap = snd_pcm_generic_mmap,
+	.munmap = snd_pcm_generic_munmap,
 };
 
 /**
@@ -1010,6 +990,7 @@
 	pcm->private_data = plug;
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
+	pcm->mmap_shadow = 1;
 	snd_pcm_link_hw_ptr(pcm, slave);
 	snd_pcm_link_appl_ptr(pcm, slave);
 	*pcmp = pcm;
diff -ur alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_rate.c alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_rate.c
--- alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_rate.c	2005-05-24 15:14:36.000000000 +0100
+++ alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_rate.c	2005-09-02 17:36:40.000000000 +0100
@@ -620,11 +620,6 @@
 	return snd_pcm_hw_free(rate->gen.slave);
 }
 
-static int snd_pcm_rate_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t * info)
-{
-	return snd_pcm_channel_info_shm(pcm, info, -1);
-}
-
 static void recalc(snd_pcm_t *pcm, snd_pcm_uframes_t *val)
 {
 	snd_pcm_rate_t *rate = pcm->private_data;
@@ -1393,7 +1388,7 @@
 	.hw_params = snd_pcm_rate_hw_params,
 	.hw_free = snd_pcm_rate_hw_free,
 	.sw_params = snd_pcm_rate_sw_params,
-	.channel_info = snd_pcm_rate_channel_info,
+	.channel_info = snd_pcm_generic_channel_info,
 	.dump = snd_pcm_rate_dump,
 	.nonblock = snd_pcm_generic_nonblock,
 	.async = snd_pcm_generic_async,
diff -ur alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_softvol.c alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_softvol.c
--- alsa-lib.2005-9-2-17-00-00/src/pcm/pcm_softvol.c	2005-05-24 15:14:36.000000000 +0100
+++ alsa-lib.2005-9-2-17-39-00/src/pcm/pcm_softvol.c	2005-09-02 17:36:40.000000000 +0100
@@ -658,6 +658,12 @@
 	pcm->private_data = svol;
 	pcm->poll_fd = slave->poll_fd;
 	pcm->poll_events = slave->poll_events;
+	/*
+	 * Since the softvol converts on the place, and the format/channels
+	 * must be identical between source and destination, we don't need
+	 * an extra buffer.
+	 */
+	pcm->mmap_shadow = 1;
 	snd_pcm_set_hw_ptr(pcm, &svol->plug.hw_ptr, -1, 0);
 	snd_pcm_set_appl_ptr(pcm, &svol->plug.appl_ptr, -1, 0);
 	*pcmp = pcm;

--------------010301080808060801000406--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
