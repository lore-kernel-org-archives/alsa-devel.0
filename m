From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v6 09/18] ASoC: omap-hdmi-audio: Add
 platfrom device for OMAP HDMI audio support (Jyri Sarha)
Date: Wed, 15 Oct 2014 13:27:21 +0300
Message-ID: <543E4C09.4070108@ti.com>
References: <CAGzU1+GE4P1rOaaUt=xpc-Cy2ZU=Oen-Gtpes_ijxVSWyNGDgg@mail.gmail.com>	<543E2E29.2070405@ti.com>
 <CAGzU1+Hw+XOzfZPJwM_8C+ryrfED5qhO00ESoTr55R4bw+6hdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C47A260413
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 12:27:27 +0200 (CEST)
In-Reply-To: <CAGzU1+Hw+XOzfZPJwM_8C+ryrfED5qhO00ESoTr55R4bw+6hdg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrej Falout <andrej@falout.org>
Cc: alsa-devel@alsa-project.org, "to >> Valkeinen,
 Tomi" <tomi.valkeinen@ti.com>
List-Id: alsa-devel@alsa-project.org

On 10/15/2014 11:26 AM, Andrej Falout wrote:
> Thank you for you reply, Jyri,
>
> Is there any reason, perhaps a hardware limitation, that would make this
> impossible, or is this just by choice?
>
> Eg. if I wanted to, could I implement DSD support on this platform?
>
> Thanks,
> Andrej Falout
>

After a brief look at the documentation it does not look like the 
OMAP4/5 HDMI module could support anything else but PCM audio. It could 
of course be that the documents I have only describe the use for PCM 
audio, but in any case it would be an uphill battle as even the 
documents I have are under NDA and I am not aware of any better 
documents about the subject.

Best regards,
Jyri

>
> On Wed, Oct 15, 2014 at 9:19 PM, Jyri Sarha <jsarha@ti.com
> <mailto:jsarha@ti.com>> wrote:
>
>     On 10/15/2014 02:30 AM, Andrej Falout wrote:
>
>         Hi Jyri,
>
>         Is the audio support for OMAP HDMI supposed to support DSD audio?
>
>         Eg, on page 6 of
>         http://elinux.org/images/8/8e/__HDMI_ELC_mythripk.pdf
>         <http://elinux.org/images/8/8e/HDMI_ELC_mythripk.pdf>
>
>         "Super Audio CD (DSD) support" starting from HDMI version 1.2
>
>         Thanks,
>
>         Andrej Falout
>
>
>     The software support is only for PCM audio* ATM and AFAIK there is
>     no plans to add support any other formats in foreseeable future.
>
>     * 8 chnnel LPCM, 192 kHhz, 24 bit audio
>
>     Best regards,
>     Jyri
>
>
