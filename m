From: stan <stanl@cox.net>
Subject: SOLUTION Re: Some functionality of ice1724 broken
 between 1.0.14.RC1 and 1.0.14.RC3
Date: Mon, 6 Aug 2007 10:33:24 -0700
Message-ID: <20070806103324.22d45a25@localhost.localdomain>
References: <20070713062326.22e05830@localhost.localdomain>
	<s5hejjczavr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao104.cox.net (fed1rmmtao104.cox.net [68.230.241.42])
	by alsa0.perex.cz (Postfix) with ESMTP id 6282D1037EF
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Aug 2007 19:33:26 +0200 (CEST)
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao104.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP id
	<20070806173326.MIUE23215.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>
	for <alsa-devel@alsa-project.org>; Mon, 6 Aug 2007 13:33:26 -0400
In-Reply-To: <s5hejjczavr.wl%tiwai@suse.de>
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

On Fri, 13 Jul 2007 15:33:28 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Fri, 13 Jul 2007 06:23:26 -0700,
> stan wrote:
> > 

> > 1.  Support for high sample rates 96000 and 192000 was lost.
> > 2.  Sound distortion at high sound frequencies was introduced.

 
> Could you check whether the same problem still exists on 1.0.14 final?
> There are tons of changes since rc3, so debugging rc3 is just a waste
> of time.
> 

Finally, I can state that the issue is still there with default device
on both 1.0.14 final and july 14, 2007 hg snapshot of alsa-lib.  I
think you've stated elsewhere that dmix is fixed at 48000 frames/sec
and this is the behavior I am seeing and that was causing the problem.
Both of the above libraries indicate that the rate is 48000.  It has 
been awhile, but I seem to recall that the RC3 rate showed the requested rate
even when dmix had changed it to 48000.  Much better this way.

The fix is to use calls to determine the card and device for default,
and then create a plughw plugin to open the device instead.  Using the
function suggested by Jaroslav to lock the rates and set_rate_near to
set them ensures that only hardware supported rates are set.  Works
great.  

