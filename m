From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v2 4/8] sound: soc: pxa: Suppress SND_MMP_SOC for arm64
Date: Thu, 23 Feb 2017 15:11:46 +0100
Message-ID: <473e4976-77eb-4b67-e874-ae6bd717ddaa@suse.de>
References: <20170222022929.10540-1-afaerber@suse.de>
 <20170222022929.10540-5-afaerber@suse.de>
 <20170222184734.wmkbzfsz4yklofcg@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170222184734.wmkbzfsz4yklofcg@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: info@andromedabox.org, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Am 22.02.2017 um 19:47 schrieb Mark Brown:
> On Wed, Feb 22, 2017 at 03:29:24AM +0100, Andreas F=E4rber wrote:
> =

> This is patch 4 of 8, what's going on with dependencies here?

No dependencies on previous patches. 5/8 adds ARCH_MMP to arm64.

It compiled without this (just Kconfig warnings), so this could go
through the appropriate sound tree as a cleanup.

> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.

Should I make it "ASoC: pxa: ..." then? SND_MMP_SOC selects SND_ARM,
which in sound/arm/Kconfig says 'Drivers that are implemented on ASoC
can be found in "ALSA for SoC audio support" section.', which confused
me about whether or not this is an ASoC compliant driver if it selects a
non-ASoC symbol.

>>  config SND_MMP_SOC
>> -	bool "Soc Audio for Marvell MMP chips"
>> -	depends on ARCH_MMP
>> +	bool "SoC Audio for Marvell MMP chips"
>> +	depends on ARCH_MMP && ARM
> =

> There are no obvious build time architecture dependencies for this
> driver, shouldn't we have an || COMPILE_TEST in here?

I'm the wrong person to answer that - the symbol relies on
architecture-specific SND_ARM, and my understanding was that the code
still relies on platform data, therefore it did not seem worthwhile to
just disable inapplicable dependencies such as MMP_SRAM
(arch/arm/mach-mmp/; superseded by DT mmio-sram) or SND_ARM.

Regards,
Andreas

-- =

SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
