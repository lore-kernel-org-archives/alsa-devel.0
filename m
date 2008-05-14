From: "Paul Adolph" <padolph@gmail.com>
Subject: pcm output timing question
Date: Wed, 14 May 2008 12:28:04 -0700
Message-ID: <fe9483990805141228re9326dco182e9702e93e56ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.234])
	by alsa0.perex.cz (Postfix) with ESMTP id B602F24336
	for <alsa-devel@alsa-project.org>;
	Wed, 14 May 2008 21:28:05 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 50so35112wri.2
	for <alsa-devel@alsa-project.org>; Wed, 14 May 2008 12:28:04 -0700 (PDT)
Content-Disposition: inline
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

ALSA newbie warning...

I have a funny application that does av sync by using the timing of a
callback to set the audio timebase. In other words, I need to invoke
that callback "as close as possible" to the time a previously-sent
buffer of samples is presented, i.e. exits the speakers. The
application uses the clock time of the arrival of this callback and
does some math to figure out whether to repeat or skip video frames. I
do not like this arrangement, but unfortunately I am stuck with it. My
job is to hook this app to ALSA audio output.

My current design uses a producer-consumer model with a thread that
writes fixed-size application buffers to the ALSA ring buffer, driven
by a message queue fed by the application. This is a little redundant
I think, but I do not own the buffers sent by the app so this is what
I came up with. The application needs a regular callback with the
timing described above each time one of their buffers is played, and
it is assumed they are played in sequence.

I tried setting the ALSA callback to trigger when there are an
application-buffer-size amount of frames available, using
snd_pcm_sw_params_set_avail_min(). My idea was that if I primed the
ring buffer to be full before it starts transfers with
snd_pcm_sw_params_set_start_threshold(), I would get the ALSA callback
each time that number of frames exited the ring buffer. But this did
not work: I seem to be getting callbacks much more frequently that I
wanted, probably on ALSA period boundaries. So this means I do not
understand how snd_pcm_sw_params_set_start_threshold() is supposed to
work I guess.

Will somebody please comment on the viability of and/or problems with
my current design, or suggest an alternative way to configure ALSA
that will give me the output timing I need?

Currently I am testing on an x86 ubuntu box, kernel 2.6.22-14, ALSA
1.0.14, gcc 4.1.3, glibc 2.6.1, but will also cross-compile for
several embedded platforms in the future.

Thanks in advance.
