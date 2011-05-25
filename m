From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH 6/6] ASoC: davinci-pcm: convert to BATCH
	mode
Date: Wed, 25 May 2011 08:17:00 -0400
Message-ID: <BANLkTikYAf3Bokx5gTwJcJPZs2x0uHgeBA@mail.gmail.com>
References: <cover.1306258759.git.bengardiner@nanometrics.ca>
	<0f61ef7bb618fc7895a339f4eac55abb2092353c.1306258759.git.bengardiner@nanometrics.ca>
	<4DDCD16C.1080702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	by alsa0.perex.cz (Postfix) with ESMTP id D649B103806
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 14:17:01 +0200 (CEST)
Received: by mail-vx0-f171.google.com with SMTP id 40so7694249vxc.2
	for <alsa-devel@alsa-project.org>; Wed, 25 May 2011 05:17:00 -0700 (PDT)
In-Reply-To: <4DDCD16C.1080702@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: Steven Faludi <stevenfaludi@nanometrics.ca>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Nori,
	Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Hi Liam,

On Wed, May 25, 2011 at 5:52 AM, Liam Girdwood <lrg@ti.com> wrote:
> On 24/05/11 19:50, Ben Gardiner wrote:
>> [...]
>> @@ -603,15 +605,19 @@ static int davinci_pcm_prepare(struct snd_pcm_subs=
tream *substream)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 print_buf_info(prtd->asp_link[0], "asp_link[=
0]");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 print_buf_info(prtd->asp_link[1], "asp_link[=
1]");
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 davinci_pcm_period_elapsed(substream);
>> + =A0 =A0 =A0 =A0 =A0 =A0 davinci_pcm_period_elapsed(substream);
>
> I assume these are to do with the 2 period phase offset you have so it's =
probably better to comment this here too.

That's correct and yes I really should have commented this magic a
little. I will send an incremental patch that can be folded-in. Thanks
again.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
