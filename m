From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] ALSA: sound/isa: constify snd_kcontrol_new
	structures
Date: Mon, 22 May 2017 08:20:45 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1705220820080.1957@hadrien>
References: <1495021136-6999-1-git-send-email-bhumirks@gmail.com>
 <s5h4lwjd68p.wl-tiwai@suse.de>
 <CAOH+1jGYQpTsfaMSUF+iGuj6uERkb_PK_nJO_KZu42e05E5r5g@mail.gmail.com>
 <s5h7f1ak7oe.wl-tiwai@suse.de>
 <CAOH+1jE-89KhRfSUwi5wxpdEtwD+x_OYfjUhTc9K1s_uUViwPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FAD2266851
 for <alsa-devel@alsa-project.org>; Mon, 22 May 2017 08:20:47 +0200 (CEST)
In-Reply-To: <CAOH+1jE-89KhRfSUwi5wxpdEtwD+x_OYfjUhTc9K1s_uUViwPA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On Mon, 22 May 2017, Bhumika Goyal wrote:

> On Sun, May 21, 2017 at 12:39 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > On Wed, 17 May 2017 14:33:45 +0200,
> > Bhumika Goyal wrote:
> >>
> >> On Wed, May 17, 2017 at 5:50 PM, Takashi Iwai <tiwai@suse.de> wrote:
> >> > On Wed, 17 May 2017 13:38:56 +0200,
> >> > Bhumika Goyal wrote:
> >> >>
> >> >> Declare snd_kcontrol_new structures as const as they are only passed an
> >> >> argument to the function snd_ctl_new1. This argument is of type const,
> >> >> so snd_kcontrol_new structures having this property can be made const.
> >> >> Done using Coccinelle:
> >> >>
> >> >> @r disable optional_qualifier@
> >> >> identifier x;
> >> >> position p;
> >> >> @@
> >> >> static struct snd_kcontrol_new x@p={...};
> >> >>
> >> >> @ok@
> >> >> identifier r.x;
> >> >> position p;
> >> >> @@
> >> >> snd_ctl_new1(&x@p,...)
> >> >>
> >> >> @bad@
> >> >> position p != {r.p,ok.p};
> >> >> identifier r.x;
> >> >> @@
> >> >> x@p
> >> >>
> >> >> @depends on !bad disable optional_qualifier@
> >> >> identifier r.x;
> >> >> @@
> >> >> +const
> >> >> struct snd_kcontrol_new x;
> >> >>
> >> >> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> >> >
> >> > As I already asked, could you send as a patchset if you have multiple
> >> > similar patches?
> >> >
> >>
> >> Sure. Will combine the already sent ones and some new ones into a
> >> patchset and send again.
> >
> > Well, since there haven't been new submissions and the patches are
> > trivial, I applied the existing four patches.  If you have newer ones,
> > please submit as a patchset.
> >
> >
>
> Hey,
>
> Thanks for applying the patches.
> I have a doubt that since some of my coming patches are for the sound
> subsystem containing similar changes and you will be applying those,
> so can I combine and put all the changes in a single patch or sending
> a patchset would be a correct way.

I think he means that when you have more sound patches, just do them all
at once.

julia
