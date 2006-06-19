From: Bo Thorsen <bo@thorsen-consulting.dk>
Subject: Sound distortion with snd_pcm_writei
Date: Mon, 19 Jun 2006 14:37:46 +0200
Message-ID: <200606191437.46716.bo@thorsen-consulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
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

Hi people,

I'm currently writing a small player application using alsa, and it's been 
going reasonably well. However, I have hit a problem I don't know how to fix.

I'm using async callbacks to write the sound data. I have the data from a 
bunch of wav files that are stored using 8 bit per sample, and I have set the 
hardware options to this. They have different sample rates, but I read this 
from the file and set it also.

The sound plays as it's supposed to but it's very distorted, and I have no 
clue why that is. I am using an existing wav player to compare my output 
with, and they are similar, but not the same. If one of you have an idea, I'd 
be very happy to hear about it.

I hope you can help me.

Bo Thorsen.

For completeness, here's the code I use to set up alsa:

    int err;
    if ((err = snd_pcm_open(&mPlaybackHandle, "default",
                            SND_PCM_STREAM_PLAYBACK, 0)) < 0)
        qFatal("Can't open audio device. Error: %s", snd_strerror(err));

    snd_pcm_hw_params_t* hwParams;
    if ((err = snd_pcm_hw_params_malloc(&hwParams)) < 0)
        qFatal("Can't allocate hardware parameters. Error: %s",
               snd_strerror(err));

    if ((err = snd_pcm_hw_params_any(mPlaybackHandle, hwParams)) < 0)
        qFatal("Can't initialize hardware parameter structure. Error: %s",
               snd_strerror(err));

    PlayWave* thread = m_AudioPlayer->GetPlayWaveTool();
    if ((err = snd_pcm_hw_params_set_access(mPlaybackHandle, hwParams,
                                            SND_PCM_ACCESS_RW_INTERLEAVED)
            ) < 0)
        qFatal("Can't set access type. Error: %s", snd_strerror(err));

    _snd_pcm_format format;
    switch(thread->WaveBitsPerSample()) {
    case 8: format = SND_PCM_FORMAT_S8; break;
    case 16: format = SND_PCM_FORMAT_U16_LE; break;
    case 24: format = SND_PCM_FORMAT_U24_LE; break;
    case 32: format = SND_PCM_FORMAT_U32_LE; break;
    default: format = SND_PCM_FORMAT_UNKNOWN; break;
    }
    if ((err = snd_pcm_hw_params_set_format(mPlaybackHandle, hwParams,
                                            format)) < 0)
        qFatal("Can't set sample format. Error: %s", snd_strerror(err));

    unsigned int rate = thread->GetWaveAvgBytesPerSec();
    if ((err = snd_pcm_hw_params_set_rate_near(mPlaybackHandle, hwParams,
                                               &rate, 0)) < 0)
        qFatal("Can't set sample rate. Error: %s",  snd_strerror(err));
    mPlaybackRate = rate;

    if ((err = snd_pcm_hw_params_set_channels(mPlaybackHandle, hwParams,
                                              thread->WaveChannels())) < 0)
        qFatal("Can't set channel count. Error: %s", snd_strerror(err));

    unsigned int bufferTime = 500000;
    int dir = 0;
    if ((err = snd_pcm_hw_params_set_buffer_time_near(mPlaybackHandle,
                                                      hwParams, &bufferTime,
                                                      &dir)) < 0)
        qFatal("Error setting buffer time. Error: %s\n", snd_strerror(err));

    mBufferSize = thread->WaveDataSize();

    unsigned int periodTime = 100000;
    if ((err = snd_pcm_hw_params_set_period_time_near(mPlaybackHandle,
                                                      hwParams, &periodTime,
                                                      &dir)) < 0)
        qFatal("Error setting period time. Error: %s\n", snd_strerror(err));

    snd_pcm_uframes_t periodSize;
    if ((err = snd_pcm_hw_params_get_period_size(hwParams, &periodSize, &dir))
        < 0)
        qFatal("Error getting the playback period size. Error: %s\n",
               snd_strerror(err));
    mPeriodSize = periodSize;

    if ((err = snd_pcm_hw_params(mPlaybackHandle, hwParams)) < 0)
        qFatal("Can't set hardware parameters. Error: %s", snd_strerror(err));

    // End of hw params
    snd_pcm_hw_params_free(hwParams);

    // Software params
    snd_pcm_sw_params_t* swParams;
    if ((err = snd_pcm_sw_params_malloc(&swParams)) < 0)
        qDebug("Error making the sw params struct. Error: %s",
               snd_strerror(err));

    if ((err = snd_pcm_sw_params_current(mPlaybackHandle, swParams)) < 0)
        qDebug("Unable to determine current swParams for playback: %s\n",
               snd_strerror(err));

    if ((err = snd_pcm_sw_params_set_start_threshold(mPlaybackHandle,
                                                     swParams,
                                                     (mBufferSize/periodSize)
                                                     * periodSize)
            ) < 0)
        qDebug("Unable to set start threshold mode for playback: %s\n",
               snd_strerror(err));

    if ((err = snd_pcm_sw_params_set_avail_min(mPlaybackHandle, swParams,
                                               periodSize)) < 0)
        qDebug("Unable to set avail min for playback: %s\n",
               snd_strerror(err));

    if ((err = snd_pcm_sw_params_set_xfer_align(mPlaybackHandle,
                                                swParams, 1)) < 0)
        qDebug("Unable to set transfer align for playback: %s\n",
               snd_strerror(err));

    if ((err = snd_pcm_sw_params(mPlaybackHandle, swParams)) < 0)
        qDebug("Unable to set sw params for playback: %s\n",
               snd_strerror(err));

    // End of software params
    snd_pcm_sw_params_free(swParams);

    if ((err = snd_pcm_prepare(mPlaybackHandle)) < 0)
        qFatal("Can't prepare audio interface for playback. Error: %s",
               snd_strerror(err));

    // Set the async callback handler
    if ((err = snd_async_add_pcm_handler(&mCallbackHandle, mPlaybackHandle,
                                         alsaCallback,
                                         static_cast<void*>(this))) < 0)
        qFatal("Unable to register Alsa callback handler. Error: %s\n",
               snd_strerror(err));

