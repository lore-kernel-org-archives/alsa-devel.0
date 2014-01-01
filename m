From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: imx-spdif: Use snd-soc-dummy CODEC
 driver to link card
Date: Wed, 1 Jan 2014 15:12:32 +0800
Message-ID: <20140101071230.GA7436@MrMyself>
References: <1387790933-29232-1-git-send-email-Guangyu.Chen@freescale.com>
 <20131231163422.GJ31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 by alsa0.perex.cz (Postfix) with ESMTP id BD5E326087B
 for <alsa-devel@alsa-project.org>; Wed,  1 Jan 2014 08:15:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131231163422.GJ31886@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux@arm.linux.org.uk, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 31, 2013 at 04:34:22PM +0000, Mark Brown wrote:
> On Mon, Dec 23, 2013 at 05:28:53PM +0800, Nicolin Chen wrote:
> > This is a quick fix for the below two issues when building spdif as modules.
> 
> Good thinking - this is a smart way of dealing with the issue.  It'll
> mean that we don't have the application specific constraints but those
> could be added back in the driver later or we could do an explicit
> S/PDIF CODEC in the same style as dummy.  Applied, thanks.

Yes, it can circumvent all the unnecessary problems we've been through here
even though the CODEC name 'dummy' doesn't look so flawless. The application
constraints, what I understand should be the supporting formats and rates,
have been already ensured in the CPU DAI driver, so we might not need to worry
for the CODEC one.

Thank you for the suggestion of dummy driver at the first place and..
Happy new year :)
Nicolin Chen
