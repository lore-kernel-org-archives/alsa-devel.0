From: Nikolaus Voss <nv@vosn.de>
Subject: Re: [PATCH] sound/soc/codecs/tas5720.c: add ACPI support
Date: Mon, 1 Jul 2019 10:55:59 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1907011055090.2390@fox.voss.local>
References: <20190628123416.16298-1-nikolaus.voss@loewensteinmedical.de> <20190628143037.GH5379@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190628143037.GH5379@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Andreas Dannenberg <dannenberg@ti.com>, "Andrew F. Davis" <afd@ti.com>, Kate Stewart <kstewart@linuxfoundation.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 28 Jun 2019, Mark Brown wrote:
> On Fri, Jun 28, 2019 at 02:34:16PM +0200, Nikolaus Voss wrote:
>> Add support for ACPI enumeration for tas5720 and tas5722.
>> Use device_match API to unify access to driver data for DT and ACPI.
>> Aggregate variant stuff into its own struct and directly reference
>> it in variant data for i2c/of/acpi_device_id.
>
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.
>
> There's a huge amount of refactoring in here as well as the enumeration
> changes, please split this up into a patch series as covered in
> submitting-patches.rst for review.
>

Ok, thanks for the feedback, I'll prepare a series.

Nikolaus
