From: Robert Spier <rspier@pobox.com>
Subject: Using alsa-lib for timing
Date: Fri, 15 Nov 2002 09:36:08 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <15829.12424.589673.766811@rls.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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


[Summary of this message:
  I want to use alsa for timing of video frames, and want alsa to
  trigger a wakeup every .01466 seconds.  But the documentation is
  sparse in this area]


I'm attempting to use alsa-lib as a timing tool for a specialized
movie playback engine.  It _must_ tick/wakeup at 24fps (every .04166
sec) and the input audio will be at 44.1khz/2 channel/16bit per chan.

For legacy reasons we need to use the poll based interface
(getting the file handle from snd_pcm_poll_descriptors()).  

Alsa will tick regularly at .0416 seconds if the period size is set to
1837[1] samples.  This is suboptimal because:
    1- this is a weird period size - generally powers of 2 are used
    (1024,2048,4096)

    2- for truly accurate 24fps playback we need 1837.5 samples/video
    frame, which can be approximated by alternating between 1837 and
    1838 samples/video frame.  (And the period size cannot be changed
    at runtime.)

The general solution to this with other sound libraries (OSS and IRIX)
is to use a rational period size and set a wakeup point.  In ALSA,
this is done with snd_pcm_sw_params_set_avail_min, but it doesn't have
the expected effect. 

Because it's only a _minimum_ the wakeup can be delayed (usually until
a multiple of the period size) is reached.  This screws up the
timing.  I saw something in the alsa-devel archives that wakeup points
(avail_min) settings can only be powers of two... which is different
than OSS.)

Am I missing something obvious here?  
Are there any examples of code (or other tools?) doing similar things?

Please don't recommend I switch to asynchronous ticks, sadly, that
isn't an option for this code.

Thanks!

-R


Footnotes: 
[1]  24fps = .041666 seconds/video frame
     44100hz = samples/seconds
     1837.5 samples/video frame
     
     




-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
