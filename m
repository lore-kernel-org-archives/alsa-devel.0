From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 08/11] ASoC: Intel: atom: Make PCI dependency explicit
Date: Wed, 2 Jan 2019 10:36:43 +0100
Message-ID: <CAJZ5v0h3br9+a8x2Vy406hJ-Rp24zs+b-ijxGJx0z7=9msWE7g@mail.gmail.com>
References: <20181230195612.6657-1-okaya@kernel.org> <20181230195612.6657-9-okaya@kernel.org>
 <CAJZ5v0hSpAPzi2EcFKD_Wh23SeYnoJCAaQMGW=fSqgmhmhr37A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hSpAPzi2EcFKD_Wh23SeYnoJCAaQMGW=fSqgmhmhr37A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 2, 2019 at 10:34 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sun, Dec 30, 2018 at 8:56 PM Sinan Kaya <okaya@kernel.org> wrote:
> >
> > Code does unconditional select for IOSF_MBI. IOSF_MBI driver depends on
> > CONFIG_PCI set but this is not specified anywhere.
>
> IMO it would be better to say
>
> "After commit 5d32a66541c46 (PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set) dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly.  For this reason, add a direct dependency on
> CONFIG_PCI to the IOSF_MBI driver."
>
> If you did that, the reviewers would know upfront what this was about
> and that might save at least one back-and-forth e-mail exchange in
> each case.

But, of course, the changelog doesn't even match the patch contents in
this particular case.  Please fix that.
