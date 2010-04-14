From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: ALSA application programming: route audio from one
 PCM to another
Date: Wed, 14 Apr 2010 11:36:01 +0200
Message-ID: <4BC58C81.7090001@gmail.com>
References: <4BC48C74.5010102@gmail.com>
	<hq25p7$8kd$1@dough.gmane.org>	<4BC58082.6090508@gmail.com>
	<hq406t$sjk$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from keymachine.tbmn.org (mail.tbmn.org [87.118.84.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 436B6103899
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 11:36:03 +0200 (CEST)
In-Reply-To: <hq406t$sjk$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Colin Guthrie wrote:
>> * Do you know if it is possible to use the jack functionality without
>> having to run the jack-daemon ?
> 
> I'm afraid not. Like PulseAudio, Jack needs the daemon to do all the
> hard stuff.
> 
> I guess you'll just have to write some small app that does the
> record/playback. I doubt it'll be that hard.

I guess I will try that first.
If it doesn't work I can still try jack.

> That said, with this approach, the fact that you've got an alsa plugin
> doing the processing in the middle seems slightly irrelevant... why not
> have your app sample the input, do the DSP it needs to do, then play the
> output? No need to: sample, play [process] sample, play. Rather: sample
> [process] play.
> 
> Perhaps I'm not understanding the other needs/use cases of the plugin
> tho'. Just idle thoughts :)

In the beginning I had a similar idea as well ;)
However, in more detail the DSP actually does speech compression.
The compressed speech should then be sent to a remote host where it is
decompressed again.

Hence one host samples speech coming from the microphone and plays it
back via the io plugin.
The plugin takes the samples and forwards them to the DSP so that they
can be compressed.
After some processing delay the DSP will output the compressed speech
packets.
These compressed packets are then read by the plugin and written to a
socket.

The remote host eventually receives the compressed speech packets and
the same process can be performed in reverse so that the decompressed
speech will come out of the speakers.

As this should work in both directions at the same time, each side needs
to capture and playback at the same time as well.

Of course, like you said, it would be possible to do that without the io
plugin in between (so that the audio application would directly
communicate with the DSP).

The drawback of this solution is that only the written audio application
could actually use the DSP.

However, with the ALSA io plugin a lot of flexibility is gained as just
about any audio application can use the speech compression DSP without
having to change the application itself.
Another thing is that the DSP only allows a single sampling rate and
audio format.
As it is possible to chain different alsa plugins together, it would
also be easy to resample and convert just about any audio format to the
format the DSP requires ;)

Hence in the end you could fire up your favorite media player and play
an mp3 or a movie over the plugin.
After that speech compression would be performed and in the end you
could hear that sound on the remote host.
(Of course that will only work well for speech as the DSP does speech
compression and not generic audio compression.)

At least that's the plan for now ;)
Until then there is some more work to be done.

So what do think ?

cheers,
stefan
