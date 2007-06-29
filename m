From: "J. Scott Merritt" <alsauser@pragmasoft.com>
Subject: SALSA-Lib: Playback Select/Poll not effective
Date: Fri, 29 Jun 2007 13:10:07 -0400
Message-ID: <20070629131007.2d36fcc6.alsauser@pragmasoft.com>
References: <20070628150108.271f4493.alsauser@pragmasoft.com>
	<s5hmyyjcdtv.wl%tiwai@suse.de>
	<20070629112409.27e67cea.alsauser@pragmasoft.com>
	<s5hbqeyd9s7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp7.server.rpi.edu (smtp7.server.rpi.edu [128.113.2.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 486D910380F
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2007 19:07:02 +0200 (CEST)
In-Reply-To: <s5hbqeyd9s7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear List,

Using SALSA-Lib 0.0.4, I call:	

snd_pcm_open (&playback_handle, argv[1], SND_PCM_STREAM_PLAYBACK, O_NONBLOCK);
snd_pcm_hw_params_malloc (&hw_params)
snd_pcm_hw_params_any (playback_handle, hw_params)
snd_pcm_hw_params_set_access (playback_handle, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED)
snd_pcm_hw_params_set_format (playback_handle, hw_params, SND_PCM_FORMAT_S16_LE)
snd_pcm_hw_params_set_rate (playback_handle, hw_params, 16000, 0)
snd_pcm_hw_params_set_channels (playback_handle, hw_params, 2)
snd_pcm_hw_params_set_buffer_size_last (playback_handle, hw_params, &bfrsize)
snd_pcm_hw_params_set_period_size (playback_handle, hw_params, 1024, 0)
snd_pcm_hw_params (playback_handle, hw_params)
snd_pcm_hw_params_free (hw_params);
	
snd_pcm_sw_params_malloc (&sw_params)
snd_pcm_sw_params_current (playback_handle, sw_params)
snd_pcm_sw_params_set_avail_min (playback_handle, sw_params, 1024)
snd_pcm_sw_params_set_start_threshold (playback_handle, sw_params, 4096U)
snd_pcm_sw_params (playback_handle, sw_params)
	
snd_pcm_prepare (playback_handle)

int pdcount = snd_pcm_poll_descriptors_count (playback_handle);
struct pollfd fds [10];
pdcount = snd_pcm_poll_descriptors (playback_handle, fds, 10);

while ((frames_to_deliver = snd_pcm_avail_update (playback_handle)) > 1024) {
   snd_pcm_writei (playback_handle, &buf, 1024) } 

while (1) {
   retval = poll (fds, 1, 5000);

   frames_to_deliver = snd_pcm_avail_update (playback_handle);
   fprintf (stderr, "Frames to deliver was: %ld\n", frames_to_deliver);

   frames_to_deliver = frames_to_deliver > 4096 ? 4096 : frames_to_deliver;
   playback_callback (frames_to_deliver);
}


The "retval = poll (fds, 1, 5000)" statement does not appear to wait for the
playback buffer to be sufficiently emptied.  When this same program is run with
the standard alsa-lib, the POLL statement will wait until there is room in the
buffer to accomodate 1024 additional samples.  When run with SALSA-lib, it
appears to return immediately and snd_pcm_avail_update indicates that there
is only space for about 80 more samples.

The code is being cross-compiled and tested on an ARM processor
(PXA270) which is running linux kernel 2.6.21.   This same code sequence
-does- operate properly (in the same ARM test environment) when compiled
against AlsaLib 1.0.13.

Another apparent (and perhaps relevent) difference between AlsaLib and
SALSA-Lib is that if I open the PCM stream with O_NONBLOCK and then call
snd_pcm_poll_descriptors, AlsaLib gives me a FD = 4, whereas SALSA-Lib
reports an FD = 3;

Thanks, Scott.
