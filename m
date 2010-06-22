From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] codecs/tlv320aic23: fix bias management
 for suspend/resume
Date: Wed, 23 Jun 2010 00:17:53 +0100
Message-ID: <20100622231752.GC2453@opensource.wolfsonmicro.com>
References: <20100619105929.GB2409@opensource.wolfsonmicro.com>
	<1276968819-17285-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B3DE2449A
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 01:17:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1276968819-17285-1-git-send-email-eric@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: anuj.aggarwal@ti.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 19, 2010 at 07:33:39PM +0200, Eric B=E9nard wrote:

> in tlv320aic23_set_bias_level, for the case SND_SOC_BIAS_ON, the
> comment says "vref/mid, osc on, dac unmute" but the code doesn't
> clear the corresponding bits, thus when resuming, several bits are
> not cleared preventing the codec from working.

Sorry - I should've registered that this was one that should go through
Liam's tree

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