For search users, here are some code samples.  Somewhat redundant with 
the alsa sample programs.

  char *default_device = "default" ;
  char *device_to_use = NULL;
  unsigned val;
  unsigned long lval;
  int dir = 0;
  int err ;
  snd_pcm_info_t *info_params ;
  snd_pcm_hw_params_t *hw_params ;
  snd_pcm_uframes_t buffer_size, xfer_align, start_threshold ;
  snd_pcm_uframes_t alsa_period_size, alsa_buffer_frames ;
  snd_pcm_sw_params_t *sw_params ;

  if (opt_a)  // audio device in options or configuration
    device_to_use = opt_a_plughw;
  else  // use default device
    device_to_use = default_device;

  err = snd_pcm_open (&alsa_dev, device_to_use, SND_PCM_STREAM_PLAYBACK, 0);
  if (err < 0)
  { fprintf (stderr, "cannot open audio device \"%s\" (%s)\n", device_to_use, snd_strerror (err)) ;
    goto catch_error ;
  } ;

  if (!opt_a)  // no option or configuration audio plughw, have to create it from default
  {
    err = snd_pcm_info_malloc (&info_params);
    if (err < 0)
    {	fprintf (stderr, "cannot allocate information parameter structure (%s)\n", snd_strerror (err)) ;
      goto catch_error ;
      } ;

    err = snd_pcm_info (alsa_dev, info_params);  // get info on the default card
    if (err < 0)
    {	fprintf (stderr, "cannot get information for the default card (%s)\n", snd_strerror (err)) ;
      goto catch_error ;
      } ;
    if (!opt_q)  // not quiet
    {
          /* RO/WR (control): device number */
      fprintf (stderr, "Default device number (%u)\n", snd_pcm_info_get_device (info_params));
         /* RO/WR (control): subdevice number */
      fprintf (stderr, "Default subdevice number (%u)\n", snd_pcm_info_get_subdevice (info_params));
            /* RO/WR (control): stream number */
      fprintf (stderr, "Default stream number (%d)\n", snd_pcm_info_get_stream (info_params));
           /* R: card number */
      fprintf (stderr, "Default card number (%d)\n", snd_pcm_info_get_card (info_params));
         /* ID (user selectable) */
      fprintf (stderr, "Default id (%s)\n", snd_pcm_info_get_id (info_params));
         /* name of this device */
      fprintf (stderr, "Default name (%s)\n", snd_pcm_info_get_name (info_params));
        /* subdevice name */
      fprintf (stderr, "Default subname (%s)\n", snd_pcm_info_get_subdevice_name (info_params));
            /* SNDRV_PCM_CLASS_* */
      fprintf (stderr, "Default dev_class (%d)\n", snd_pcm_info_get_class (info_params));
         /* SNDRV_PCM_SUBCLASS_* */
      fprintf (stderr, "Default dev_subclass (%d)\n", snd_pcm_info_get_subclass (info_params));
      fprintf (stderr, "Default subdevices_count (%u)\n", snd_pcm_info_get_subdevices_count (info_params));
      fprintf (stderr, "Default subdevices_avail (%u)\n", snd_pcm_info_get_subdevices_avail (info_params));
    }
    err = snd_pcm_close (alsa_dev) ;  // close the device so we can create new direct plughw plugin
    if (err < 0)
    {	fprintf (stderr, "Could not close audio device \"%s\" (%s)\n", device_to_use, snd_strerror (err)) ;
      goto catch_error ;
      } ;

    char hw_from_default [32];
    int cardno = snd_pcm_info_get_card (info_params); 
    if (cardno < 0)  // If default is user defined, this is set to actual card.
      cardno = 0;  //  If not, dmix leaves as -1 and defaults to card 0 (look at id in info).
    int devno = snd_pcm_info_get_device (info_params);
    if (devno < 0)  // This appears to always be set, just here as insurance.
      devno = 0;
    int numchars = snprintf (hw_from_default, sizeof (hw_from_default), 
                                  "plughw:%d,%d", cardno, devno); 
    if (!opt_q)  // not quiet
      fprintf (stderr, "Plughw  %s  numchars %d\n", hw_from_default, numchars);
    /*  Now reopen and get feasible hardware parameters with plughw instead of default.
     *  This will allow bypassing dmix in order to set higher rates than 48000.
     */
    err = snd_pcm_open (&alsa_dev, hw_from_default, SND_PCM_STREAM_PLAYBACK, 0);
    if (err < 0)
    {	fprintf (stderr, "cannot open audio device \"%s\" (%s)\n", hw_from_default, snd_strerror (err)) ;
      goto catch_error ;
      } ;
    snd_pcm_info_free (info_params) ;  // done with info
  }
  err = snd_pcm_hw_params_malloc (&hw_params);
	if (err < 0)
	{	fprintf (stderr, "cannot allocate hardware parameter structure (%s)\n", snd_strerror (err)) ;
		goto catch_error ;
		} ;

  err = snd_pcm_hw_params_any (alsa_dev, hw_params);
	if (err < 0)
	{	fprintf (stderr, "cannot initialize hardware parameter structure (%s)\n", snd_strerror (err)) ;
		goto catch_error ;
		} ;
...
...
  /* lock the sample rate to use only hardware
   * supported rates, avoid resampling
   */
  err = snd_pcm_hw_params_set_rate_resample (alsa_dev, hw_params, 0);
	if (err < 0)
	{	fprintf (stderr, "cannot block resample of sample rates (%s)\n", snd_strerror (err)) ;
		goto catch_error ;
		} ;

  err = snd_pcm_hw_params_set_rate_near (alsa_dev, hw_params, &samplerate, 0);
	if (err < 0)
	{	fprintf (stderr, "cannot set sample rate (%s)\n", snd_strerror (err)) ;
		goto catch_error ;
		} ;
