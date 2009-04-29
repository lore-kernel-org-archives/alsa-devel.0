From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: 6-channel output and i2s
Date: Wed, 29 Apr 2009 10:35:34 -0400
Message-ID: <9e4733910904290735n1dc680b4pdccfb13970363109@mail.gmail.com>
References: <9e4733910904290558n60f71bbdn8b85d64e1c0ad4dd@mail.gmail.com>
	<s5hab5zbogv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id EC730103817
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Apr 2009 16:35:36 +0200 (CEST)
Received: by ewy23 with SMTP id 23so624278ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2009 07:35:35 -0700 (PDT)
In-Reply-To: <s5hab5zbogv.wl%tiwai@suse.de>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 29, 2009 at 9:04 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 29 Apr 2009 08:58:52 -0400,
> Jon Smirl wrote:
>>
>> My hardware was has three stereo i2s lines. These three lines are all
>> tied to the same external clock so they are synchronized. Because
>> there are three i2s lines, each with it's own DMA queue and FIFO, I
>> need three independent output buffers. What is the correct way to set
>> this up in ALSA?
>
> So I suppose it's three streams of 2-ch interleaved format?

Yes

> If so, an easier way would be to provide three substreams in a PCM,
> and bind 6 channels with alsa-lib plugin.

How does ALSA start the streams synchronously?

>
> Another possible way would be to set up channel_info to point a proper
> offset for each channel. =A0But, this is less common and maybe more
> problematic.
>
>
> Takashi
>



-- =

Jon Smirl
jonsmirl@gmail.com
