From: "J. Scott Merritt" <alsauser@pragmasoft.com>
Subject: SALSA-Lib: Playback overrun on initial PCM start
Date: Thu, 28 Jun 2007 15:01:08 -0400
Message-ID: <20070628150108.271f4493.alsauser@pragmasoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp8.server.rpi.edu (smtp8.server.rpi.edu [128.113.2.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E34C10383E
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2007 20:58:04 +0200 (CEST)
Received: from RPI02.localdomain (voiceflight.inc.rpi.edu [128.113.36.139])
	by smtp8.server.rpi.edu (8.13.1/8.13.1) with SMTP id l5SIw3o6020433
	for <alsa-devel@alsa-project.org>; Thu, 28 Jun 2007 14:58:03 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear List,

Using SALSA-Lib 0.0.3, I call:	

snd_pcm_open (&playback_handle, argv[1], SND_PCM_STREAM_PLAYBACK, 0);
snd_pcm_hw_params_malloc (&hw_params);
snd_pcm_hw_params_any (playback_handle, hw_params);
snd_pcm_hw_params_set_access (playback_handle, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED);
snd_pcm_hw_params_set_format (playback_handle, hw_params, SND_PCM_FORMAT_S16_LE));
snd_pcm_hw_params_set_rate_near (playback_handle, hw_params, 44100, 0);
snd_pcm_hw_params_set_channels (playback_handle, hw_params, 2);
snd_pcm_hw_params_set_buffer_size_last (playback_handle, hw_params, &bfrsize);
snd_pcm_hw_params_get_buffer_size (hw_params, &bfrsize);
snd_pcm_hw_params (playback_handle, hw_params);
snd_pcm_hw_params_free (hw_params);
	
snd_pcm_sw_params_malloc (&sw_params);
snd_pcm_sw_params_current (playback_handle, sw_params);
snd_pcm_sw_params_set_avail_min (playback_handle, sw_params, 4096);
snd_pcm_sw_params_set_start_threshold (playback_handle, sw_params, 10000U);
snd_pcm_sw_params_set_xfer_align (playback_handle, sw_params, 1);
snd_pcm_sw_params (playback_handle, sw_params);
	
state = snd_pcm_state (playback_handle);
frames_to_deliver = snd_pcm_avail_update (playback_handle);

while ((frames_to_deliver = snd_pcm_avail_update (playback_handle)) > 4096) {
   snd_pcm_writei (playback_handle, &buf, 4096) }


As soon as the buffer start threshold is reached, or alternatively
if I manually start PCM stream, the PCM stream reports an overrun
(i.e. "Broken Pipe").  If I then examine the PCM state, it is in the
overrun (XRUN) state.

The code is being cross-compiled and tested on an ARM processor
(PXA270) which is running linux kernel 2.6.21.   This same code sequence
-does- operate properly (in the same ARM test environment) when compiled
against AlsaLib 1.0.13.

Another apparent (and perhaps relevent) difference between AlsaLib and
SALSA-Lib is that if I open the PCM stream with O_NONBLOCK and then call
snd_pcm_poll_descriptors, AlsaLib gives me a FD = 4, whereas SALSA-Lib
reports an FD = 3;

Thanks, Scott.
