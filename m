From: Philip Chu <Philip.Chu@logicpd.com>
Subject: Why is SND_PCM_FORMAT_S32_LE not able to be set and
 passed to Linux Kernel Asoc?
Date: Tue, 28 Dec 2010 01:20:58 -0600
Message-ID: <0520A3FE5EDCF24F88B3F1451CFC64AE02338750EF@EDPREX01.logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.logicpd.com (unknown [174.46.170.145])
	by alsa0.perex.cz (Postfix) with ESMTP id ADFA9103831
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 08:21:04 +0100 (CET)
Received: from EDPREX01.logicpd.com (edprex01.logicpd.com [10.1.18.134]) by
	barracuda.logicpd.com with ESMTP id tTEhkRr2X29UtBsa
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for
	<alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 01:21:01 -0600 (CST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all ALSA experts,

I am seeing a weird behavior of ALSA API lib 1.0.23, i.e., when I use SND_PCM_FORMAT_S32_LE, I am seeing that the data format is still configured as SND_PCM_FORMAT_S16_LE and passed to kernel driver layer.

The code I am using is shown below:

====================================================================================

snd_pcm_t *capture_handle;

rc = snd_pcm_open(&capture_handle, devName, SND_PCM_STREAM_CAPTURE, 0 /*SND_PCM_NONBLOCK*/); /*    */

if (rc < 0) {
      fprintf(stderr, "unable to open pcm device: %s\n", snd_strerror(rc));
      exit(1);
}

   /* Allocate a hardware parameters object. */
   snd_pcm_hw_params_malloc(&hw_params);

   /* Fill it in with default values. */
   snd_pcm_hw_params_any(capture_handle, hw_params);

   /* Set the desired hardware parameters. */
   /* Interleaved mode 2-channel*/
   snd_pcm_hw_params_set_access(capture_handle, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED); /* each frame left->right->left->right */

   /* Signed 32-bit little-endian format */
   snd_pcm_hw_params_set_format(capture_handle, hw_params, SND_PCM_FORMAT_S32_LE);
   //snd_pcm_hw_params_set_format(HANDLE(direction), hw_params, SND_PCM_FORMAT_S16_LE);

   /* Two channels (stereo) */
   if( (rc=snd_pcm_hw_params_set_channels(capture_handle, hw_params, 2))<0) {
      fprintf(stderr, "cannot set channel count 2\n");
      exit(1);
   }

   int sample_rate = rate;  /* The sample rate is 50000 */
   snd_pcm_hw_params_set_rate_near(capture_handle, hw_params, &sample_rate, &dir);
   if (sample_rate != rate) {
      fprintf(stderr, "The rate %d Hz is not supported by your hardware.\n ==> Using %d Hz instead.\n", rate, sample_rate);
   }

   frames = 32;
   /* Set period size to 32 frames. */
   snd_pcm_hw_params_set_period_size_near(capture_handle, hw_params, &frames, &dir);

   int periods = 2;       /* Number of periods */
   snd_pcm_uframes_t buffersize = periods*frames; /* Periodsize (bytes) */

   /* Set buffer size (in frames). The resulting latency is given by */
   /* latency = periodsize * periods / (rate * bytes_per_frame)     */
   if (snd_pcm_hw_params_set_buffer_size(capture_handle, hw_params, buffersize) < 0) { /* 2 period as buffer size*/
      fprintf(stderr, "Error setting buffersize.\n");
      return(-1);
   }

   /* Write the parameters to the driver */
   rc = snd_pcm_hw_params(capture_handle, hw_params); /* call into kernel snd_pcm_common_ioctl1 */
   if (rc < 0) {
      fprintf(stderr, "unable to set hw parameters: %s\n", snd_strerror(rc));
      exit(1);
   }


   Unsigned long buffer[1024];

   memset(buffer, 0x0, sizeof(buffer)); /* Pre-set the data */


         /* Start data transmission now */
         /* Returns the number of frames actually written. */
         snd_pcm_prepare(capture_handle); /* Need this if there are too many printf lines to interrupt the process */

         /* Start receiving data from FPGA now */
         /* Returns the number of frames actually read. */
         rc = snd_pcm_readi(handle, buffer, frames);


The data read back looks like 0x????0000, which only has half content of 32-bit format.

Is there anything wrong with my code?

Any help will be appreciated.
