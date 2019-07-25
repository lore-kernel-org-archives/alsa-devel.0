From: Joe Perches <joe@perches.com>
Subject: Re: Applied "ASoC: Intel: Fix some acpi vs apci typo in somme
 comments" to the asoc tree
Date: Thu, 25 Jul 2019 06:44:55 -0700
Message-ID: <8179fff75f82ac49aaa0c5feb17b53be55f9f2c5.camel@perches.com>
References: <20190725131925.D36082742B5F@ypsilon.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725131925.D36082742B5F@ypsilon.sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, liam.r.girdwood@linux.intel.com, linux-kernel@vger.kernel.org, perex@perex.cz, pierre-louis.bossart@linux.intel.com, tiwai@suse.com, yang.jie@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2019-07-25 at 14:19 +0100, Mark Brown wrote:
> The patch
> 
>    ASoC: Intel: Fix some acpi vs apci typo in somme comments
[]
> diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
[]
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * soc-apci-intel-bxt-match.c - tables and support for BXT ACPI enumeration.
> + * soc-acpi-intel-bxt-match.c - tables and support for BXT ACPI enumeration.

Generally, using the current filename in a comment has little value.

This might as well be

 * tables and support for BXT ACPI enumeration

etc...