And the callback code:

    char* data = m_AudioPlayer->GetPlayWaveTool()->WaveData();
    char* frame = &data[mFramePointer];

    int bytes =
        m_AudioPlayer->GetPlayWaveTool()->WaveDataSize() - mFramePointer;
    if (bytes > mPeriodSize) bytes = mPeriodSize;
    if (bytes < 0) bytes = 0;

    // Update the pointer
    mFramePointer += bytes;

    if (mVolume != 100 || bytes < mPeriodSize) {
        // If the volume isn't 100 or the sound is done, we need to use
        // our own sound buffer
        if (mSoundBufferSize != mPeriodSize)
        {
            mSoundBufferSize = mPeriodSize;
            delete mSoundBuffer;
            mSoundBuffer = new char[mSoundBufferSize];
        }

        if (bytes > 0 )
        {
            // There is sound to play
            if (mVolume >= 100)
            {
                // No need for volume adjustment, so we can use memcpy
                memcpy(mSoundBuffer, frame, bytes);
            }
            else
            {
                // Do the slow volume setting
                float adjust = mVolume / 100.0f;

                for (int i=0; i<bytes; ++i)
                    // TODO: Handle non-char wide sounds
                    mSoundBuffer[i] = (char)(frame[i] * adjust);
            }
        }

        // Fill out the remining time with the sound of silence
        while (bytes < mPeriodSize)
            mSoundBuffer[bytes++] = 0;

        // Set to play the buffer
        frame = mSoundBuffer;
    }

    int rc = snd_pcm_writei(mPlaybackHandle, frame, bytes);

-- 

Thorsen Consulting ApS - Qt consulting services
http://www.thorsen-consulting.dk
