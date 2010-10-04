From: Andrew Bell <andrew.bell.ia@gmail.com>
Subject: Re: EPIPE and underruns
Date: Mon, 4 Oct 2010 16:02:07 -0500
Message-ID: <AANLkTimxDDqfpcOSn6tnk6V1+wgU3y1f3sQNMCP1P46t@mail.gmail.com>
References: <AANLkTi=3phX8UtGd0wbrfv7gYHYYV1TitWE4bvm4CTAi@mail.gmail.com>
	<alpine.LNX.2.00.1010042241460.20467@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B058103AB6
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 23:02:11 +0200 (CEST)
Received: by gyh4 with SMTP id 4so2122394gyh.38
	for <alsa-devel@alsa-project.org>; Mon, 04 Oct 2010 14:02:07 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1010042241460.20467@eeebox2.perex-int.cz>
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

On Mon, Oct 4, 2010 at 3:45 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Mon, 4 Oct 2010, Andrew Bell wrote:
>
>> Hi,
>>
>> Can somebody explain precisely the circumstances leading to an EPIPE
>> as the result of a pcm_snd_writei()?
>
> Simply, the driver consumed all queued samples in the ring buffer.
>
>> What buffer has been underrun that leads to this error? =A0Does
>> providing more data to pcn_snd_writei() help alleviate the issue?
>
> Yes, also the ring buffer size may be increased depending on the stream
> parameter setup to prevent underruns.

Is there some reason not to write all the data that you want played at
once other than snd_pcm_writei() may block?

Can you point out some code that detects this underrun condition (I've
found a bunch of candidates, but they don't obviously scream "underrun
here!".

Thanks again,

-- =

Andrew Bell
andrew.bell.ia@gmail.com
