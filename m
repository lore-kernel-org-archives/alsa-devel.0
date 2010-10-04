From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: EPIPE and underruns
Date: Mon, 4 Oct 2010 23:08:44 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010042306250.20467@eeebox2.perex-int.cz>
References: <AANLkTi=3phX8UtGd0wbrfv7gYHYYV1TitWE4bvm4CTAi@mail.gmail.com>
	<alpine.LNX.2.00.1010042241460.20467@eeebox2.perex-int.cz>
	<AANLkTimxDDqfpcOSn6tnk6V1+wgU3y1f3sQNMCP1P46t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1587560669-1286226524=:20467"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 55F5A243A5
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 23:08:45 +0200 (CEST)
In-Reply-To: <AANLkTimxDDqfpcOSn6tnk6V1+wgU3y1f3sQNMCP1P46t@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrew Bell <andrew.bell.ia@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1587560669-1286226524=:20467
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 4 Oct 2010, Andrew Bell wrote:

> On Mon, Oct 4, 2010 at 3:45 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>> On Mon, 4 Oct 2010, Andrew Bell wrote:
>>
>>> Hi,
>>>
>>> Can somebody explain precisely the circumstances leading to an EPIPE
>>> as the result of a pcm_snd_writei()?
>>
>> Simply, the driver consumed all queued samples in the ring buffer.
>>
>>> What buffer has been underrun that leads to this error? =C2=A0Does
>>> providing more data to pcn_snd_writei() help alleviate the issue?
>>
>> Yes, also the ring buffer size may be increased depending on the stream
>> parameter setup to prevent underruns.
>
> Is there some reason not to write all the data that you want played at
> once other than snd_pcm_writei() may block?
>
> Can you point out some code that detects this underrun condition (I've
> found a bunch of candidates, but they don't obviously scream "underrun
> here!".

snd_pcm_update_state() in pcm_lib.c (driver) the 'if (avail >=3D=20
runtime->stop_threshold)' condition.

 =09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-1587560669-1286226524=:20467
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1587560669-1286226524=:20467--
