From: "Alfredo" <alfredo@vida-software.com>
Subject: RE: Little question about ALSA callbacks
Date: Wed, 27 Jul 2005 16:30:53 +0200
Message-ID: <ac9b4621f9fe894c8acfa240d6f78ed4@vida-software.com>
References: <200507271205.57592.j.seger@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200507271205.57592.j.seger@gmx.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joern Seger <j.seger@gmx.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


Thank you very much! Your help is really appreciated. 

I will improve my knowledge to help other developers.


-----Original Message-----
From: Joern Seger [mailto:j.seger@gmx.de] 
Sent: mi=E9rcoles, 27 de julio de 2005 11:06
To: alsa-devel@lists.sourceforge.net
Cc: Alfredo
Subject: Re: [Alsa-devel] Little question about ALSA callbacks

Hi Alfredo,

I just had the same problem here some days ago. (It was mainly about 
recording)

This is my solution: (taken from a bigger project and hacked together
from 
some tutorials - so this is not really clean!)

opening as usual (with SND_PCM_NONBLOCK) and then do:

---- snip --------

  /* tell ALSA to wake us up whenever 256 or more frames
     of record data can be delivered. Also, tell
     ALSA that we'll start the device ourselves.
  */
        
  if ((err =3D snd_pcm_sw_params_malloc (&sw_params)) < 0) {
    fprintf (stderr, "cannot allocate software parameters structure
(%s)\n",
	     snd_strerror (err));
    exit (1);
  }
  if ((err =3D snd_pcm_sw_params_current (rec_handle, sw_params)) < 0) {
    fprintf (stderr, "cannot initialize software parameters structure
(%s)\n",
	     snd_strerror (err));
    exit (1);
  }

  int handleBytes =3D 256; // bytesToCapture/2;

  if ((err =3D snd_pcm_sw_params_set_avail_min (rec_handle, sw_params, 
handleBytes)) < 0) {
    fprintf (stderr, "cannot set minimum available count (%s)\n",
	     snd_strerror (err));
    exit (1);
  }
  if ((err =3D snd_pcm_sw_params_set_start_threshold (rec_handle,
sw_params, 
handleBytes)) < 0) {
    fprintf (stderr, "cannot set start mode (%s)\n",
	     snd_strerror (err));
    exit (1);
  }
  if ((err =3D snd_pcm_sw_params (rec_handle, sw_params)) < 0) {
    fprintf (stderr, "cannot set software parameters (%s)\n",
	     snd_strerror (err));
    exit (1);
  }
        
  /* the interface will interrupt the kernel every 256 Samples, and ALSA
     will wake up this program very soon after that.
  */
        
  if ((err =3D snd_pcm_prepare (rec_handle)) < 0) {
    fprintf (stderr, "cannot prepare audio interface for use (%s)\n",
	     snd_strerror (err));
    exit (1);
  }

  snd_pcm_sw_params_free (sw_params);

  // now get the descriptors:
  int count =3D snd_pcm_poll_descriptors_count(rec_handle);

  slog(Slog::levelDebug)<<" count =3D "<<count<<oendl;

  if (count <=3D 0) {
    printf("Invalid poll descriptors count\n");
    return count;
  }
  
  struct pollfd *ufds;
  
  ufds =3D new pollfd[count];

  if (ufds =3D=3D NULL) {
    printf("Not enough memory\n");
    return -ENOMEM;
  }
  if ((err =3D snd_pcm_poll_descriptors(rec_handle, ufds, count)) < 0) {
    printf("Unable to obtain poll descriptors for playback: %s\n", 
snd_strerror(err));
    return err;
  }

  recDesc =3D ufds->fd; //< this is my descriptor for select!!!

  // tell scheduler, that we want to be informed on soundcard events 
  sched->add_select(this, recDesc);


  snd_pcm_start(rec_handle);

--- snip --------

The following method will be called, if the descriptor is set via 
select/FD_SET etc (see manpage for this)

--- snip --------

void alsaSoundLayer::descHandler(Event e)
{
[...]
  snd_pcm_sframes_t samples_to_deliver;
  if ((samples_to_deliver =3D snd_pcm_avail_update (rec_handle)) <=3D 0) {
    if (samples_to_deliver =3D=3D 0) {
      slog(Slog::levelDebug)<<name<<": desc was called, but no data 
available!?\n";
      return;
    }

   [ ... error handling ... ]

  char* samples =3D new char[samples_to_deliver*2]; // samples are short
  if ((rc =3D snd_pcm_readi( rec_handle, (void*) samples,
samples_to_deliver )) 
< 0) 
    [... error handling ...]

  len =3D rc*2;

[... do whatever with the packet ...]

  return;
}

--- snip ------

Hope this helps!

regards - J=F6rn


Am Mittwoch, 27. Juli 2005 11:28 schrieb Alfredo:
> Hello, I have read the article "Introduction to Sound Programming with
> ALSA from Linux Journal. This article explains:
>
>
>
> // Starts here:
>
------------------------------------------------------------------------
> -------------------------------------------
>
> "In the previous examples, the PCM streams were operating in blocking
> mode, that is, the calls would not return until the data had been
> transferred. In an interactive event-driven application, this
situation
> could lock up the application for unacceptably long periods of time.
> ALSA allows opening a stream in nonblocking mode where the read and
> write functions return immediately. If data transfers are pending and
> the calls cannot be processed, ALSA returns an error code of EBUSY.
>
> Many graphical applications use callbacks to handle events. ALSA
> supports opening a PCM stream in asynchronous mode. This allows
> registering a callback function to be called when a period of sample
> data has been transferred."
>
> // Finishes here:
>
------------------------------------------------------------------------
> -------
>
> I'm developing an event driven Linux server that will use ALSA
library.
> Please, could you point me to some resources in order to learn how to
> use alsa in asynchronous mode (the event driven mechanism will be
based
> in poll()).
>
> Clemens Ladisch helped me suggesting that I must use poll to wait for
> events in different file descriptors. I need to be notified when audio
> buffer has been recorded. I need to learn how to use ALSA in
conjunction
> with poll.
>
> I'm a Linux developer beginner and I'm glad to use ALSA.
>
> Thank you very much ;-)





-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
