From: Glenn Maynard <g_sf@zewt.org>
Subject: pcm_plug.c:882: snd_pcm_plug_hw_params: Assertion `err >= 0' failed.
Date: Tue, 23 Dec 2003 19:32:00 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031224003200.GB25270@zewt.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached program results in:

./a.out
a.out: pcm_plug.c:882: snd_pcm_plug_hw_params: Assertion `err >= 0' failed.
zsh: 22948 abort      ./a.out

This is with CVS alsa-utils (and 0.9.6 or 0.9.8), whatever is in 2.6.0 test9,
and an SBLive.  It goes away if the sample rate block is uncommented.

This only seems to happen with the plug device; it works fine with hw:0.
It also goes away if I don't specify a buffer size (which is why I havn't
seen this problem until now).

(What I'm really doing is setting up the subdevice on initialization,
and then when a sound really starts playing, I reconfigure it to the
sample rate of the sound.  This works very well in Windows: it lets the
drivers resample, possibly in hardware, so I don't have to--the resampling
code I'm using is too slow.  I havn't tested it as thoroughly in ALSA,
but it seems to work.)

-- 
Glenn Maynard

--ikeVEW9yuYc//A+q
Content-Type: text/x-c++src; charset=us-ascii
Content-Disposition: attachment; filename="test.cc"

#define ALSA_PCM_NEW_HW_PARAMS_API
#define ALSA_PCM_NEW_SW_PARAMS_API
#include <alsa/asoundlib.h>

#define ALSA_CHECK(x) \
       if ( err < 0 ) { printf("ALSA9: %s: %s\n", x, snd_strerror(err)); return false; }


main()
{
	/* Open the device. */
	int err;
	snd_pcm_t *pcm;
	err = snd_pcm_open( &pcm, "default", SND_PCM_STREAM_PLAYBACK, SND_PCM_NONBLOCK );
	assert( err >= 0 );

	/* allocate the hardware parameters structure */
	snd_pcm_hw_params_t *hwparams;
	snd_pcm_hw_params_alloca( &hwparams );

	err = snd_pcm_hw_params_any(pcm, hwparams);
	ALSA_CHECK("snd_pcm_hw_params_any");

	/* set to mmap mode (with channels interleaved) */
	err = snd_pcm_hw_params_set_access(pcm, hwparams, SND_PCM_ACCESS_MMAP_INTERLEAVED);
	ALSA_CHECK("snd_pcm_hw_params_set_access");

	/* set PCM format (signed 16bit, little endian) */
	err = snd_pcm_hw_params_set_format(pcm, hwparams, SND_PCM_FORMAT_S16_LE);
	ALSA_CHECK("snd_pcm_hw_params_set_format");

	/* set number of channels */
	err = snd_pcm_hw_params_set_channels(pcm, hwparams, 2);
	ALSA_CHECK("snd_pcm_hw_params_set_channels");

//	unsigned int rate = samplerate;
//	err = snd_pcm_hw_params_set_rate_near(pcm, hwparams, &rate, 0);
//	ALSA_CHECK("snd_pcm_hw_params_set_rate_near");

	snd_pcm_uframes_t periodsize = 1024*32;
	err = snd_pcm_hw_params_set_buffer_size_near( pcm, hwparams, &periodsize );
	ALSA_CHECK("snd_pcm_hw_params_set_buffer_size_near");

	/* write the hardware parameters to the device */
	err = snd_pcm_hw_params( pcm, hwparams );
	ALSA_CHECK("snd_pcm_hw_params");
}


--ikeVEW9yuYc//A+q--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
