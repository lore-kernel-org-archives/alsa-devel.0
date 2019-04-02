From: Fletcher Woodruff <fletcherw@chromium.org>
Subject: Re: [PATCH 2/2] ASoC: rt5677: make ACPI property names match _DSD
Date: Tue, 2 Apr 2019 09:52:56 -0600
Message-ID: <CAN-6NYYPL=W66vnnqbXK+LBFbuSnpqL8iv+h_x4G67PWFsMoKA@mail.gmail.com>
References: <20190401205519.34023-1-fletcherw@chromium.org>
 <20190401205519.34023-2-fletcherw@chromium.org> <20190402050637.GW2059@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402050637.GW2059@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org, Ross Zwisler <zwisler@google.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 1, 2019 at 11:06 PM Mark Brown <broonie@kernel.org> wrote:
> On Mon, Apr 01, 2019 at 02:55:19PM -0600, Fletcher Woodruff wrote:
> > The rt5677 driver is using the wrong property names to read from ACPI.
> > Update the property names to match those from _DSD, so that the correct
> > GPIO pin numbers are read and that plug-detection works.
>
> > With this patch, plugging and unplugging the headphone jack switches
> > between headphones and speakers automatically.
>
> What makes you say that these properties are wrong?  Are you sure that
> this isn't just some other systems using different ACPI properties given
> the poor standardization for ACPI?  Your new ones look like they're DT
> properties pulled into ACPI while the existing ones look more idiomatic
> for ACPI.

The code to read those properties was originally added by commit 89128534f,
specifically to support the device I am trying to fix, the Chromebook
Pixel 2015.
Admittedly, it's possible some other device came along and matched these
property names since then, but I'm inclined to think we might be the only ones.

> It'd be fine to add your new DT style properties but this
> might break existing systems.

That said, I agree it would be safer to use the idiomatic ACPI names, and then
fall back to the DT style names if the idiomatic names fail. Does that sound
reasonable?
