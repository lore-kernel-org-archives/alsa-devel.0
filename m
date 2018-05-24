From: Guenter Roeck <groeck@google.com>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Thu, 24 May 2018 07:55:06 -0700
Message-ID: <CABXOdTfKXqgRecs3xuxb-XRodJkK7+h5V0hqt889CsD6vkm5yA@mail.gmail.com>
References: <20180522165842.233949-1-groeck@google.com>
 <s5hmuwqpjdd.wl-tiwai@suse.de>
 <20180523135609.GK4828@sirena.org.uk>
 <CABXOdTeCr-ExO9O3XAHK-DnNf5yLGO0TPkXgs60TB90jGNB2_Q@mail.gmail.com>
 <20180523155811.GO4828@sirena.org.uk>
 <CABXOdTePWquSQaFQsoNTrVNmYydZLqF534zeoTfz0RfLDHSseA@mail.gmail.com>
 <20180524141842.GW4828@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb0-f196.google.com (mail-yb0-f196.google.com
 [209.85.213.196])
 by alsa0.perex.cz (Postfix) with ESMTP id AAB9D266C1C
 for <alsa-devel@alsa-project.org>; Thu, 24 May 2018 16:55:20 +0200 (CEST)
Received: by mail-yb0-f196.google.com with SMTP id w14-v6so689607ybm.5
 for <alsa-devel@alsa-project.org>; Thu, 24 May 2018 07:55:20 -0700 (PDT)
In-Reply-To: <20180524141842.GW4828@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Patel,
 Chintan M" <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 24, 2018 at 7:18 AM Mark Brown <broonie@kernel.org> wrote:

> On Wed, May 23, 2018 at 09:17:23AM -0700, Guenter Roeck wrote:
> > On Wed, May 23, 2018 at 8:58 AM Mark Brown <broonie@kernel.org> wrote:

> > > I'm saying we should move them there.  They're clearly part of the
> > > userspace ABI and therefore belong in uapi, it was a mistake to let
them
> > > be elsewhere.

> > They define a firmware file format. Not sure if I would call that
userspace
> > ABI.

> It's a binary provided by userspace to the kernel, I'd say that's
> clearly an ABI.

> > I don't mind adding the structures to
> > sound/soc/intel/skylake/skl-tplg-interface.h,
> > but it seems a bit out of scope to tie this with moving the file to
> > include/uapi/sound.
> > I think that should be a separate discussion.

> Is there some reason not to just do it while we're looking at this?  I
> don't see why we wouldn't want to do this.

I don't mind doing this. However, keeping the change local and in a single
patch
would make it easier to backport, and I think that the ability to backport
would be
essential to get more than one-person test coverage. I also would have liked
feedback from someone at Intel, at least for the Skylake specific
structures.

Anyway, what file do you have in mind for the structure definitions, both
for the ones
in soc-tolopogy.c and the ones needed in skl-topology.c ? Everything into
asoc.h,
or something else ?

Guenter
