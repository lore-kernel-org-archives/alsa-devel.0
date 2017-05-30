From: Bhumika Goyal <bhumirks@gmail.com>
Subject: Re: [PATCH] ALSA: declare snd_kcontrol_new structures
	as const
Date: Tue, 30 May 2017 14:29:59 +0530
Message-ID: <CAOH+1jEFvj_A2q6L+OjCZYrDvgfzthYk+fNkhzVh59FKh42aAg@mail.gmail.com>
References: <1495896375-30855-1-git-send-email-bhumirks@gmail.com>
 <s5hvaoiencx.wl-tiwai@suse.de> <alpine.DEB.2.20.1705301056200.2981@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f178.google.com (mail-io0-f178.google.com
 [209.85.223.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 55662266CE7
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 11:00:01 +0200 (CEST)
Received: by mail-io0-f178.google.com with SMTP id f102so52453526ioi.2
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 02:00:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1705301056200.2981@hadrien>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, clemens@ladisch.de, Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org, Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 30, 2017 at 2:26 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Tue, 30 May 2017, Takashi Iwai wrote:
>
>> On Sat, 27 May 2017 16:46:15 +0200,
>> Bhumika Goyal wrote:
>> >
>> > Declare snd_kcontrol_new structures as const as they are only passed an
>> > argument to the function snd_ctl_new1. This argument is of type const,
>> > so snd_kcontrol_new structures having this property can be made const.
>> > Done using Coccinelle:
>> >
>> > @r disable optional_qualifier@
>> > identifier x;
>> > position p;
>> > @@
>> > static struct snd_kcontrol_new x@p={...};
>> >
>> > @ok@
>> > identifier r.x;
>> > position p;
>> > @@
>> > snd_ctl_new1(&x@p,...)
>> >
>> > @bad@
>> > position p != {r.p,ok.p};
>> > identifier r.x;
>> > @@
>> > x@p
>> >
>> > @depends on !bad disable optional_qualifier@
>> > identifier r.x;
>> > @@
>> > +const
>> > struct snd_kcontrol_new x;
>> >
>> > Cross compiled these files:
>> > sound/aoa/codecs/tas.c - powerpc
>> > sound/mips/{hal2.c/sgio2audio.c} - mips
>> > sound/ppc/{awacs.c/beep.c/tumbler.c} - powerpc
>> > sound/soc/sh/siu_dai.c - sh
>> > Could not find an architecture to compile sound/sh/aica.c.
>> >
>> > Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
>>
>> Applied now, as it looks safe enough.  But I prefer splitting to
>> individual patches, so please try to do that at the next time.
>
> Individual patches in a series?
>

Yes, I think so. Takashi told to send a patchset for similar changes.

Thanks,
Bhumika

> julia
