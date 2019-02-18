From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH] ASoC: simple-card: Fix refcount underflow
Date: Mon, 18 Feb 2019 20:00:48 +0200
Message-ID: <CAEnQRZCLE7DHumOCDSXxaKEgpukDgP5EtH=j7xMwTBJcTWQTZw@mail.gmail.com>
References: <20190216100927.10017-1-daniel.baluta@nxp.com>
 <87pnrp52jl.wl-kuninori.morimoto.gx@renesas.com>
 <87lg2d51lv.wl-kuninori.morimoto.gx@renesas.com>
 <b4bee8ff1307004ec9d1122f70ab2cb0d636ea4a.camel@nxp.com>
 <s5hpnrp8ret.wl-tiwai@suse.de> <20190218175010.GB10794@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DF64265530
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 19:01:00 +0100 (CET)
Received: by mail-ed1-f66.google.com with SMTP id a2so14599321edi.0
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 10:01:00 -0800 (PST)
In-Reply-To: <20190218175010.GB10794@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "vicencb@gmail.com" <vicencb@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 18, 2019 at 7:50 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Feb 18, 2019 at 08:52:26AM +0100, Takashi Iwai wrote:
> > Daniel Baluta wrote:
>
> > > > Fixes: commit da215354eb55c ("ASoC: simple-card: merge simple-scu-
> > > > card")
>
> > > Thanks! I thought about adding this but the current patch will not
> > > cleanly apply because of:
>
> > > 2d01a84605a55c ("ASoC: simple-card: reduce naming prefix")
>
> That doesn't matter for fixes tags.  However...
>
> > Yeah, it's a bit tricky because of the code change at this time.
>
> > At best, send two patches, once for 5.0 and once for 5.1, and let Mark
> > apply both of them and do the empty merge from 5.0 to 5.1, or let him
> > resolve the merge conflict by applying manually the 5.1 patch.
>
> ...since this is something that needs to be fixed for v5.0 we need a
> patch that can be applied on v5.0 (and has been tested by someone who
> sees the issue there).  Takashi's plan seems like a good way to do that,
> if you could send a patch against my for-5.0 branch (or just Linus'
> tree) that'd be great.

for-5.0 branch Kuninori's patch works fine:

https://patchwork.kernel.org/patch/10814255/

for-5.1 branch and later my patch works fine:

https://patchwork.kernel.org/patch/10817449/

Would you want me to change the patch for 5.0 to have an identical commit
message as the one for 5.1?
