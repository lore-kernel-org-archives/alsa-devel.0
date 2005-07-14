From: derteta@gmx.de (Jan Buchholz)
Subject: Distorted playback with libsndfile
Date: Thu, 14 Jul 2005 21:13:00 +0200
Message-ID: <9$rWuk7tURB@derteta>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

I am currently working on a small app, which uses
the libsndfile to load audio files. But I cannot
seem to get the playback working properly.

The snd_pcm_t instance is set up and configured
in the following method:

int audioCtrl::setFormat(unsigned channels, unsigned rate,
                                                 int bufferSize){
  snd_pcm_hw_params_t *params;
  snd_pcm_format_t fmt;
  int actualChannels = channels;
  int err;
  bool errorOccured = false;

  // Allocating parameter handle
  if ((err = snd_pcm_hw_params_malloc (&params)) < 0) {
    printf("Malloc");
    errorOccured = true;
  }
  // Opening the sound device
  if ((err = snd_pcm_open (&outputHandle, deviceName,
                                       SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
    printf("Open");
    errorOccured = true;
  }
  // Check if valid parameters are available
  if ((err = snd_pcm_hw_params_any (outputHandle, params)) < 0) {
    printf("Any");
    errorOccured = true;
  }
  // Set access method; Interleaved - alternating channel data
  if ((err = snd_pcm_hw_params_set_access (outputHandle, params,
                                    SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
    printf("Access");
    errorOccured = true;
  }
  // Probing the device for the most common data formats
  if (snd_pcm_hw_params_set_format (outputHandle, params,                   
                                   SND_PCM_FORMAT_S16)             == 0) {
    fmt = SND_PCM_FORMAT_S16;
  } else if (snd_pcm_hw_params_set_format (outputHandle, params,            
                                          SND_PCM_FORMAT_S32_LE)   == 0) {
    fmt = SND_PCM_FORMAT_S32_LE;
  } else if (snd_pcm_hw_params_set_format (outputHandle, params,            
                                          SND_PCM_FORMAT_S8)       == 0) {
                                                                            
    fmt = SND_PCM_FORMAT_S8;                                                
  } else if (snd_pcm_hw_params_set_format (outputHandle, params,
                                          SND_PCM_FORMAT_FLOAT_LE) == 0) {
                                                                            
    fmt = SND_PCM_FORMAT_FLOAT_LE;
  } else {
    printf("Format");
    errorOccured = true;
  }
  // Probing the device for the samplerate of the sample
  if ((err = snd_pcm_hw_params_set_rate_near (outputHandle, params, &rate,
                                                               0)) < 0)  {
    printf("Rate");
    errorOccured = true;
  }
  // setting the number of channels
  if ((err = snd_pcm_hw_params_set_channels (outputHandle, params,
                                                 channels)) < 0) {
    printf("Channels");
    errorOccured = true;
  }
  // Setting the parameters
  if ((err = snd_pcm_hw_params (outputHandle, params)) < 0) {
    printf("Params");
    errorOccured = true;
  }
  // Preparing the device for playback
  if ((err = snd_pcm_prepare (outputHandle)) < 0) {
    printf("Prepare");
    errorOccured = true;
  }

  snd_pcm_hw_params_free (params);

  if(errorOccured) return -1;
  else if(fmt == SND_PCM_FORMAT_S8) return 8;
  else if(fmt == SND_PCM_FORMAT_S16) return 16;
  else if(fmt == SND_PCM_FORMAT_S32_LE) return 32;
  else if(fmt == SND_PCM_FORMAT_FLOAT) return 1;
  else return 0;
}

After this initialisation, a separate thread gets buffers from
the sndfile instance and writes them to the device using the
following method:

bool audioCtrl::playBuffer(void *buffer, int size){
  int err;

  if ((err = snd_pcm_writei (outputHandle, buffer, size)) != size)
    return false;
  else return true;
}

For 16 bit playback, I have tried using buffers from both sf_read_short
and sf_read_int with different results:
buffers from sf_read_short sound totally distorted and with buffers from
sf_read_int (stereo file) data from both channels are played only on the
right channel in half speed (I suppose the first 16 bits of the ints are
0s, thus only silence is written to the left channel).

Is there an error in the initialisation method? Did I forget to set a
parameter? I did not fully grasp the concept of periods, so maybe that
could be the problem!? I guess the sndfile buffers should work without
conversion.

Greets,
Jan



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
