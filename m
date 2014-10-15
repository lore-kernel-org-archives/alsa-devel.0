From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v6 09/18] ASoC: omap-hdmi-audio: Add
 platfrom device for OMAP HDMI audio support (Jyri Sarha)
Date: Wed, 15 Oct 2014 11:19:53 +0300
Message-ID: <543E2E29.2070405@ti.com>
References: <CAGzU1+GE4P1rOaaUt=xpc-Cy2ZU=Oen-Gtpes_ijxVSWyNGDgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 589BD2604B0
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 10:19:57 +0200 (CEST)
In-Reply-To: <CAGzU1+GE4P1rOaaUt=xpc-Cy2ZU=Oen-Gtpes_ijxVSWyNGDgg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrej Falout <andrej@falout.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/15/2014 02:30 AM, Andrej Falout wrote:
> Hi Jyri,
>
> Is the audio support for OMAP HDMI supposed to support DSD audio?
>
> Eg, on page 6 of http://elinux.org/images/8/8e/HDMI_ELC_mythripk.pdf
>
> "Super Audio CD (DSD) support" starting from HDMI version 1.2
>
> Thanks,
>
> Andrej Falout

The software support is only for PCM audio* ATM and AFAIK there is no 
plans to add support any other formats in foreseeable future.

* 8 chnnel LPCM, 192 kHhz, 24 bit audio

Best regards,
Jyri
