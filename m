From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: Re: pcm_jack plugin attempt
Date: Wed, 12 Feb 2003 18:58:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030212185838.15069c79.mdeboer@iua.upf.es>
References: <20030211183624.31306337.mdeboer@iua.upf.es>
	<Pine.LNX.4.44.0302121012390.14550-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__12_Feb_2003_18:58:38_+0100_083571c8"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302121012390.14550-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart_Wed__12_Feb_2003_18:58:38_+0100_083571c8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > I now have pmc->jack playback working nicely! Tomorrow I will do capture,
> > which should be a piece of cake. 

Hmmm.. Something broke. After doing a CVS update, everything stopped
working. I reverted to yesterday's CVS, and it worked again. I'll
explain what happens, maybe you see how your changes are involved here,
and how to fix it (in my code, most likely)

Yesterday, I got a couple of calls to my snd_pcm_jack_mmap_commit, a
call to snd_pcm_jack_start, where I started the jack process, and I
continued receiving snd_pcm_jack_mmap_commit calls, where I forwarded
the appl_ptr (with snd_pcm_mmap_appl_forward). The jack process copies
copies snd_pcm_mmap_areas(pcm) from the snd_pcm_mmap_hw_offset(pcm) to
the jack buffer, and forwards the hw_ptr (snd_pcm_mmap_hw_forward).
snd_pcm_jack_avail_update(snd_pcm_t *pcm) simple returns
snd_pcm_mmap_avail(pcm). This worked fine (with aplay -Dmyplug, where

pcm.myplug
{
        type plug
        slave
        {
                pcm "myjack"
        }
}

pcm.myjack
{
        type jack
}


This is, as I understand, how we concluded in our previous mails.

Now, today, after a CVS update, I don't get any snd_pcm_jack_mmap_commit
anymore after the snd_pcm_jack_start. Why? The result obviously is that
only the data that has been written to the mmap areas before the start
get copied in a loop to jack.

> > One question. For testing I use aplay, which now uses almost 100% cpu. Adding
> > a usleep in snd_pcm_jack_delay solves that problem, but I am sure it is not
> > the right way. How should I do it?
> 
> Do you handle "poll" in your plugin? Initialize "pcm->poll_fd", 
> "pcm->poll_events" and make your own "poll_revents" callback if necessary.
> The thread which manages the jack transfers have to acknowlede that there 
> is some room (or data - capture) in the ring buffer.

poll_revents is a pretty recent addition isn't it? 

What I try now is
- create a socketpair
- set pcm->poll_fd to one end of the socketpair
- writing 1 byte into the other in the jack process callback
- read this 1 byte in the poll_revents callback (if not, poll keeps
  returned true)

Is this the way to go?

> > If I send you my code - once I have capture working - could you have a look at
> > it?
> 
> Yes, of course. I can put your sources to CVS immediately and we can 
> improve it then.

Which would mean I would have CVS write access?

I attach my src/pcm/pcm_jack.c and a patch with the other changes. I added a --with-jack
option to configure jack support.

Maarten


--Multipart_Wed__12_Feb_2003_18:58:38_+0100_083571c8
Content-Type: text/plain;
 name="alsa_12-02-03-18h54.diff"
Content-Disposition: attachment;
 filename="alsa_12-02-03-18h54.diff"
Content-Transfer-Encoding: 7bit

? ltconfig
? src/pcm/pcm_jack.c
Index: configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/configure.in,v
retrieving revision 1.94
diff -u -r1.94 configure.in
--- configure.in	29 Jan 2003 10:40:07 -0000	1.94
+++ configure.in	12 Feb 2003 17:55:07 -0000
@@ -106,6 +106,20 @@
   AC_MSG_RESULT(no)
 fi
 
+dnl Check for jack...
+AC_MSG_CHECKING(for jack)
+AC_ARG_WITH(jack,
+  [  --with-jack=yes,no     library will (not) be compiled with asserts],
+  jack="$withval", jack="no")
+if test "$jack" = "yes"; then
+  AC_DEFINE(USE_JACK,1,[using jack])
+  LIBJACK=-ljack
+  AC_MSG_RESULT(yes)
+else
+  AC_MSG_RESULT(no)
+fi
+AC_SUBST(LIBJACK)
+
 dnl Check for softfloat...
 AC_MSG_CHECKING(for softfloat)
 AC_ARG_WITH(softfloat,
Index: aserver/Makefile.am
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/aserver/Makefile.am,v
retrieving revision 1.1
diff -u -r1.1 Makefile.am
--- aserver/Makefile.am	26 Sep 2000 09:46:05 -0000	1.1
+++ aserver/Makefile.am	12 Feb 2003 17:55:07 -0000
@@ -2,7 +2,7 @@
 bin_PROGRAMS = aserver
 aserver_SOURCES = aserver.c
 # aserver_LDADD = -lasound
-aserver_LDADD = ../src/libasound.la
+aserver_LDADD = ../src/libasound.la $(LIBJACK)
 
 all: aserver
 
Index: include/pcm.h
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/include/pcm.h,v
retrieving revision 1.171
diff -u -r1.171 pcm.h
--- include/pcm.h	5 Feb 2003 21:26:14 -0000	1.171
+++ include/pcm.h	12 Feb 2003 17:55:09 -0000
@@ -346,6 +346,8 @@
 	SND_PCM_TYPE_LINEAR_FLOAT,
 	/** LADSPA integration plugin */
 	SND_PCM_TYPE_LADSPA,
+	/** Jack PCM */
+	SND_PCM_TYPE_JACK,
 	/** Direct Mixing plugin */
 	SND_PCM_TYPE_DMIX
 };
Index: include/pcm_plugin.h
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/include/pcm_plugin.h,v
retrieving revision 1.5
diff -u -r1.5 pcm_plugin.h
--- include/pcm_plugin.h	24 Apr 2002 14:49:25 -0000	1.5
+++ include/pcm_plugin.h	12 Feb 2003 17:55:10 -0000
@@ -172,6 +172,15 @@
 			snd_pcm_stream_t stream, int mode);
 
 /*
+ *  Jack plugin
+ */
+int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
+			snd_pcm_stream_t stream, int mode);
+int _snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
+			snd_config_t *root, snd_config_t *conf,
+			snd_pcm_stream_t stream, int mode);
+
+/*
  *  LADSPA plugin
  */
 int snd_pcm_ladspa_open(snd_pcm_t **pcmp, const char *name,
Index: src/pcm/Makefile.am
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/Makefile.am,v
retrieving revision 1.40
diff -u -r1.40 Makefile.am
--- src/pcm/Makefile.am	4 Feb 2003 14:48:51 -0000	1.40
+++ src/pcm/Makefile.am	12 Feb 2003 17:55:10 -0000
@@ -8,7 +8,7 @@
 		    pcm_rate.c pcm_plug.c pcm_misc.c pcm_mmap.c pcm_multi.c \
 	            pcm_shm.c pcm_file.c pcm_null.c pcm_share.c \
 		    pcm_meter.c pcm_hooks.c pcm_lfloat.c pcm_ladspa.c \
-		    pcm_dmix.c pcm_symbols.c
+		    pcm_dmix.c pcm_jack.c pcm_symbols.c
 noinst_HEADERS = pcm_local.h pcm_plugin.h mask.h mask_inline.h \
 	         interval.h interval_inline.h plugin_ops.h ladspa.h
 
Index: src/pcm/pcm_plug.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_plug.c,v
retrieving revision 1.121
diff -u -r1.121 pcm_plug.c
--- src/pcm/pcm_plug.c	11 Feb 2003 18:14:49 -0000	1.121
+++ src/pcm/pcm_plug.c	12 Feb 2003 17:55:12 -0000
@@ -627,8 +627,8 @@
 static int snd_pcm_plug_hw_refine_sprepare(snd_pcm_t *pcm, snd_pcm_hw_params_t *sparams)
 {
 	snd_pcm_plug_t *plug = pcm->private_data;
-	_snd_pcm_hw_params_any(sparams);
 	int err;
+	_snd_pcm_hw_params_any(sparams);
 	
 	if (plug->sformat >= 0) {
 		_snd_pcm_hw_params_set_format(sparams, plug->sformat);

--Multipart_Wed__12_Feb_2003_18:58:38_+0100_083571c8
Content-Type: text/x-csrc;
 name="pcm_jack.c"
Content-Disposition: attachment;
 filename="pcm_jack.c"
Content-Transfer-Encoding: 7bit

/**
 * \file pcm/pcm_jack.c
 * \ingroup PCM_Plugins
 * \brief PCM Jack Plugin Interface
 * \author Maarten de Boer <mdeboer@iua.upf.es>
 * \date 2003
 */
/*
 *  PCM - File plugin
 *  Copyright (c) 2003 by Maarten de Boer <mdeboer@iua.upf.es>
 *
 *
 *   This library is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Lesser General Public License as
 *   published by the Free Software Foundation; either version 2.1 of
 *   the License, or (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Lesser General Public License for more details.
 *
 *   You should have received a copy of the GNU Lesser General Public
 *   License along with this library; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 *
 */
  
#include <byteswap.h>
#include <sys/shm.h>
#include <sys/types.h>
#include <sys/socket.h>
#include "pcm_local.h"
#ifdef USE_JACK
#include <jack/jack.h>
#endif

#ifndef PIC
/* entry for static linking */
const char *_snd_module_pcm_jack = "";
#endif

#ifndef DOC_HIDDEN

typedef enum _jack_format {
	SND_PCM_JACK_FORMAT_RAW
} snd_pcm_jack_format_t;

typedef struct {
	char *fname;
	int fd;
	int format;
	snd_timestamp_t trigger_tstamp;
	snd_pcm_state_t state;
	snd_pcm_uframes_t appl_ptr;
	snd_pcm_uframes_t hw_ptr;

#ifdef USE_JACK
	jack_port_t **ports;
	jack_client_t *client;
#endif
} snd_pcm_jack_t;

#endif /* DOC_HIDDEN */

static void snd_pcm_jack_add_frames(snd_pcm_t *pcm, 
				    const snd_pcm_channel_area_t *areas,
				    snd_pcm_uframes_t offset,
				    snd_pcm_uframes_t frames)
{
	snd_pcm_jack_t *jack = pcm->private_data;

	printf("snd_pcm_jack_add_frames %d %d\n",offset,frames); fflush(stdout);

	while (frames > 0) {
		snd_pcm_uframes_t n = frames;

		snd_pcm_mmap_appl_forward(pcm, n);

		frames -= n;
	}
}

static int snd_pcm_jack_close(snd_pcm_t *pcm)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	int err = 0;

	printf("snd_pcm_jack_close\n"); fflush(stdout);

	free(jack);
	return err;
}

static int snd_pcm_jack_nonblock(snd_pcm_t *pcm, int nonblock)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	printf("snd_pcm_jack_nonblock\n"); fflush(stdout);
	return 0;
}

static int snd_pcm_jack_async(snd_pcm_t *pcm, int sig, pid_t pid)
{
	printf("snd_pcm_jack_async\n"); fflush(stdout);
	return -ENOSYS;
}

static int snd_pcm_jack_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int nfds, unsigned short *revents)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	unsigned short events;
	char buf[1];
	
	printf("snd_pcm_jack_poll_revents\n"); fflush(stdout);
	
	assert(pfds && nfds == 1 && revents);

	read(pfds[0].fd, buf, 1);

	*revents = pfds[0].revents;
	return 0;
}

