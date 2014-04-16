From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] of: add empty of_find_node_by_path() for
	!OF
Date: Wed, 16 Apr 2014 11:10:15 -0500
Message-ID: <CAL_JsqKPYiQpv8PDPsemSEuXJc_2Roqu-G3+8rV4dSHbXuHfDw@mail.gmail.com>
References: <1397630960-26677-1-git-send-email-shc_work@mail.ru>
 <CAL_Jsq+MtkQcKs06xggrZkQHncSCBx6ABCaiud8HokEgAX2NMA@mail.gmail.com>
 <20140416142502.GR12304@sirena.org.uk>
 <CAL_JsqJNs5n8XmRe+-JWAcmunnTAoqeNFUwP2B6OitBd=QtXYQ@mail.gmail.com>
 <20140416160352.GS12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f176.google.com (mail-ve0-f176.google.com
 [209.85.128.176])
 by alsa0.perex.cz (Postfix) with ESMTP id DC14D2654A7
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 18:10:16 +0200 (CEST)
Received: by mail-ve0-f176.google.com with SMTP id db11so11064540veb.35
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 09:10:15 -0700 (PDT)
In-Reply-To: <20140416160352.GS12304@sirena.org.uk>
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

On Wed, Apr 16, 2014 at 11:03 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Apr 16, 2014 at 09:32:37AM -0500, Rob Herring wrote:
>> On Wed, Apr 16, 2014 at 9:25 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Is there a branch I can pull into ASoC, or can I apply it there?  This
>> > fixes a build failure introduced into there by some recent work.
>
>> I haven't pushed it out yet. You can take it and add my ack if you
>> want instead. Otherwise, I do plan to send fixes to Linus this week.
>
> OK, this is needed for new development so I'll apply it temporarily so I
> don't break my tree in -next and then discard it once Linus merges -
> sound sensible?

Yes. If this going to be a common pattern, a
of_get_machine_compatible() helper might be useful. Usually, any code
searching by path makes me suspicious.

Rob
