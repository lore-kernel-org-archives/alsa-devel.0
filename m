From: Karsten =?ISO-8859-1?Q?G=FCnther?= <karsten.guenther@kamg.de>
Subject: duplex mode
Date: Sat, 27 Apr 2002 20:44:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CCAF175.6080400@kamg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

I'm trying to get access to my soundcard in duplex mode. I simply try to 
  open a pcm device twice, for capture and playback. But if I opened and 
initialized the first device, I get an error message for the second, 
that the sample format is not available. Is that, because my soundcard 
does not support duplex? It's an AWE64, so I think, it should. I am 
using this code.

Thanks for any help,
KG

int ALSAopen(short number,
	     int handle,
	     char *dir) {

   int err, flags;
   char name[10];

   //Outputhandler
   snd_output_t *output = NULL;

   sprintf(name, "hw:%d,0", number);

   switch (dir[0]){	
   case 'r':			/* read */

     flags = SND_PCM_STREAM_CAPTURE;
	
     break;
   case 'w':			/* write */

     flags = SND_PCM_STREAM_PLAYBACK;

     break;
   default:			/* invalid argument */
     return(-1);
   }

   //open the device
   if ((err = snd_pcm_open((void *)handle, name, flags, SND_PCM_ASYNC)) 
< 0) {
     printf("Unable to open the device: %s\n", snd_strerror(err));
     return 0;
   }

/*   if ((err = snd_output_stdio_attach(&output, stderr, 0)) < 0) { */
/*     fprintf(stderr, "snd_output_stdio_attach: %s\n", 
snd_strerror(err)); */
/*     return 0; */
/*   } */

   if (debug) printf("Device opened.\n");

   return 1;

}

int ALSAclose(snd_pcm_t *handle)
{
     return(snd_pcm_close(handle));
}

int ALSAinit(snd_pcm_t *handle,
	    int nbits,
	    int *nchan,
	    int samples,
	    int buffer_time,
	    int period_time,
	    snd_pcm_access_t accesstype)
{

   int err, dir;
   snd_pcm_hw_params_t *params;
   snd_pcm_sw_params_t *swparams;

   snd_pcm_sframes_t period_size;
   snd_pcm_sframes_t buffer_size;

   snd_pcm_format_t format;

   snd_pcm_hw_params_alloca(&params);
   snd_pcm_sw_params_alloca(&swparams);

   if ((err = snd_pcm_hw_params_any(handle, params)) < 0) {
     printf("Broken configuration for playback:"
	   " no configurations available: %s\n", snd_strerror(err));
     return 0;
   }

   /* Interleaved read/write format */
   err = snd_pcm_hw_params_set_access(handle, params,  accesstype);
   if (err < 0) {
     printf("Hardware parameters not available: %s\n", snd_strerror(err));
     return 0;
   }

   /* Sample format */

   switch (nbits) {
   case 8:
     format = SND_PCM_FORMAT_S8;
     break;

   case 16:
     format = SND_PCM_FORMAT_S16;
     break;

   case 32:
     format = SND_PCM_FORMAT_S32;
     break;

   default:
     printf("wrong sample format!");
   }

   if ((err = snd_pcm_hw_params_set_format(handle, params, format)) < 0) {
     printf("Sample format not available: %s\n", snd_strerror(err));
     return 0;
   }

   /* channels */
   if ((err = snd_pcm_hw_params_set_channels_near(handle, params, 
*nchan)) < 0) {
     return 0;
   }

   //We only guess, how many channels we have, so we want the exact 
count back ;-)

   *nchan = snd_pcm_hw_params_get_channels(params);

   if (debug) printf("Number of channels: 
%d\n",snd_pcm_hw_params_get_channels(params));

   /* Stream rate */
   if ((err = snd_pcm_hw_params_set_rate_near(handle, params, samples, 
0)) < 0) {
     printf("Rate %iHz not possible: %s\n", samples, snd_strerror(err));
     return 0;
   }

   if (debug) printf("Choosen sample rate: %d\n", 
snd_pcm_hw_params_get_rate(params, 0));

   if (err != samples) {
     printf("Sampling-Rate stimmt nicht berein (angefordert: %iHz, 
mglich: %iHz)\n", samples, err);
     return -EINVAL;
   }
   /* buffer */
   err = snd_pcm_hw_params_set_buffer_time_near(handle, params, 
buffer_time, &dir);
   if (err < 0) {
     printf("Unable to set buffer time %i for playback: %s\n", 
buffer_time, snd_strerror(err));
     return 0;
   }
   buffer_size = snd_pcm_hw_params_get_buffer_size(params);
   err = snd_pcm_hw_params_set_period_time_near(handle, params, 
period_time, &dir);
   if (err < 0) {
     printf("Unable to set period time %i for playback: %s\n", 
period_time, snd_strerror(err));
     return 0;
   }

   period_size = snd_pcm_hw_params_get_period_size(params, &dir);

   /* set the params */
   err = snd_pcm_hw_params(handle, params);
   if (err < 0) {
     printf("Unable to set hardware parameter: %s\n", snd_strerror(err));
     return 0;
   }

   snd_pcm_hw_params_free(params);

   if (debug) printf("Hardware initialized.\n");

   //software parameter

  /*  err = snd_pcm_sw_params_current(handle, swparams); */
/*   if (err < 0) { */
/*     printf("Unable to determine current swparams for playback: %s\n", */
/*            snd_strerror(err)); */
/*     return err; */
/*   } */

/*   err = snd_pcm_sw_params_set_start_threshold(handle, swparams, 0); */
/*   if (err < 0) { */
/*     printf("Unable to set start threshold mode for playback: %s\n", */
/*            snd_strerror(err)); */
/*     return err; */
/*   } */

/*   err = snd_pcm_sw_params_set_avail_min(handle, swparams, 
period_size); */
/*   if (err < 0) { */
/*     printf("Unable to set avail min for playback: %s\n", 
snd_strerror(err)); */
/*     return err; */
/*   } */

/*   err = snd_pcm_sw_params_set_xfer_align(handle, swparams, 1); */
/*   if (err < 0) { */
/*     printf("Unable to set transfer align for playback: %s\n", */
/*            snd_strerror(err)); */
/*     return err; */
/*   } */

/*   err = snd_pcm_sw_params(handle, swparams); */
/*   if (err < 0) { */
/*     printf("Unable to set sw params for playback: %s\n", 
snd_strerror(err)); */
/*     return err; */
/*   } */

/*   if (debug) printf("Software parameter initialized.\n"); */

   snd_pcm_prepare(handle);

   return 1;
}