static int snd_pcm_jack_info(snd_pcm_t *pcm, snd_pcm_info_t * info)
{
	printf("snd_pcm_jack_info\n"); fflush(stdout);
	memset(info, 0, sizeof(*info));
	info->stream = pcm->stream;
	info->card = -1;
	strncpy(info->id, pcm->name, sizeof(info->id));
	strncpy(info->name, pcm->name, sizeof(info->name));
	strncpy(info->subname, pcm->name, sizeof(info->subname));
	info->subdevices_count = 1;
	return 0;
}

static int snd_pcm_jack_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t * info)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	printf("snd_pcm_jack_channel_info\n"); fflush(stdout);
	return snd_pcm_channel_info_shm(pcm, info, -1);
}

static int snd_pcm_jack_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	printf("snd_pcm_jack_status\n"); fflush(stdout);
	memset(status, 0, sizeof(*status));
	status->state = jack->state;
	status->trigger_tstamp = jack->trigger_tstamp;
	gettimeofday(&status->tstamp, 0);
	status->avail = pcm->buffer_size;
	status->avail_max = status->avail;
	return 0;
}

static snd_pcm_state_t snd_pcm_jack_state(snd_pcm_t *pcm)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	printf("snd_pcm_jack_state\n"); fflush(stdout);
	return jack->state;
}

