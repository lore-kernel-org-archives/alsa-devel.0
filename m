From: Paul Davis <pbd@Op.Net>
Subject: Re: Some problems with 0.9beta11 drivers
Date: Sun, 24 Mar 2002 18:25:56 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203250425.XAA01662@renoir.op.net>
References: <Pine.LNX.4.33.0203242003540.9245-100000@mcmillan.cadence.com>
In-Reply-To: Your message of "Sun, 24 Mar 2002 20:19:42 PST."
             <Pine.LNX.4.33.0203242003540.9245-100000@mcmillan.cadence.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ken McMillan <mcmillan@cadence.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>Actually, I think I found the problem. I was using the maximum number
>of playback and captures channels reported by the device. For
>"plughw", this number is apparently 10000, rather than the actual
>number the hardware supports! I guess what I have to do is open the
>"hw" device first to get the actual number of channels, then open
>"plughw" with that number of channels. 

ah yes, this old issue. search the archives. this was discussed at
great length last fall. search for posts from "Lopez-Lezcano". there
is a way to force the plughw layer to model the hw channel count. note
the following code from JACK's ALSA client:


	*nchns = snd_pcm_hw_params_get_channels_max (hw_params);

	if (*nchns > 1024) { 

		/* the hapless user is an unwitting victim of the "default"
		   ALSA PCM device, which can support up to 16 million
		   channels. since they can't be bothered to set up
		   a proper default device, limit the number of channels
		   for them to a sane default.
		*/

		jack_error ("You appear to be using the ALSA software \"plug\" layer, probably\n"
			    "a result of using the \"default\" ALSA device. This is less\n"
			    "efficient than it could be. Consider using a ~/.asoundrc file\n"
			    "to define a hardware audio device rather than using the plug layer\n");
		*nchns = 2;  
	}				

	if ((err = snd_pcm_hw_params_set_channels (handle, hw_params, *nchns)) < 0) {
		jack_error ("ALSA: cannot set channel count to %u for %s", *nchns, stream_name);
		return -1;
	}


>I have no idea if that is a bug or a feature. Does "plughw" do something
>useful if you specify more channels than the device supports?

AFAIK, it mixes them down to however many channels there actually are
using some reasonably sensible mapping. Whether allowing this many
channels *ever* makes sense, let alone by default, is the question,
but this is much discussed in the archives.

>Actually, one more question that I couldn't answer from the API docs:
>What do you have to do to recover from -EPIPE in the case when the
>hardware doesn't stop (i.e., when stop_threshold == UINT_MAX)?  Do you
>just retry the write, or is there some call needed to clear the xrun?

the primary purpose of using UINT_MAX is to avoid the driver itself
taking action on your behalf. it allows the application to know about
xruns when they happen, and handle them accordingly. however, there
isn't really very much you can do except to stop the stream, prepare
it, and restart it. you failed to keep up, and that means a restart is
in order. i think.

--p
