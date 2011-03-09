From: Jean-Yves Avenard <jyavenard@gmail.com>
Subject: Re: snd_pcm_hw_params_set_buffer_time_near: invalid
	argument
Date: Wed, 9 Mar 2011 23:23:41 +1100
Message-ID: <AANLkTik+ecGzz+yCoYhYCxHEJrsof5Eo_cxgnEU84wZm@mail.gmail.com>
References: <AANLkTik5sX_DWLsN3y_7ANpoF5rgeCNZY7gm=+rFhCsy@mail.gmail.com>
	<AANLkTimfZwH+dqsPZaifekmmctrARdE0DoK5nHoW1Fu_@mail.gmail.com>
	<AANLkTinNhknw6h81zkqhhXQwYyrKGs0mVjYpjYvZuNa=@mail.gmail.com>
	<AANLkTi=WkvaM+oLDAzyvcBzeg_kuB=33esFVXDZn1M48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DB6731039A1
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 13:23:43 +0100 (CET)
Received: by iwc10 with SMTP id 10so463387iwc.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 04:23:41 -0800 (PST)
In-Reply-To: <AANLkTi=WkvaM+oLDAzyvcBzeg_kuB=33esFVXDZn1M48@mail.gmail.com>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

On Wednesday, 9 March 2011, Raymond Yau <superquad.vortex2@gmail.com> wrote:

> hda-intel.c only allocate 64Kbytes
>
>  =A0 =A0/* buffer pre-allocation */
>  =A0 =A0snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_dma_pci_data(chip=
->pci),
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01024 * 64, 32 * 1024 =
* 1024);
>
> user or distribution need to change "prealloc" from 64 to a higher value =
for
> getting 500ms buffer
>
> echo 1024 > /proc/asound/Intel/pcm0p/sub0/prealloc

It seems you misunderstood my first message.

For a start, the default memory allocated to alsa in ubuntu is 4096kB.
so the amount of ram isn't the problem.

Setting a buffer of
200ms: ok
300ms: ok
400ms: not ok (invalid argument)
500ms: ok

Why would 400ms gives invalid argument, when 500ms doesn't nor 300.
Memory available is obviously not the issue.

If only 64kB is allocated, requesting 200ms gives you 200ms
300ms -> 300ms
400ms -> invalid argument
500ms -> 371ms
600ms -> 371ms

You would assume that requesting 400ms would work or return what can
fit in what has been pre-allocated.

Jy