static int snd_pcm_jack_hwsync(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
{
	printf("snd_pcm_jack_hwsync\n"); fflush(stdout);
	return 0;
}

static int snd_pcm_jack_delay(snd_pcm_t *pcm ATTRIBUTE_UNUSED, snd_pcm_sframes_t *delayp)
{
	printf("snd_pcm_jack_delay\n"); fflush(stdout);

	usleep(1000); /* TODO: THIS IS NOT THE WAY TO DO THINGS! */
	*delayp = 0;
	return 0;
}

#ifdef USE_JACK
int
snd_pcm_jack_process_cb (jack_nframes_t nframes, snd_pcm_t *pcm)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	const snd_pcm_channel_area_t *areas;
	snd_pcm_uframes_t xfer = 0;
	snd_pcm_channel_area_t area;	
	char buf[1];

	area.addr = jack_port_get_buffer (jack->ports[0], nframes);
	area.first = 0;
	area.step = pcm->sample_bits;
	
	areas = snd_pcm_mmap_areas(pcm);
	
	while (xfer < nframes)
	{
		snd_pcm_uframes_t frames = nframes - xfer;
		snd_pcm_uframes_t offset = snd_pcm_mmap_hw_offset(pcm);
		snd_pcm_uframes_t cont = pcm->buffer_size - offset;
		
		if (cont < frames)
			frames = cont;

		printf("snd_pcm_jack_process_cb hw=%d=%d + nframes=%d / frames=%d / bufsize=%d\n",
			offset,jack->hw_ptr,nframes,frames,pcm->buffer_size); fflush(stdout);

		snd_pcm_area_copy(&area, xfer, &areas[0], offset, frames, pcm->format);
		
		snd_pcm_mmap_hw_forward(pcm,frames);
		xfer += frames;
	}
	write(jack->fd,buf,1); /* for polling */

	printf("jack_process = %d\n",snd_pcm_mmap_hw_offset(pcm)); fflush(stdout);
	
	return 0;      
}
#endif

