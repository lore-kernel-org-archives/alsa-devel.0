From: Gregory Bonik <gregory@bonik.org>
Subject: Implementing full-duplex realtime sound processor
Date: Sun, 22 Aug 2010 18:40:36 +0200
Message-ID: <1282495236.8223.7.camel@koffer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 849121037F9
	for <alsa-devel@alsa-project.org>;
	Sun, 22 Aug 2010 18:40:42 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2819599eyd.38
	for <alsa-devel@alsa-project.org>; Sun, 22 Aug 2010 09:40:41 -0700 (PDT)
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

Hi there,

I'm trying to implement a full-duplex realtime sound processing app.
I.e., it should capture a stream from a soundcard, do some processing on
it and play it with minimal latency.

I don't want to use JACK or any other higher-level API, so I'm looking
for the best way to do it directly with ALSA. So far I've discovered
three approaches:

a) Just use blocking read/write functions. This approach seems flawed to
me, since a separate thread is required for writing. Synchronizing
between threds also introduces additional latency.

b) Use the alsalib's asynchronous functionality. At first sight it
sounds attractively, but googling for it gets not so happy results. For
example, the alsa.opensrc.org wiki claims this functionality is
unstable, especially in combination with PulseAudio. I don't know if
it's true or not, but it discourages me even from trying it.

c) Use synchronous I/O multiplexing (i.e poll syscall) together with
non-blocking mode (much like doing I/O on network sockets). It becomes
possible with the snd_pcm_poll_descriptors* family of functions. 

So I decided to try the third way first and wrote a simple test program.
I'm using Ubuntu and therefore have PulseAudio sound system. So my
program worked successfully through PulseAudio (i. e. with 'default'
pcm). But when I tried to run it directly on hw:0,0, it hung in the
poll() system call, waiting infinitely for an event on a capturing PCM,
as if there was no data available for capturing.

I started to look through ALSA API's functions and found occasionally
snd_pcm_start. I've never seen it in any tutorial, but I decided to try
calling it just after snd_pcm_prepare() for my capturing pcm handle and
it did the trick. But if I call this function on a playback pcm handle,
it fails with 'Broken pipe' error.

To sum it up, I have the following questions:
- What does actually snd_pcm_start() do?
- Why does it fail on a playback device and do the job on a capture
device?
- Why does my program work without it when I'm using PulseAudio?
- Am I generally on the right way or should I use other approach?


Thanks,
Gregory Bonik.
