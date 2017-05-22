From: Bhumika Goyal <bhumirks@gmail.com>
Subject: Re: [PATCH] ALSA: sound/isa: constify snd_kcontrol_new structures
Date: Mon, 22 May 2017 11:22:27 +0530
Message-ID: <CAOH+1jE-89KhRfSUwi5wxpdEtwD+x_OYfjUhTc9K1s_uUViwPA@mail.gmail.com>
References: <1495021136-6999-1-git-send-email-bhumirks@gmail.com>
 <s5h4lwjd68p.wl-tiwai@suse.de> <CAOH+1jGYQpTsfaMSUF+iGuj6uERkb_PK_nJO_KZu42e05E5r5g@mail.gmail.com>
 <s5h7f1ak7oe.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h7f1ak7oe.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Julia Lawall <julia.lawall@lip6.fr>, perex@perex.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, May 21, 2017 at 12:39 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Wed, 17 May 2017 14:33:45 +0200,
> Bhumika Goyal wrote:
>>
>> On Wed, May 17, 2017 at 5:50 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Wed, 17 May 2017 13:38:56 +0200,
>> > Bhumika Goyal wrote:
>> >>
>> >> Declare snd_kcontrol_new structures as const as they are only passed an
>> >> argument to the function snd_ctl_new1. This argument is of type const,
>> >> so snd_kcontrol_new structures having this property can be made const.
>> >> Done using Coccinelle:
>> >>
>> >> @r disable optional_qualifier@
>> >> identifier x;
>> >> position p;
>> >> @@
>> >> static struct snd_kcontrol_new x@p={...};
>> >>
>> >> @ok@
>> >> identifier r.x;
>> >> position p;
>> >> @@
>> >> snd_ctl_new1(&x@p,...)
>> >>
>> >> @bad@
>> >> position p != {r.p,ok.p};
>> >> identifier r.x;
>> >> @@
>> >> x@p
>> >>
>> >> @depends on !bad disable optional_qualifier@
>> >> identifier r.x;
>> >> @@
>> >> +const
>> >> struct snd_kcontrol_new x;
>> >>
>> >> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
>> >
>> > As I already asked, could you send as a patchset if you have multiple
>> > similar patches?
>> >
>>
>> Sure. Will combine the already sent ones and some new ones into a
>> patchset and send again.
>
> Well, since there haven't been new submissions and the patches are
> trivial, I applied the existing four patches.  If you have newer ones,
> please submit as a patchset.
>
>

Hey,

Thanks for applying the patches.
I have a doubt that since some of my coming patches are for the sound
subsystem containing similar changes and you will be applying those,
so can I combine and put all the changes in a single patch or sending
a patchset would be a correct way.

Thanks,
Bhumika

> thanks,
>
> Takashi