static int snd_pcm_jack_prepare(snd_pcm_t *pcm)
{
	int i;
	
	snd_pcm_jack_t *jack = pcm->private_data;
	printf("snd_pcm_jack_prepare\n"); fflush(stdout);
	jack->state = SND_PCM_STATE_PREPARED;
	*pcm->appl.ptr = 0;
	*pcm->hw.ptr = 0;

	jack->appl_ptr = jack->hw_ptr = 0;

#ifdef USE_JACK
	jack->ports = calloc (pcm->channels, sizeof(jack_port_t*));
	for (i = 0; i < pcm->channels; i++)
	{
		char port_name[32];
		sprintf(port_name,"chn%03d\n",i);
		jack->ports[i] = jack_port_register (
			jack->client, port_name, JACK_DEFAULT_AUDIO_TYPE, JackPortIsOutput, 0);
	}

	jack_set_process_callback (jack->client,
		(JackProcessCallback)snd_pcm_jack_process_cb, pcm);
	jack_activate (jack->client);

	for (i = 0; i < pcm->channels; i++)
	{
		if (jack_connect (jack->client, jack_port_name (jack->ports[i]), "alsa_pcm:playback_1"))
		{
			fprintf (stderr, "cannot connect output ports\n");
			exit(-1);
		}else{
			printf("connected %s to alsa_pcm:playback_1",jack_port_name(jack->ports[i]));
		}
	}
#endif

	return 0;
}

