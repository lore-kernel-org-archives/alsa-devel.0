From: "Paul Adolph" <padolph@gmail.com>
Subject: Re: [Alsa-user] Async behavior and -EAGAIN on write?
Date: Sun, 1 Jun 2008 19:46:08 -0700
Message-ID: <fe9483990806011946y5fb77b73gaf19122a3574707c@mail.gmail.com>
References: <fe9483990805301401h7d29aebdm4eeb8ccd5899687@mail.gmail.com>
	<4840A7C9.30209@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 8EFFD244F9
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jun 2008 04:46:09 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so927438wfg.23
	for <alsa-devel@alsa-project.org>; Sun, 01 Jun 2008 19:46:08 -0700 (PDT)
In-Reply-To: <4840A7C9.30209@cox.net>
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
To: stan <ghjeold_i_mwee@cox.net>
Cc: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> For playback I am using the ALSA callback to wake up a thread that
>> then feeds the ALSA ring buffer with a period-worth of samples using
>> snd_pcm_writei(). I've set snd_pcm_sw_params_set_avail_min() to one
>> period. The problem is that most of the time when my thread wakes up
>> and tries to write the data, snd_pcm_writei() fails with -EAGAIN, and
>> I must retry until it works.
>>
>> Presumably this write failure is because there is not enough space in
>> the ring buffer, but then why did the ALSA callback fire in the first
>> place? As it stands my retries are eating needless amounts of CPU.

> No definitive help.  I don't know the internals, but I have a guess.  It
> probably leads the
> amount so that on busy systems, underruns don't occur.   You could try
> setting it to 2 buffer
> min and still writing only a single buffer.  That way, you have a buffer of
> slack.

It seems to make no difference what snd_pcm_sw_set_avail_min() value I
use. I tried setting it from twice to many times the period size. I
still get ALSA callbacks very often. When I check available space at
each callback invocation using snd_pcm_avail_update(), I almost always
get much less than this setting. Indeed most usually much less than a
single period size.

> You might have better luck trying this on the alsa-devel list.  The
> developers live there and they
> know the internals.  It is possible they will answer.

Good idea. I am cross-posting this email. (Hopefully to no-one's annoyance...)

> I went and looked at the function you are using.
> (snip)
> Are you using a buffer size compatible with your card.  It is possible it is
> using the closest one and that is less than the buffer size you have
> defined.  Just a thought.

To set buffer sizes, I am using set_buffer/period_time_near() and
taking whatever the card gives me - I read them back with the get
functions. One weird thing I noticed is that my card  give me a period
size of 470 frames *always*, regardless of whatever desired buffer and
period time I ask for. I don't think this issue is related to the
async behavior weirdness though.

Thanks for your help.
