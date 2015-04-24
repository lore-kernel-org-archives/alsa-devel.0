From: Mike Ood <jh1ood@gmail.com>
Subject: Re: snd-bebob and PrismSound Orpheus fails with
	snd_pcm_hw_params_set_channels
Date: Fri, 24 Apr 2015 16:30:21 +0900
Message-ID: <CAJ0eYfUB3YtreiufuJOgmwTfeRZE7We3=b9HPo9mMjy9diD6yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f45.google.com (mail-vn0-f45.google.com
 [209.85.216.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 83F32260511
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 09:30:27 +0200 (CEST)
Received: by vnbg62 with SMTP id g62so3365813vnb.7
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 00:30:22 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am now trying with my capture program, "myprog.cpp" instead of "aplay.c".

-------------------------------
% alsacap ; alscap -R
-------------------------------
Card 2, ID `Orpheus', name `Orpheus'
  Device 0, ID `BeBoB', name `Orpheus PCM', 1 subdevices (1 available)
    12 channels, sampling rate 44100..44100 Hz
    Sample formats: S16_LE, S32_LE
      Subdevice 0, name `subdevice #0'

Card 2, ID `Orpheus', name `Orpheus'
  Device 0, ID `BeBoB', name `Orpheus PCM', 1 subdevices (1 available)
    10 channels, sampling rate 44100..44100 Hz
    Sample formats: S32_LE
      Subdevice 0, name `subdevice #0'

-------------------------------
% myprog hw:2,0 44100 10
-------------------------------
Sound::Sound: sound_device = hw:2,0, rate = 44100, channels = 10
Sound::asound_set_hwparams: begin...
Sound::asound_set_hwparams: buffer_time = 92879, dir   = 1
Sound::asound_set_hwparams: buffer_size = 4096
Sound::asound_set_hwparams: period_time = 46439 , dir   = 1
Sound::asound_set_hwparams: period_size = 2048, dir = 0
Sound::asound_set_hwparams: Unable to set hw params: Connection timed out
Sound::Sound: setting of hwparams failed. Connection timed out

-------------------------------
Sound::asound_set_hwparams(snd_pcm_t *, snd_pcm_hw_params_t *)
-------------------------------
err = snd_pcm_hw_params_any(handle, params);
err = snd_pcm_hw_params_set_rate_resample(handle, params, resample);
err = snd_pcm_hw_params_set_access(handle, params,

err = snd_pcm_hw_params_set_format(handle, params, SND_PCM_FORMAT_S32_LE);
//if Orphesu
err = snd_pcm_hw_params_set_format(handle, params, SND_PCM_FORMAT_S16);
 //else

err = snd_pcm_hw_params_set_channels(handle, params, channels);
err = snd_pcm_hw_params_set_rate_near(handle, params, &rrate, 0);
err = snd_pcm_hw_params_set_buffer_time_near(handle, params, &buffer_time,
err = snd_pcm_hw_params_get_buffer_size(params, &size);
err = snd_pcm_hw_params_set_period_time_near(handle, params, &period_time,
err = snd_pcm_hw_params_get_period_size(params, &size, &dir);

err = snd_pcm_hw_params(handle, params);
if (err < 0) {
cout << "Sound::asound_set_hwparams: Unable to set hw params: "
     << snd_strerror(err) << endl;
return err;
}

-------------------------------
No messages were found in % demsg and % cat /var/log/syslog
concerning the above run of % myprog.

So is it (partly) due to "Connection timed out"?

Mike Ood