static int snd_pcm_jack_reset(snd_pcm_t *pcm)
{
	printf("snd_pcm_jack_reset\n"); fflush(stdout);
	*pcm->appl.ptr = 0;
	*pcm->hw.ptr = 0;
	return 0;
}

static int snd_pcm_jack_start(snd_pcm_t *pcm)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	assert(jack->state == SND_PCM_STATE_PREPARED);

	printf("snd_pcm_jack_start\n"); fflush(stdout);
	
	jack->state = SND_PCM_STATE_RUNNING;

	return 0;
}

static int snd_pcm_jack_drop(snd_pcm_t *pcm)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	printf("snd_pcm_jack_drop\n"); fflush(stdout);
	assert(jack->state != SND_PCM_STATE_OPEN);
	jack->state = SND_PCM_STATE_SETUP;
	return 0;
}

static int snd_pcm_jack_drain(snd_pcm_t *pcm)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	printf("snd_pcm_jack_drain\n"); fflush(stdout);
	assert(jack->state != SND_PCM_STATE_OPEN);
	jack->state = SND_PCM_STATE_SETUP;
	return 0;
}

static int snd_pcm_jack_pause(snd_pcm_t *pcm, int enable)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	printf("snd_pcm_jack_pause\n"); fflush(stdout);
	if (enable) {
		if (jack->state != SND_PCM_STATE_RUNNING)
			return -EBADFD;
	} else if (jack->state != SND_PCM_STATE_PAUSED)
		return -EBADFD;
	jack->state = SND_PCM_STATE_PAUSED;
	return 0;
}

static snd_pcm_sframes_t snd_pcm_jack_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	snd_pcm_uframes_t n = snd_pcm_frames_to_bytes(pcm, frames);
	snd_pcm_sframes_t ptr;
	printf("snd_pcm_jack_rewind\n"); fflush(stdout);
	return n;
}

static int snd_pcm_jack_resume(snd_pcm_t *pcm)
{
	return 0;
}

static snd_pcm_sframes_t snd_pcm_jack_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	snd_pcm_channel_area_t areas[pcm->channels];
	printf("snd_pcm_jack_writei\n"); fflush(stdout);
	return size;
}

static snd_pcm_sframes_t snd_pcm_jack_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	snd_pcm_channel_area_t areas[pcm->channels];
	printf("snd_pcm_jack_writen\n"); fflush(stdout);
	return size;
}

static snd_pcm_sframes_t snd_pcm_jack_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	printf("snd_pcm_jack_readi\n"); fflush(stdout);
	return -1;
}

static snd_pcm_sframes_t snd_pcm_jack_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	printf("snd_pcm_jack_readn\n"); fflush(stdout);
	return -1;
}

static snd_pcm_sframes_t snd_pcm_jack_mmap_commit(snd_pcm_t *pcm,
	snd_pcm_uframes_t offset,
	snd_pcm_uframes_t size)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	const snd_pcm_channel_area_t *areas;
	areas = snd_pcm_mmap_areas(pcm);
	
	printf("snd_pcm_jack_mmap_commit\n"); fflush(stdout);
	snd_pcm_jack_add_frames(pcm, areas, offset, size);

	return size;
}

static snd_pcm_sframes_t snd_pcm_jack_avail_update(snd_pcm_t *pcm)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	int ret = snd_pcm_mmap_avail(pcm);
	printf("snd_pcm_jack_avail_update appl=%d hw=%d ret=%d\n",jack->appl_ptr,jack->hw_ptr,ret); fflush(stdout);
	return ret;
}

