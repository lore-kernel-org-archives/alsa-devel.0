From: Joshua Haberman <joshua@haberman.com>
Subject: PCM API questions
Date: Sat, 22 Jun 2002 20:41:20 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020623034119.GE26642@reverberate.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello all!

I am writing a PortAudio implementation for ALSA.  PortAudio is designed
to present a single API that cross-platform applications can use on many
different platforms.

I have some questions I hope you can answer for me.

1.  Is there any reason to choose anything other than mmap mode for
transfer?  Are there some cards that don't support it?

2.  How is device selection designed to work with ALSA?  My experience
with ALSA has been very confusing in this regard.  I recall reading at
least once that ALSA is not designed to have applications enumerate all
the devices; that the correct way is to use ~/.asoundrc to define a
hardware device and then supply that name to applications.  But is there
anything more sophisticated an application can do than to just present
the user with a text box?

3.  I'm not sure how to approach the latency-related software and
hardware parameters.  PortAudio will soon be able to run in either
callback mode or blocking mode, and it is intended that the user be able
to provide hints to the implementation about what kind of latency it
wants.

The mechanism for setting latency in PortAudio is in a state of flux, but
at the moment the PortAudio implementation is provided with these
parameters:

    framesPerCallback -- max number of frames to pass to the user callback,
        when running in callback mode
    numberOfBuffers
    latencyInFrames

These are only guidelines to the driver, not commands, but I'd still like
to do the best possible approximation.  I'm thinking of doing something
like this:

    snd_pcm_hw_params_set_period_time( MIN(latencyInFrames, framesPerCallback) )
    snd_pcm_hw_params_set_periods( numberOfBuffers )
    /* buffer size is implicit from the above two */

    snd_pcm_sw_params_set_avail_min( MIN(latencyInFrames, framesPerCallback) )

As you can probably tell, I'm murky on the interaction between the
avail_min software parameter and the period_time hardware parameter.
Clarifications welcome.  :-)

I think that's it for now.

Josh


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
