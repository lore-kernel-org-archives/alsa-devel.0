From: Eric Peters <epeters@graphics.cs.uni-sb.de>
Subject: Starting the device manually
Date: Mon, 24 Jul 2006 11:37:56 +0200
Message-ID: <44C494F4.6050301@graphics.cs.uni-sb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dear all,

I'm a bit confused by the alsa documentation. I want to fill up a buffer
of a alsa device with snd_pcm_writei and then if the buffer is full, I
want to be able to start the playback manually. By looking to the
documentation, I found the method snd_pcm_sw_params_set_start_threshold.
In some other messages on this list there was the hint to set this
threshhold larger than the max_buffer_size and then the device shouldn't
start automatically. So I've done. But unfortunately the playback starts
again automatically. Here are the lines of code, I'm setting the
buffer_size and period_size and the start threshhold:

/* determine the buffer size */
if (buffer_time == 0 && buffer_frames == 0) {
   if( snd_pcm_hw_params_get_buffer_time_max(hwparams, &buffer_time, 0)
< 0) {
     return -1;
   }
   if (buffer_time > 500000) {
     buffer_time = 500000;
   }
}

/* calculating the period size depending on the buffer size */
if (period_time == 0 && period_frames == 0) {
   if (buffer_time > 0) {
     period_time = buffer_time / 4;
   } else {
     period_frames = buffer_frames / 4;
   }
}

/* setting the period size according to the buffer size */
if (period_time > 0) {
   if (snd_pcm_hw_params_set_period_time_near(pcm_handle, hwparams,
&period_time, 0) < 0) {
     return -1;
   }
} else {
   if ( snd_pcm_hw_params_set_period_size_near(pcm_handle, hwparams,
&period_frames, 0) < 0) {
     return -1;
   }
}

/* setting the buffer size */
if (buffer_time > 0) {
   if (snd_pcm_hw_params_set_buffer_time_near(pcm_handle, hwparams,
&buffer_time, 0) < 0) {
     return -1;
   }
} else {
   if ( snd_pcm_hw_params_set_buffer_size_near(pcm_handle, hwparams,
&buffer_frames) < 0) {
     return -1;
   }
}

/* calculating the number of frames of a buffer and a period */
buffer_frames = buffer_time * sample_rate;
period_frames = period_time * sample_rate;


/* setting the start threshhold in frames */
int err = 0;
/*Init swparams */
if ((err = snd_pcm_sw_params_malloc (&swparams)) < 0) {
   return -1;
}

if ((err = snd_pcm_sw_params_current(pcm_handle, swparams)) < 0) {
   return -1;
}

if ((err = snd_pcm_sw_params_set_start_threshold(pcm_handle, swparams,
2*buffer_frames)) < 0) {
   return FAILURE;
}

err = snd_pcm_sw_params(pcm_handle, swparams);
if (err < 0) {
   return -1;
}

Here are some specifications of the system I'm using:

- SuSE 9.3 with all updates and patches
- ALSA version 1.0.9a
- sound board Audigy 4 PRO [SB0380]
- chip SigmaTel STAC9750,51

Now some questions:
- Where is the failure in my implementation?
- I think, if I don't call snd_pcm_start there should be no output if
the start threshold is larger than the max_buffer_size. Is this correct?
- Is it possible that the starting behaviour depends on the hardware I'm
using?
- Do you have other hints so I can start my playback manually on a
timepoint I want?

Best regards,
Eric


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