static inline snd_mask_t *hw_param_mask(snd_pcm_hw_params_t *params,
					snd_pcm_hw_param_t var)
{
	return &params->masks[var - SND_PCM_HW_PARAM_FIRST_MASK];
}

static inline snd_interval_t *hw_param_interval(snd_pcm_hw_params_t *params,
						snd_pcm_hw_param_t var)
{
	return &params->intervals[var - SND_PCM_HW_PARAM_FIRST_INTERVAL];
}

static int snd_pcm_jack_hw_refine(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
{
	int err;
	snd_pcm_jack_t *jack = pcm->private_data;

	static snd_mask_t access = { .bits = { 
					(1<<SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) |
					(1<<SNDRV_PCM_ACCESS_MMAP_NONINTERLEAVED) |
					(1<<SNDRV_PCM_ACCESS_RW_INTERLEAVED) |
					(1<<SNDRV_PCM_ACCESS_RW_NONINTERLEAVED),
					0, 0, 0 } };

	snd_interval_t t;

	snd_pcm_format_mask_t format_mask = { SND_PCM_FMTBIT_FLOAT };
	printf("snd_pcm_jack_hw_refine\n"); fflush(stdout);

	t.openmin = 0;
	t.openmax = 0;
	t.empty = 0;
	t.integer = 1;
	t.min = 44100; /* TODO: get this value from jack */
	t.max = 44100; /* TODO: get this value from jack */

	snd_mask_refine(hw_param_mask(params, SND_PCM_HW_PARAM_ACCESS), &access);

	snd_mask_refine(hw_param_mask(params, SND_PCM_HW_PARAM_FORMAT),
		&format_mask);
	/*** this should work, right? */
	/* snd_interval_refine(hw_param_interval(params,SND_PCM_HW_PARAM_RATE),&t);
	*/
	/*** but it doesn't... the following does... ***/
	err = _snd_pcm_hw_param_set_minmax(params, SND_PCM_HW_PARAM_RATE,
					   44100, 0, 
					   44100, 1);
						 
	if (err < 0)
		return err;

	return 0;
}

static int snd_pcm_jack_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	int err;
	
	printf("snd_pcm_jack_hw_params\n"); fflush(stdout);

	return 0;
}

static int snd_pcm_jack_hw_free(snd_pcm_t *pcm)
{
	printf("snd_pcm_jack_hw_free\n"); fflush(stdout);
	return 0;
}

static int snd_pcm_jack_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t * params)
{
	printf("snd_pcm_jack_sw_params\n"); fflush(stdout);
	return 0;
}

static int snd_pcm_jack_mmap(snd_pcm_t *pcm)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	printf("snd_pcm_jack_mmap\n"); fflush(stdout);

	return 0;
}

static int snd_pcm_jack_munmap(snd_pcm_t *pcm)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	return 0;
}

static void snd_pcm_jack_dump(snd_pcm_t *pcm, snd_output_t *out)
{
	snd_pcm_jack_t *jack = pcm->private_data;
	snd_output_printf(out, "Jack PCM\n", jack->fname);
	if (pcm->setup) {
		snd_output_printf(out, "Its setup is:\n");
		snd_pcm_dump_setup(pcm, out);
	}
}

static snd_pcm_ops_t snd_pcm_jack_ops = {
	close: snd_pcm_jack_close,
	info: snd_pcm_jack_info,
	hw_refine: snd_pcm_jack_hw_refine,
	hw_params: snd_pcm_jack_hw_params,
	hw_free: snd_pcm_jack_hw_free,
	sw_params: snd_pcm_jack_sw_params,
	channel_info: snd_pcm_jack_channel_info,
	dump: snd_pcm_jack_dump,
	nonblock: snd_pcm_jack_nonblock,
	async: snd_pcm_jack_async,
	mmap: snd_pcm_jack_mmap,
	munmap: snd_pcm_jack_munmap,
};

