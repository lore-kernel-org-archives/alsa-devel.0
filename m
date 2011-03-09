From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd_pcm_hw_params_set_buffer_time_near: invalid
 argument
Date: Wed, 9 Mar 2011 13:29:42 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103091326380.4805@eeebox2.perex-int.cz>
References: <AANLkTik5sX_DWLsN3y_7ANpoF5rgeCNZY7gm=+rFhCsy@mail.gmail.com>
	<AANLkTimfZwH+dqsPZaifekmmctrARdE0DoK5nHoW1Fu_@mail.gmail.com>
	<AANLkTinNhknw6h81zkqhhXQwYyrKGs0mVjYpjYvZuNa=@mail.gmail.com>
	<AANLkTi=WkvaM+oLDAzyvcBzeg_kuB=33esFVXDZn1M48@mail.gmail.com>
	<AANLkTik+ecGzz+yCoYhYCxHEJrsof5Eo_cxgnEU84wZm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1467311155-1299673782=:4805"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id C802A2414C
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 13:29:42 +0100 (CET)
In-Reply-To: <AANLkTik+ecGzz+yCoYhYCxHEJrsof5Eo_cxgnEU84wZm@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean-Yves Avenard <jyavenard@gmail.com>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1467311155-1299673782=:4805
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 9 Mar 2011, Jean-Yves Avenard wrote:

> Hi
>
> On Wednesday, 9 March 2011, Raymond Yau <superquad.vortex2@gmail.com> wro=
te:
>
>> hda-intel.c only allocate 64Kbytes
>>
>>  =C2=A0 =C2=A0/* buffer pre-allocation */
>>  =C2=A0 =C2=A0snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_=
DEV_SG,
>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0snd_dma_pci_data(chip->pci),
>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A01024 * 64, 32 * 1024 * 1024);
>>
>> user or distribution need to change "prealloc" from 64 to a higher value=
 for
>> getting 500ms buffer
>>
>> echo 1024 > /proc/asound/Intel/pcm0p/sub0/prealloc
>
> It seems you misunderstood my first message.
>
> For a start, the default memory allocated to alsa in ubuntu is 4096kB.
> so the amount of ram isn't the problem.
>
> Setting a buffer of
> 200ms: ok
> 300ms: ok
> 400ms: not ok (invalid argument)
> 500ms: ok
>
> Why would 400ms gives invalid argument, when 500ms doesn't nor 300.
> Memory available is obviously not the issue.
>
> If only 64kB is allocated, requesting 200ms gives you 200ms
> 300ms -> 300ms
> 400ms -> invalid argument
> 500ms -> 371ms
> 600ms -> 371ms
>
> You would assume that requesting 400ms would work or return what can
> fit in what has been pre-allocated.

What is your dir argument (last one) for the near functions? If it's NULL=
=20
or value is zero, it means you request the exact value which may not be=20
available. Use -1 to request specified or smaller value or 1 to request=20
specified or bigger value.

 =09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-1467311155-1299673782=:4805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1467311155-1299673782=:4805--
