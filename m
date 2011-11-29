From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] sound/soc/codecs: add LAPIS
	Semiconductor ML26124
Date: Tue, 29 Nov 2011 14:38:43 +0000
Message-ID: <20111129143842.GC26800@opensource.wolfsonmicro.com>
References: <1322474755-18785-1-git-send-email-tomoya.rohm@gmail.com>
	<4ED37CE3.6040008@metafoo.de>
	<CANKRQnh7MnSQdKXvPJvSPzf-7afXmHip9LqR1cKCgB6HXqcnBg@mail.gmail.com>
	<4ED4EE48.8070100@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4679E1037FC
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 15:38:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4ED4EE48.8070100@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 29, 2011 at 03:38:00PM +0100, Lars-Peter Clausen wrote:

> Also this doesn't make much sense:
> +	{"Input Mux", "Analog MIC in", "MICBIAS"},
> +	{"Input Mux", "Digital MIC in", "MICBIAS"},

> You have mux, but both possible settings of the mux connect to the same
> source, which pretty much makes the mux useless.

Plus the fact that the MICBIAS is unlikely to be directly connected to
either input within the CODEC, it will almost certainly be connected by
circuitry on the board and therefore mapped by the machine driver for
the system.
