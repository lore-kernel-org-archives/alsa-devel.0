From: Evan Green <evgreen@chromium.org>
Subject: Re: [alsa-devel] [PATCH v1 1/2] ASoC: SOF: Add Comet Lake PCI ID
Date: Tue, 7 May 2019 13:51:44 -0700
Message-ID: <CAE=gft5TeW1h3GAT9Gkwdf8eE_p5aoywveE2ddXgYQ+fET8Sdg@mail.gmail.com>
References: <20190506225321.74100-1-evgreen@chromium.org> <20190506225321.74100-2-evgreen@chromium.org>
 <74e8cfcd-b99f-7f66-48ce-44d60eb2bbca@linux.intel.com> <64FD1F8348A3A14CA3CB4D4C9EB1D15F30A7C756@BGSMSX107.gar.corp.intel.com>
 <5c42b741-5e5c-ce00-8321-59df1df115f1@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5c42b741-5e5c-ce00-8321-59df1df115f1@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "M R, Sathya Prakash" <sathya.prakash.m.r@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Rajat Jain <rajatja@chromium.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ben Zhang <benzh@chromium.org>, "M, Naveen" <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 7, 2019 at 1:26 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> > On 5/6/19 5:53 PM, Evan Green wrote:
> >>> Add support for Intel Comet Lake platforms by adding a new Kconfig for
> >>> CometLake and the appropriate PCI ID.
> >
> >> This is odd. I checked internally a few weeks back and the CML PCI ID was 9dc8, same as WHL and CNL, so we did not add a PCI ID on purpose. To the best of my knowledge SOF probes fine on CML and the known issues can be found on the SOF github [1].
> >
> > The PCI ID change is seen on later production Si versions. The PCI ID is 02c8.
>
> As I suspected, we are talking about different skews and generations of
> the chipset and a board-level change, not silicon change.
>
> The CNL PCH-LP PCI ID is 0x9DC8, the CNL PCH-H PCI ID is 0xA348 (used
> for CoffeeLake). Both are supported by SOF.
>
> What we are missing are the PCI IDs for CML PCH-LP (0x02C8) and CML
> PCH-H (0x06C8).
>
> Can we respin this patchset to add support for those last two instead of
> just the -LP case?

Sure. So just to clarify, you want the entry for 0x02c8, and you want
an additional entry for 0x06c8 under the same config. Will do.

>
> I'll send a patch to add those IDs for the HDaudio legacy driver for
> consistency.

Actually I've got that change ready to go too, I'm happy to send that out.

>
> Thanks!
> -Pierre
