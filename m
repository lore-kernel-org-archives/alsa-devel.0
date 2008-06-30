From: "Mitul Sen (misen)" <misen@cisco.com>
Subject: Setting format to SND_PCM_FORMAT_MU_LAW does not let
	me apply hardware parameters
Date: Mon, 30 Jun 2008 15:09:07 -0700
Message-ID: <3B6F5C9068D5864096EB291236C3386F02CE1628@xmb-sjc-21d.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 638562475C
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jul 2008 00:09:08 +0200 (CEST)
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id m5UM97lO016018
	for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2008 15:09:07 -0700
Received: from xbh-sjc-231.amer.cisco.com (xbh-sjc-231.cisco.com
	[128.107.191.100])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id m5UM970N006479
	for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2008 22:09:07 GMT
Content-class: urn:content-classes:message
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

I am a newbie to ALSA and any help will be much appreciated.

I have an application which sets up the signaling between an IP phone
and my desktop and then sets up the audio path between the two. 

On my desktop application, I am able to receive RTP packets from IP
phone. I use an RTP stack to parse the data and after going through the
RTP stack, I try to play back the audio using ALSA. When I use the ALSA
code to play back (in real time) using sound card of my device, there is
only noise, I cannot hear the audio that I speak into the IP phone.
However, if I take the raw data coming from the RTP stack and write it
to a file, I can play back the file successfully.

Since my data from IP phone is G.711 encoded, I have set the sampling
rate within ALSA to 8000. Also I am using one source (mono) and
non-interleaved data option for preparing ALSA for playback. When I set
the format to SND_PCM_FORMAT_MU_LAW, at runtime it lets me set that
format ie. snd_pcm_hw_params_set_format (for SND_PCM_FORMAT_MU_LAW) is
successful. However I get a runtime error while applying the hardware
parameters using snd_pcm_hw_params(..) if the format set earlier is
SND_PCM_FORMAT_MU_LAW. Using any other format like SND_PCM_FORMAT_U8 or
SND_PCM_FORMAT_S8, lets me apply the hardware parameters but it gives
the problem of the noise (no "audible" voice) that I described earlier.

This is what my ALSA code looks like

***** beginning of code snippet *****************

int err;

snd_pcm_hw_params_t *hw_params;

// Try to open the default device

err = snd_pcm_open( &_soundDevice, "plughw:0,0",
SND_PCM_STREAM_PLAYBACK, 0 );

// Check for error on open.

if( err < 0 )

{

printf("Init: cannot open audio device\n");

return -1;

}

// Allocate the hardware parameter structure.

if ((err = snd_pcm_hw_params_malloc (&hw_params)) < 0)

{

printf("Init: cannot allocate hardware parameter structure\n");

return -1;

}

if ((err = snd_pcm_hw_params_any (_soundDevice, hw_params)) < 0)

{

printf("Init: cannot initialize hardware parameter structure\n");

return -1;

}

// Set access to RW interleaved.

if ((err = snd_pcm_hw_params_set_access (_soundDevice, hw_params,
SND_PCM_ACCESS_RW_NONINTERLEAVED)) < 0)

{

printf("Init: cannot set access type\n");

return -1;

}

if ((err = snd_pcm_hw_params_set_format (_soundDevice, hw_params,
SND_PCM_FORMAT_MU_LAW)) < 0)

{

return -1;

}

// Set channels to mono (1)

if ((err = snd_pcm_hw_params_set_channels (_soundDevice, hw_params, 1))
< 0)

{

return -1;

}

// Set sample rate.

unsigned int actualRate = 8000;

if ((err = snd_pcm_hw_params_set_rate_near (_soundDevice, hw_params,
&actualRate,

0)) < 0)

{

return -1;

}

// Apply the hardware parameters that we've set.

if ((err = snd_pcm_hw_params (_soundDevice, hw_params)) < 0)

{

printf("Audio device parameters have not been set
successfully.(%s)(%s)\n", strerror (err), snd_strerror (err));

return -1;

}

// Free the hardware parameters now that we're done with them.

snd_pcm_hw_params_free (hw_params);

/* Prepare interface for use.

if ((err = snd_pcm_prepare (_soundDevice)) < 0)

{

printf("Audio device not prepared for use\n");

return -1;

}

// If the frames are received...

/* find out how much space is available for playback data

if ((frames_to_deliver = snd_pcm_avail_update (_soundDevice)) < 0)

{

printf("Error returned by snd_pcm_avail_update\n");

}

frames_to_deliver = frames_to_deliver > 4096 ? 4096 : frames_to_deliver;

printf("frames to deliver is %d\n",(int)frames_to_deliver);

*/

frames_to_deliver = 172;

bufs[1] = (void*)buffer;

if ((err = snd_pcm_writen( _soundDevice, bufs, frames_to_deliver)) < 0)

{

printf ("write failed (%s)\n", snd_strerror (err));

}

****************** end of code snippet
**********************************

The error I get is as follows:-

Audio device parameters have not been set successfully.(Unknown error
4294967274)(Invalid argument)

 

Any pointers on what I could be doing wrong? 

Thanks and regards,

Mitul
