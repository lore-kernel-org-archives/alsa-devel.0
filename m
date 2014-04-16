From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] of: add empty of_find_node_by_path() for
	!OF
Date: Wed, 16 Apr 2014 12:39:04 -0500
Message-ID: <CAL_Jsq+izG_YpQ2BLsyJkdPZhUZEX+T2FypHWak-x+FqeVV=-g@mail.gmail.com>
References: <1397630960-26677-1-git-send-email-shc_work@mail.ru>
 <CAL_Jsq+MtkQcKs06xggrZkQHncSCBx6ABCaiud8HokEgAX2NMA@mail.gmail.com>
 <20140416142502.GR12304@sirena.org.uk>
 <CAL_JsqJNs5n8XmRe+-JWAcmunnTAoqeNFUwP2B6OitBd=QtXYQ@mail.gmail.com>
 <20140416160352.GS12304@sirena.org.uk>
 <CAL_JsqKPYiQpv8PDPsemSEuXJc_2Roqu-G3+8rV4dSHbXuHfDw@mail.gmail.com>
 <20140416171552.GU12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f172.google.com (mail-vc0-f172.google.com
 [209.85.220.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 1566D2654DD
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 19:39:05 +0200 (CEST)
Received: by mail-vc0-f172.google.com with SMTP id la4so11114156vcb.17
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 10:39:04 -0700 (PDT)
In-Reply-To: <20140416171552.GU12304@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-ALSA <alsa-devel@alsa-project.org>, Alexander Shiyan <shc_work@mail.ru>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 16, 2014 at 12:15 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Apr 16, 2014 at 11:10:15AM -0500, Rob Herring wrote:
>
>> Yes. If this going to be a common pattern, a
>> of_get_machine_compatible() helper might be useful. Usually, any code
>> searching by path makes me suspicious.
>
> I've always been surprised we don't have more infrastructure for
> quirking off machine type in a similar way to how ACPI systems use DMI.

We used to have machine_is_blah which is kind of replaced by
of_machine_is_compatible, but yes that is a bit limited. What the fsl
ssi driver is doing isn't really a quirk anyway.

PCI also has a whole infrastructure for applying quirks. We could do
something similar which could add/fix properties or do various setup.
Then we'd be able to scatter calls everywhere:

OF_FIXUP("some-compatible-str", fixup_function);

I don't know that we want to encourge that, but would be a way to
separate handling old/broken bindings separately from current code
paths. I guess the question is whether we have many existing cases
(PPC, I'm looking at you) that would benefit.

BTW, I did propose something similar with conditional initcalls a
while back[1]. Perhaps as a fixup would be more acceptable than an
initcall.

Rob

[1] http://comments.gmane.org/gmane.linux.drivers.devicetree/50117
