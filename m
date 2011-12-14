From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: start_threshold and stream controls for PCM streams
Date: Wed, 14 Dec 2011 16:23:13 +0800
Message-ID: <CAN8cciZUpiTGJCByyLTM5rHbc9SeaosFqwOK0nbkZgsf6Z7xVg@mail.gmail.com>
References: <3CA6C6D9F70D314CA34352990B57DA1507CCB50120@bgsmsx502.gar.corp.intel.com>
	<s5hpqftu976.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 21D2424588
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 09:23:14 +0100 (CET)
Received: by faat7 with SMTP id t7so916851faa.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 00:23:13 -0800 (PST)
In-Reply-To: <s5hpqftu976.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/12/12, Takashi Iwai <tiwai@suse.de>:
> At Fri, 9 Dec 2011 11:05:19 +0530,
> Nallasellan, Singaravelan wrote:
>>
>> Hi,
>>
>> Would like to know how start_threshold is expected to be used in
>> single_threaded audio player?
>>
>> I assume that in blocking implementation,  the write call will block
>> till the ring buffer becomes empty. Is it right?
>
> Not really.  It's not necessarily to be empty.  The condition is that
> the empty space becomes avail_min or more.
>
> But, this has nothing to do with start_threshold.  The start_threshold
> is the value to start the stream automatically.  When it's 1, the
> stream is started immediately when something is written.  When it's
> buffer_size, the stream is started when all data is filled in the
> buffer.
>
> And, the write-block behavior is irrelevant with start_threshold.
>

According to HDA specification

5.4.2 Link Sample Delivery Timing

HDA link is fixed at 48000Hz

For example, with a multiple of 4 (192 kHz sample rate), there must
be four sample blocks transmitted in every frame on the link

Does it mean that start threshold cannot be 1 for rate higher than 48000Hz ?

Any special requirement of the period size for rate higher than
48000Hz ? (.e.g mutliple of two for 96000Hz or multiple of 4 for
192000Hz)


44.1-kHz Delivery Timings
Since the link frame rate is fixed at 48 kHz, streams using a base
rate of 44.1 kHz must have samples transmitted on a cadence creating
the slightly lower aggregate transmission rate to match the slightly
lower rendering rate. For streams running at a sample rate of 44.1
kHz, instead of transmitting one sample block in each frame (as
happens for 48.0 kHz rate streams), there are occasional frames that
will not contain a sample generating the following cadence.
12-11-11-12-11-11-12-11-11-12-11-11-11- (repeat)

In this cadence, the dashes indicate frames that do not contain a
sample block. Therefore, there are 12 frames containing one sample
block each, followed by one frame with no sample block, followed by 11
frames with one sample block each, etc. Following the empty frame at
the end, the cadence repeats continuously generating exactly 147
sample blocks every 160 frames and avoiding any long-term drift
between sample delivery and rendering clock.

Does it mean that the first 12 samples of 44100Hz are transmitted at 48000Hz ?
