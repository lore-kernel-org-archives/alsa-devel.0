From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: snd_pcm_hw_params_free() immediately after
	snd_pcm_hw_params() ???
Date: Thu, 21 Jan 2010 12:32:20 +0800
Message-ID: <4f3252891001202032o59ff0bc1q79b023d80c6dcd17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0890D103823
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 05:32:21 +0100 (CET)
Received: by pzk9 with SMTP id 9so6257112pzk.16
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 20:32:20 -0800 (PST)
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

Refer to
http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/ch05s06.html#pcm-interface-operators-hw-free-callback

hw_free callback

 static int snd_xxx_hw_free(struct snd_pcm_substream *substream);

This is called to release the resources allocated via
          *hw_params*. For example, releasing the
          buffer via snd_pcm_lib_malloc_pages() is done by
          calling the following:
snd_pcm_lib_free_pages(substream);

This function is always called before the close callback is called.
Also, the callback may be called multiple times, too.
Keep track whether the resource was already released.
Nearly all the examples in those ALSA tutorials in the web sites have the code

	
		if ((err = snd_pcm_hw_params (playback_handle, hw_params)) < 0) {
			fprintf (stderr, "cannot set parameters (%s)\n",
				 snd_strerror (err));
			exit (1);
		}
	
		snd_pcm_hw_params_free (hw_params);

This seem to violate "This function is always called before the close
callback is called."

and those hardware mixing sound cards (e.g cs46xx , au88x0, ... ) use
snd_xxx_hw_free() to deallocate the hardware mixing path in the DSP.

There are a number of audio package (e.g. gstreamer , wine , .... )
call snd_pcm_hw_params_free immediately after snd_pcm_hw_params()

Is this a bug of snd_pcm_hw_params_free() not change the state of the
PCM stream ?

or

snd_pcm_prepare() did not check the buffer is already released ?
