From: Ken McMillan <mcmillan@cadence.com>
Subject: Re: Some problems with 0.9beta11 drivers
Date: Sun, 24 Mar 2002 21:40:54 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0203242118360.9245-100000@mcmillan.cadence.com>
References: <200203250425.XAA01662@renoir.op.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <200203250425.XAA01662@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@Op.Net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 24 Mar 2002, Paul Davis wrote:

> 
> >Actually, one more question that I couldn't answer from the API docs:
> >What do you have to do to recover from -EPIPE in the case when the
> >hardware doesn't stop (i.e., when stop_threshold == UINT_MAX)?  Do you
> >just retry the write, or is there some call needed to clear the xrun?
> 
> the primary purpose of using UINT_MAX is to avoid the driver itself
> taking action on your behalf. it allows the application to know about
> xruns when they happen, and handle them accordingly. however, there
> isn't really very much you can do except to stop the stream, prepare
> it, and restart it. you failed to keep up, and that means a restart is
> in order. i think.
> 

Well, if I am running capture and playback channels in sync, I certainly
don't want to restart the capture channel (and destroy my recording) in the
case when the playback buffer under-runs. Keep in mind I have a very short
buffer for playback (to keep latency down) but a long buffer for capture.
What I want to happen is to get a momentary silence in the playback channel,
but have it recover "in sync" with the capture channel (this was the subject
of a previous question I asked on the list, to which Jaroslav's answer was
to set stop_threshold high so the playback channel would never stop).

Now, what I would like the driver to do in this case is to just carry on
as if nothing had happened (outputting garbage) until my program "catches up"
with the sound card. That is, ideally the "tail" pointer of the queue would
be allowed to pass the "head" pointer, allowing the "length" of the queue to
become increasingly negative, and writes would not block until the queue
was once again full. There was some indication that this might actually happen,
since the API doc for snd_status_get_delay says that the "delay" (which I
interpret to be the length of the queue in frames) is negative in the case
of a playback under-run. Of course I have no idea...

	Ken
