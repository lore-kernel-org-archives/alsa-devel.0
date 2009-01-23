From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Misusing snd_pcm_avail_update()
Date: Fri, 23 Jan 2009 18:49:49 +0000
Message-ID: <ad2655cb0901231049o56eda998yecb82649c2b58983@mail.gmail.com>
References: <20090120025727.GA30499@tango.0pointer.de>
	<49758B71.8090605@ladisch.de>
	<20090120142614.GA27494@tango.0pointer.de>
	<49761C79.8060605@ladisch.de>
	<20090120202933.GA17626@tango.0pointer.de>
	<s5hwscpqypo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f11.google.com (mail-ew0-f11.google.com
	[209.85.219.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 976BE103833
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 19:49:57 +0100 (CET)
Received: by ewy4 with SMTP id 4so1479286ewy.8
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 10:49:56 -0800 (PST)
In-Reply-To: <s5hwscpqypo.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

2009/1/21 Takashi Iwai <tiwai@suse.de>:
> At Tue, 20 Jan 2009 21:29:34 +0100,
> Lennart Poettering wrote:
>>
>> I called the prototype "busy for" since effectively the value I am
>> looking for is the time the card will be busy with the data it already
>> has, and doesn't need any new data.
>
> Isn't it snd_pcm_delay() that was originally designed for?
> Did you check my previous patch?
>

No. snd_pcm_delay() was designed for aiding audio/video sync.
I.e. If I write a sample to the buffer now, it will play on the
speakers in X samples time.
In this way, if I have a sample that must play in X samples time, I
write it now.
If I have a sample that must play in X+3 samples time, I add 3 samples
of padding first.
