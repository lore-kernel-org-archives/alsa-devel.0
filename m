From: ListsAccount <lists@s201431494.online.de>
Subject: reading peak meter values from a RME HDSP madi
	soundcard
Date: Fri, 14 Mar 2008 15:16:11 +0100
Message-ID: <47DA88AB.80205@s201431494.online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188])
	by alsa0.perex.cz (Postfix) with ESMTP id E4CD1243B6
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2008 15:16:13 +0100 (CET)
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

Hi,

I'd like to read the peak values of the RME HDSP madi soundcard. To do
this, I use the function: snd_hwdep_ioctl() with the ioctl command
"SNDRV_HDSPM_IOCTL_GET_PEAK_RMS".

I use the following code:

  // create container
  hdspm_peak_rms_t madi_peak_rms;
  hdspm_peak_rms_t* ptr_madi_peak_rms = &madi_peak_rms;

  //snd_hwdep_open
  ...

  // fill the container with values
  snd_hwdep_ioctl(hw,
                  SNDRV_HDSPM_IOCTL_GET_PEAK_RMS,
                  (void *)&ptr_madi_peak_rms);

  for (unsigned int chn = 0; chn < numberOfChannels; ++chn)
  {
    //put values from madi soundcard into std::vector containers
    currentInputPeak[chn] = madi_peak_rms.level_offset[chn];
    currentPlaybackPeak[chn] = madi_peak_rms.level_offset[chn+64];
    currentOutputPeak[chn] = madi_peak_rms.level_offset[chn+128];
  }

The upper 24 bit of the read out values should be the signal peak. The
next 8 bit seem to represent a clipping counter.

For the first eight input channels this works pretty well. But for every
eighth channel of all further channels (input, playback and output) the
peak value is to low and is not in time with the other channels.


Do i use the function in the right way?

Is there a special function to get the peak meter values? (In a similar
way as for ADAT soundcards?)


Best regards.
