From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH 3/4] Add Wolfson Microelectronics WM8776
	codec ALSA driver
Date: Tue, 17 Apr 2012 18:13:40 +0200
Message-ID: <201204171813.44044.linux@rainbow-software.org>
References: <1334611118-10301-1-git-send-email-linux@rainbow-software.org>
	<1334611118-10301-4-git-send-email-linux@rainbow-software.org>
	<20120417150234.GB22575@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1-out2.atlantis.sk [80.94.52.71])
	by alsa0.perex.cz (Postfix) with ESMTP id A7CB41042DD
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 18:14:06 +0200 (CEST)
In-Reply-To: <20120417150234.GB22575@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 17 April 2012 17:02:34 Mark Brown wrote:
> On Mon, Apr 16, 2012 at 11:18:37PM +0200, Ondrej Zary wrote:
> > Needed by Philips PSC724 subdriver. The code does not contain any
> > card-specific bits so it can be used by any other ALSA driver.
>
> Same comments as the previous patch, this should be using ASoC.  In this
> case the device has in fact been supported in mainline since 2.6.32...

Yes, the driver is there - but I dont's see any way to use it. ASoC was not 
designed to be used with sound cards and nobody has ever used any ASoC driver 
in a sound card driver. I don't feel like breaking a working driver (with 16 
subdrivers for many more card types).

-- 
Ondrej Zary
