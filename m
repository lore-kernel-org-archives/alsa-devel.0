From: Philip Spencer <pspencer@fields.utoronto.ca>
Subject: Re: [PATCH] Wrong latency in pulseaudio plugin breaks
 Adobe Flash Player
Date: Fri, 17 Feb 2012 14:36:20 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1202171351300.11808@lpc8.fields.utoronto.ca>
References: <alpine.LFD.2.00.1202161015470.19707@lpc8.fields.utoronto.ca>
	<4F3DAC41.4000602@canonical.com>
	<alpine.LFD.2.00.1202162248280.21549@fields.fields.utoronto.ca>
	<4F3E1A04.9080404@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fileserver.fields.utoronto.ca (fileserver.fields.utoronto.ca
	[128.100.216.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 6506A10391A
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 20:36:25 +0100 (CET)
In-Reply-To: <4F3E1A04.9080404@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It seems you are right ... things are much more complicated than I 
realized.

> Now; if an application start playback with an empty buffer (either by calling
> "trigger" or by setting a low start threshold), should we assume that 1) the
> application is going to stay almost empty all the time, like it seems Flash
> does in this scenario, or 2) fill it up completely and stay there (IIRC,
> mpg123 did this)?
>
> Lowering tlength might be reasonable in scenario 1, but scenario 2 will cause
> the client to block (trying to fill an already filled buffer) in ways that
> differs from the expected behaviour.

Obviously the plugin needs to work properly for both scenarios -- and 
indeed Flash itself could be in either scenario, depending on whether it's 
receiving packets from the network smoothly or in bunches.

I agree that it is unacceptable for the client to block if it's writing 
fewer bytes than the buffer length it asked for. I did not realize 
pulseaudio would do that. I thought that, if there were more than tlength 
bytes in the buffer, pulseaudio simply would not issue the "I want more 
data!" callback to the plugin until the length dropped below tlength/2, 
but that client was free to write, without blocking, as many bytes as it 
wished up to maxlength. Apparently I was wrong.

Next complication -- when I went to get a pulseaudio log of how the 
latency rose when only prebuf was lowered, I found I had accidentally been 
compiling the plugin when configure had been run against an older 
pulseaudio version. Compiling it against pulseaudio 1.1 caused everything 
to break again -- samples coming with no latency (good) but with part of 
each sample cut off (very bad). I realized this is because the plugin is 
now setting handle_underrun to 1 by default. With handle_underrun turned 
off, I get the behaviour I saw before: works perfectly with tlength 
lowered, but latency jumps up to 500ms when tlength=500ms, even with 
prebuf lowered.

Putting some trace statements into the plugin code, I see the following 
sequence of events is happening:

1. Alsa initialized with buffer = 500ms, io period = 20ms,
    start threshold = 20ms, 16 kHz audio, 2byte samples, 1 channel.

2. Flash writes 640 bytes (320 samples, 20ms) and these are sent by the
    plugin to pulseaudio.

3. An *explicit* stream start is then called (so in this case the prebuf
    setting is actually totally irrelevant!)

4. 11 milliseconds later, the plugin gets an underrun callback from
    PulseAudio. (Note that at this point only half the sample will actually
    have been played, so this is definitely connected to the "false alarm"
    underrun discussions you pointed me to).

5. If the plugin's underrun handling is enabled, this causes the whole
    stream to be closed and re-opened. Unplayed samples are lost, but the
    next packet plays at exactly the right time. Result: in-sync, but
    unacceptably distorted, audio.

6. If the plugin's underrun handling is disabled, nothing further happens.
    Flash writes the next 640 bytes about 16ms after its first packet was
    written (so well before the first 20ms have finished actually playing).

7. From then on in, there are *NO* underruns reported back to the plugin
    from pulseaudio.

8. However, I hear several brief hiccups in playback, and the pulseaudio
    latency very quickly increases to 500ms.

I assume, then, that the tlength value also influences the buffering 
between pulseaudio and the hardware sink, and it is this that is 
underrunning and causing pulseaudio to raise the latency when it is
much larger than the fill level at which the client keeps the buffer.

This means that something probably needs to be fixed in pulseaudio. For 
the plugin, there are probably some things that could be changed but they
won't help me directly:

   - Definitely prebuf should be lowered if the client requests an explicit
     start threshold, but this fix won't have any impact on my situation
     since the stream is already being started explicitly.

   - Something should be done about that early false-alarm underrun.
     Maybe the pulse_start routine should not do anything if fewer than n
     IO periods' worth of data has been written yet (where n is to be
     determined), just set a flag and have the start retried after enough
     data is written? Or maybe an underrun detected when fewer than n IO
     period's worth of data have been sent should be silently ignored?

     (If no such fix is made, though, I can easily work around things
     by arranging my data stream so that Flash player always gets
     sound packets in pairs and that will avoid this underrun. Indeed,
     I note that the ffmpeg encoder by default always stuffs two
     Speex packets together into a single packet and notes that Flash
     Player doesn't play it properly otherwise; I wonder if this is
     why?)

Now I guess it's time to dig in to pulseaudio, and see whether (a) it can 
be changed so that the client is free to write more than tlength bytes 
without blocking, or (b) the buffering between pulseaudio and its hardware 
sink can be adjusted to use prebuf or minreq or something when the stream
is started early.

> So this is the usual problem with closed source applications: no application 
> is bug free, but when the closed source application is broken, it's much 
> harder to fix it. The sad reality is that by depending on a closed source 
> application, you're putting yourself in this situation.

I agree wholeheartedly about the drawback with closed source applications.
Unfortunately we don't really have any choice: we need something that can
work for anybody who has a browser and webcam, without the need for them
to install any special software from us, and until HTML5's device access
(camera/microphone) and WebSocket APIs have matured and become available
on a majority of browsers, Flash Player is pretty much the only choice.
I do look forward, though, to being able to ditch it in favour of an
all-in-browser, HTML5 solution in a few years once that technology is 
ready.

Besides, I really don't think there are any bugs in Flash here. It has to 
try to deliver audio packets to the sound system as soon as they are 
received and decoded from the network. It can't set a small IO buffer in 
case it gets a large bunch of packets at once. It has to set an early 
playback start threshold to minimize latency. So I really don't see what 
else it can do (except maybe waiting until it sent the second packet to 
start the stream, instead of starting it after only the first) -- do you 
have any thoughts about what it could/should have been doing differently?

Anyway, I will do some more digging into PulseAudio (and try to get a 
detailed log of what's happening).

Thanks,

Philip

--------------------------------------------+-------------------------------
Philip Spencer  pspencer@fields.utoronto.ca | Director of Computing Services
Room 336        (416)-348-9710  ext3036     | The Fields Institute for
222 College St, Toronto ON M5T 3J1 Canada   | Research in Mathematical Sciences
