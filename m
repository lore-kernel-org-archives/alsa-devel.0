From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Subject: Invalid argument with snd_pcm_hw_params
Date: Sat, 17 May 2003 13:02:44 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305171300.06149.lucasvr@gobolinux.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_k0lx+Hcwx+WhLs2"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_k0lx+Hcwx+WhLs2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm porting one application of mine that used OSS, but I'm in trouble with the 
'invalid argument' message I always get when calling snd_pcm_hw_params().
Also, I couldn't use buffers of 1024 bytes: it aborts on 
snd_pcm_hw_params_set_period_size() with the same error. 
Attached follows the relevant portion of the code. 
Some definitions used on the code:

from my alsa.h file:
#define DSP_BUFFER_SIZE        2048
#define MONO                      1
#define STEREO                    2
#define AUDIO_DEVICE   "plughw:0,0"

Thanks a lot for your attention. Any help is very appreciated.
Lucas





--Boundary-00=_k0lx+Hcwx+WhLs2
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="alsa_open.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="alsa_open.c"

#include "wrappers.h"
#include "util.h"
#include "alsa.h"

snd_pcm_t *
ALSA_open_dsp (char *device, int mode)
{
	int 	preferred_format, dir, retval, i;
	int 	sampling_rate, ssampling_rate, frag_count, val;
	int 	channels;
	int 	format[6] = {
		SND_PCM_FORMAT_S16_LE,
		SND_PCM_FORMAT_S16_BE,
		SND_PCM_FORMAT_U16_LE,
		SND_PCM_FORMAT_U16_BE,
		SND_PCM_FORMAT_U8,
		SND_PCM_FORMAT_S8
	};
	
	snd_pcm_t *pcm_handle;
	snd_pcm_hw_params_t *hwparams;
	snd_pcm_stream_t stream = SND_PCM_STREAM_CAPTURE;
	snd_pcm_uframes_t periodsize;

	
	/* allocate the snd_pcm_hw_params structure on the stack */
	snd_pcm_hw_params_alloca (&hwparams);
	
	/* try to open the device using 'mode' (usually O_RDONLY) */
	if ((retval = snd_pcm_open (&pcm_handle, device, stream, mode)) < 0)
		{
			fprintf (stdout, "snd_pcm_open: %s\n", snd_strerror(retval));
			return NULL;
		}

	/* init hwparams with full configuration space */
	if ((retval = snd_pcm_hw_params_any (pcm_handle, hwparams)) < 0)
		{
			fprintf (stdout, "snd_pcm_hw_params_any: %s\n", snd_strerror(retval));
			return NULL;
		}

	/* set access type */
	if ((retval = snd_pcm_hw_params_set_access (pcm_handle, hwparams, SND_PCM_ACCESS_RW_INTERLEAVED)) < 0)
		{
			fprintf (stdout, "snd_pcm_hw_params_set_access: %s\n", snd_strerror(retval));
			return NULL;
		}

	/* select the best supported mode (listed on 'format') */
	for (preferred_format = -1, i = 0; i < 6; ++i)
		if (! snd_pcm_hw_params_test_format (pcm_handle, hwparams, format[i]))
			{
				preferred_format = format[i];
				break;
			}
	if (preferred_format < 0) 
		{
			fprintf (stderr, "Could not find a supported mode for your soundcard.\n");
			return NULL;
		}

	/* select the audio sample format */
	if ((retval = snd_pcm_hw_params_set_format (pcm_handle, hwparams, preferred_format)) < 0)
		fprintf (stdout, "snd_pcm_hw_params_set_format: %s\n", snd_strerror(retval));
	

	/* set the sampling rate */
	ssampling_rate = sampling_rate = 44100;
	if ((retval = snd_pcm_hw_params_set_rate_near (pcm_handle, hwparams, &ssampling_rate, &dir)) < 0)
		{
			fprintf (stdout, "snd_pcm_hw_params_set_rate_near: %s\n", snd_strerror(retval));
			return NULL;
		}
	if (dir && ssampling_rate != sampling_rate)
		{
			fprintf (stdout, "The rate %d Hz is not supported by %s device, using %d Hz instead.\n",
					sampling_rate, device, retval);
			sampling_rate = retval;
			retval = snd_pcm_hw_params_set_rate_near (pcm_handle, hwparams, &sampling_rate, 0);
			if (retval < 0)
				{
					/* sorry */
					fprintf (stdout, "snd_pcm_hw_params_set_rate_near: %s\n", snd_strerror(retval));
					return NULL;
				}
		}
	
	/* set the number of channels (mono/stereo) */
	channels = MONO;
	if ((retval = snd_pcm_hw_params_set_channels (pcm_handle, hwparams, channels)) < 0)
		{
			fprintf (stdout, "snd_pcm_hw_params_set_channels: %s\n", snd_strerror(retval));
			return NULL;
		}

	/* set the number of periods and the buffer size to be used */
	periodsize = (DSP_BUFFER_SIZE * channels) >> 2;
	if ((retval = snd_pcm_hw_params_set_period_size (pcm_handle, hwparams, periodsize, 0)) < 0)
		{
			fprintf (stdout, "snd_pcm_hw_params_set_period_size: %s\n", snd_strerror(retval));
			return NULL;
		}
	
	/* get the maximum available periods */
	frag_count = 16;
	if ((retval = snd_pcm_hw_params_get_periods_max (hwparams, &val, &dir)) < 0)
		{
			fprintf (stdout, "snd_pcm_hw_params_get_periods_max: %s\n", snd_strerror(retval));
			return NULL;
		}
	if (val < frag_count)
		frag_count = val;
	
	if ((retval = snd_pcm_hw_params_set_periods (pcm_handle, hwparams, frag_count, dir)) < 0)
		{
			fprintf (stdout, "snd_pcm_hw_params_set_periods: %s\n", snd_strerror(retval));
			return NULL;
		}
	
	if ((retval = snd_pcm_hw_params_set_buffer_size_near (pcm_handle, hwparams, &periodsize)) < 0)
		{
			fprintf (stdout, "snd_pcm_hw_params_set_buffer_size: %s\n", snd_strerror(retval));
			return NULL;
		} 

	/* apply HW parameter settings to the PCM device and prepare it */
	if ((retval = snd_pcm_hw_params (pcm_handle, hwparams)) < 0)
		{
			fprintf (stdout, "snd_pcm_hw_params: %s\n", snd_strerror(retval));
			return NULL;
		}
	
	snd_pcm_hw_params_free (hwparams);
	if ((retval = snd_pcm_prepare (pcm_handle)) < 0)
		fprintf (stdout, "snd_pcm_prepare: %s\n", snd_strerror(retval));

	return pcm_handle;
}

--Boundary-00=_k0lx+Hcwx+WhLs2--



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
