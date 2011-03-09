From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_pcm_hw_params_set_buffer_time_near: invalid
	argument
Date: Wed, 9 Mar 2011 11:52:34 +0800
Message-ID: <AANLkTi=WkvaM+oLDAzyvcBzeg_kuB=33esFVXDZn1M48@mail.gmail.com>
References: <AANLkTik5sX_DWLsN3y_7ANpoF5rgeCNZY7gm=+rFhCsy@mail.gmail.com>
	<AANLkTimfZwH+dqsPZaifekmmctrARdE0DoK5nHoW1Fu_@mail.gmail.com>
	<AANLkTinNhknw6h81zkqhhXQwYyrKGs0mVjYpjYvZuNa=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id CADD624436
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 04:52:34 +0100 (CET)
Received: by fxm11 with SMTP id 11so106164fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Mar 2011 19:52:34 -0800 (PST)
In-Reply-To: <AANLkTinNhknw6h81zkqhhXQwYyrKGs0mVjYpjYvZuNa=@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/3/8 Jean-Yves Avenard <jyavenard@gmail.com>

> On 7 March 2011 23:24, Raymond Yau <superquad.vortex2@gmail.com> wrote:
>
> > This seem to be bug in alsa-lib as I can reproduce using
> alsa-lib/test/pcm.c
> > with buffer time 120000 and my hda codec support both 11025Hz and 22050Hz
> >
> > using buffer time 160000 is OK
>
> Yes.. It's hard to understand why 120ms wouldn't be okay, but 160ms would.
>
> Could you check is 400ms works for you ? I found this to be a value
> that generally do not work when using 44.1kHz 6 channels audio.
>
> For the time being, I made my application use 500ms buffer; this is
> what many media players are using (including mplayer) , so I'm
> guessing it would be fine under most circumstances otherwise we would
> have heard about it before.
>
> Jean-Yves
>

hda-intel.c only allocate 64Kbytes

    /* buffer pre-allocation */
    snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
                          snd_dma_pci_data(chip->pci),
                          1024 * 64, 32 * 1024 * 1024);

user or distribution need to change "prealloc" from 64 to a higher value for
getting 500ms buffer

echo 1024 > /proc/asound/Intel/pcm0p/sub0/prealloc
