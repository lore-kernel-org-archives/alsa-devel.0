From: Andrej Falout <andrej@falout.org>
Subject: Re: [PATCH v6 09/18] ASoC: omap-hdmi-audio: Add
 platfrom device for OMAP HDMI audio support (Jyri Sarha)
Date: Wed, 15 Oct 2014 21:26:31 +1300
Message-ID: <CAGzU1+Hw+XOzfZPJwM_8C+ryrfED5qhO00ESoTr55R4bw+6hdg@mail.gmail.com>
References: <CAGzU1+GE4P1rOaaUt=xpc-Cy2ZU=Oen-Gtpes_ijxVSWyNGDgg@mail.gmail.com>
 <543E2E29.2070405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com
 [209.85.217.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 2694E2604C6
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 10:26:32 +0200 (CEST)
Received: by mail-lb0-f182.google.com with SMTP id z11so570263lbi.41
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 01:26:31 -0700 (PDT)
In-Reply-To: <543E2E29.2070405@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you for you reply, Jyri,

Is there any reason, perhaps a hardware limitation, that would make this
impossible, or is this just by choice?

Eg. if I wanted to, could I implement DSD support on this platform?

Thanks,
Andrej Falout


On Wed, Oct 15, 2014 at 9:19 PM, Jyri Sarha <jsarha@ti.com> wrote:

> On 10/15/2014 02:30 AM, Andrej Falout wrote:
>
>> Hi Jyri,
>>
>> Is the audio support for OMAP HDMI supposed to support DSD audio?
>>
>> Eg, on page 6 of http://elinux.org/images/8/8e/HDMI_ELC_mythripk.pdf
>>
>> "Super Audio CD (DSD) support" starting from HDMI version 1.2
>>
>> Thanks,
>>
>> Andrej Falout
>>
>
> The software support is only for PCM audio* ATM and AFAIK there is no
> plans to add support any other formats in foreseeable future.
>
> * 8 chnnel LPCM, 192 kHhz, 24 bit audio
>
> Best regards,
> Jyri
>
>
