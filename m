From: Guenter Roeck <groeck@google.com>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards compatibility
 with v4 topology files
Date: Wed, 23 May 2018 09:17:23 -0700
Message-ID: <CABXOdTePWquSQaFQsoNTrVNmYydZLqF534zeoTfz0RfLDHSseA@mail.gmail.com>
References: <20180522165842.233949-1-groeck@google.com> <s5hmuwqpjdd.wl-tiwai@suse.de>
 <20180523135609.GK4828@sirena.org.uk> <CABXOdTeCr-ExO9O3XAHK-DnNf5yLGO0TPkXgs60TB90jGNB2_Q@mail.gmail.com>
 <20180523155811.GO4828@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180523155811.GO4828@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Guenter Roeck <groeck@chromium.org>, "Patel, Chintan M" <chintan.m.patel@intel.com>, Jaroslav Kysela <perex@perex.cz>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 23, 2018 at 8:58 AM Mark Brown <broonie@kernel.org> wrote:

> On Wed, May 23, 2018 at 08:54:18AM -0700, Guenter Roeck wrote:
> > On Wed, May 23, 2018 at 6:56 AM Mark Brown <broonie@kernel.org> wrote:
> > > On Wed, May 23, 2018 at 03:54:54PM +0200, Takashi Iwai wrote:

> > > > And I'm wondering whether we should move these definitions to uapi
> > > > headers.

> > > Yes, we should.

> > Are you sure ? They used to be in
> >  sound/soc/intel/skylake/skl-tplg-interface.h.
> > I took my clue from sound/soc/soc-topology.c, where the v4 structures
are
> > also
> > declared locally and not in the uapi files.

> I'm saying we should move them there.  They're clearly part of the
> userspace ABI and therefore belong in uapi, it was a mistake to let them
> be elsewhere.

They define a firmware file format. Not sure if I would call that userspace
ABI.

I don't mind adding the structures to
sound/soc/intel/skylake/skl-tplg-interface.h,
but it seems a bit out of scope to tie this with moving the file to
include/uapi/sound.
I think that should be a separate discussion.

Thanks,
Guenter
