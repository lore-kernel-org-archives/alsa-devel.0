From: David Henningsson <launchpad.web@epost.diwic.se>
Subject: Re: snd_device_name_hint problems
Date: Sat, 12 Sep 2009 09:23:28 +0200
Message-ID: <4AAB4C70.5040805@epost.diwic.se>
References: <4AAA1C4B.5000806@epost.diwic.se>
	<4f3252890909112109g69b7fdadi1f8da1a9500a4365@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch-smtp03.sth.basefarm.net (ch-smtp03.sth.basefarm.net
	[80.76.149.214]) by alsa0.perex.cz (Postfix) with ESMTP id 063FA24608
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Sep 2009 09:24:11 +0200 (CEST)
In-Reply-To: <4f3252890909112109g69b7fdadi1f8da1a9500a4365@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Yau skrev:
> It seem to me that name hint is not suitable for displaying recording
> devices

But what should I then use? snd_card_xxx will not show the pulse device,
snd_names_list is deprecated, and snd_config_xxx is not recommended either.

> You can get low latency by using hw device since PA use maximum buffer in
> order to save power comsumption for those notebook / netbook.
> 
> If your application require high quality (bypass any SRC) , you may need to
> capture using hardware rate and format instead of using plughw

I will not need low latency for this application, but avoiding SRC would
probably be a good thing. But I assume the plug handling does not do any
SRC if it can avoid it by adjusting the hardware?

> For HDA , it support multiple streamming. some  HDA codecs (e.g. alc88x and
> ad198x) have 3 ADC ( which you can capture three stereo streams concurrently
> from internal mic, external mic and line in )
> 
> The main problem of the recording audio application is unable to select the
> correct mixer control of the three capture sources

What I would like would my enumeration function to return in this case
would be four entries, one for each ADC and one for them all combined (6
channels, multi-channel recording).

// David
