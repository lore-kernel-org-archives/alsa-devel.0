From: Paul Davis <pbd@Op.Net>
Subject: Re: Some problems with 0.9beta11 drivers
Date: Mon, 25 Mar 2002 02:46:31 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203251246.HAA07609@renoir.op.net>
References: <Pine.LNX.4.33.0203242118360.9245-100000@mcmillan.cadence.com>
In-Reply-To: Your message of "Sun, 24 Mar 2002 21:40:54 PST."
             <Pine.LNX.4.33.0203242118360.9245-100000@mcmillan.cadence.com>
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

>Well, if I am running capture and playback channels in sync, I certainly
>don't want to restart the capture channel (and destroy my recording) in the
>case when the playback buffer under-runs. Keep in mind I have a very short
>buffer for playback (to keep latency down) but a long buffer for capture.
>What I want to happen is to get a momentary silence in the playback channel,
>but have it recover "in sync" with the capture channel (this was the subject
>of a previous question I asked on the list, to which Jaroslav's answer was
>to set stop_threshold high so the playback channel would never stop).

i don't have an answer to your question just yet, but i would note
that you are making some h/w-specific assumptions in this design. if
you try what you describe on a hammerfall, you won't be able to
configure the card. as one of the few devices that *truly* runs
playback and capture from the same clock, you cannot have different
sized periods or buffers for the playback and capture streams.

different sized buffers for the two streams is not a design approach
i've seen or read about or inferred from other software. maybe it has
some advantages, but i can't think of any ...

>Now, what I would like the driver to do in this case is to just carry on
>as if nothing had happened (outputting garbage) until my program "catches up"
>with the sound card. That is, ideally the "tail" pointer of the queue would
>be allowed to pass the "head" pointer, allowing the "length" of the queue to
>become increasingly negative, and writes would not block until the queue
>was once again full. There was some indication that this might actually happen
>,
>since the API doc for snd_status_get_delay says that the "delay" (which I
>interpret to be the length of the queue in frames) is negative in the case
>of a playback under-run. Of course I have no idea...

did you try just carrying on with the write's? i don't recall if the
status after an xrun prevents you from writing/reading. i think it
does. the idea is that you failed to keep up with the device, and that
cannot be penalty free. i have argued in the past that there should be
a way to say "it should be penalty free", but i'm not sure whether
that is possible at this time.

--p