static snd_pcm_fast_ops_t snd_pcm_jack_fast_ops = {
	status: snd_pcm_jack_status,
	state: snd_pcm_jack_state,
	hwsync: snd_pcm_jack_hwsync,
	delay: snd_pcm_jack_delay,
	prepare: snd_pcm_jack_prepare,
	reset: snd_pcm_jack_reset,
	start: snd_pcm_jack_start,
	drop: snd_pcm_jack_drop,
	drain: snd_pcm_jack_drain,
	pause: snd_pcm_jack_pause,
	rewind: snd_pcm_jack_rewind,
	resume: snd_pcm_jack_resume,
	writei: snd_pcm_jack_writei,
	writen: snd_pcm_jack_writen,
	readi: snd_pcm_jack_readi,
	readn: snd_pcm_jack_readn,
	avail_update: snd_pcm_jack_avail_update,
	mmap_commit: snd_pcm_jack_mmap_commit,
};

/**
 * \brief Creates a new jack PCM
 * \param pcmp Returns created PCM handle
 * \param name Name of PCM
 * \param stream Stream type
 * \param mode Stream mode
 * \retval zero on success otherwise a negative error code
 * \warning Using of this function might be dangerous in the sense
 *          of compatibility reasons. The prototype might be freely
 *          changed in future.
 */
int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
	snd_pcm_stream_t stream, int mode)
{
	snd_pcm_t *pcm;
	snd_pcm_jack_t *jack;
	int err;
	int fd[2];
	
	assert(pcmp);
	printf("snd_pcm_jack_open\n"); fflush(stdout);
	if (stream == SND_PCM_STREAM_PLAYBACK) {
	} else {
	}
	jack = calloc(1, sizeof(snd_pcm_jack_t));
	if (!jack) {
		return -ENOMEM;
	}

#ifdef USE_JACK
	jack->client = jack_client_new("alsa");
	if (jack->client==0)
		return -ENOENT;	
#endif

	jack->state = SND_PCM_STATE_OPEN;

	err = snd_pcm_new(&pcm, SND_PCM_TYPE_JACK, name, stream, mode);
	
	if (err < 0) {
		free(jack);
		return err;
	}
	pcm->ops = &snd_pcm_jack_ops;
	pcm->fast_ops = &snd_pcm_jack_fast_ops;
	pcm->private_data = jack;

	socketpair(AF_LOCAL, SOCK_STREAM, 0, fd);
	
	jack->fd = fd[0];
	pcm->poll_fd = fd[1];

	snd_pcm_set_hw_ptr(pcm, &jack->hw_ptr, -1, 0);
	snd_pcm_set_appl_ptr(pcm, &jack->appl_ptr, -1, 0);
	*pcmp = pcm;

	return 0;
}

/*! \page pcm_plugins

\section pcm_plugins_jack Plugin: Jack

*/

/**
 * \brief Creates a new Jack PCM
 * \param pcmp Returns created PCM handle
 * \param name Name of PCM
 * \param root Root configuration node
 * \param conf Configuration node with Jack PCM description
 * \param stream Stream type
 * \param mode Stream mode
 * \retval zero on success otherwise a negative error code
 * \warning Using of this function might be dangerous in the sense
 *          of compatibility reasons. The prototype might be freely
 *          changed in future.
 */
int _snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
		       snd_config_t *root ATTRIBUTE_UNUSED, snd_config_t *conf, 
		       snd_pcm_stream_t stream, int mode)
{
	snd_config_iterator_t i, next;
	snd_config_for_each(i, next, conf) {
		snd_config_t *n = snd_config_iterator_entry(i);
		const char *id;
		if (snd_config_get_id(n, &id) < 0)
			continue;
		if (snd_pcm_conf_generic_id(id))
			continue;
		SNDERR("Unknown field %s", id);
		return -EINVAL;
	}
	return snd_pcm_jack_open(pcmp, name, stream, mode);
}
#ifndef DOC_HIDDEN
SND_DLSYM_BUILD_VERSION(_snd_pcm_jack_open, SND_PCM_DLSYM_VERSION);
#endif

--Multipart_Wed__12_Feb_2003_18:58:38_+0100_083571c8--


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
