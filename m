From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: tpa6130a2: Make DAPM
 registration optional, and direct interface
Date: Tue, 30 Nov 2010 14:30:13 +0000
Message-ID: <20101130143013.GM7403@rakim.wolfsonmicro.main>
References: <1291125604-10396-1-git-send-email-peter.ujfalusi@nokia.com>
	<1291125604-10396-6-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B7C001039BF
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 15:30:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291125604-10396-6-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 30, 2010 at 04:00:04PM +0200, Peter Ujfalusi wrote:
> Users can choose to not add the DAPM routes provided by the
> amp driver, but use the direct enable/disable interface
> from machine driver with SND_SOC_DAPM_HP's event callback.
> In some cases this method must be used to make the audio
> path pop noise free.

Is there any situation where it would undesirable to do this?  If not
it'd seem better to just make the driver do this always.

> +int tpa6130a2_stereo_enable(int enable)
> +{

It'd be much nicer if this took a CODEC as an argument - even if the
implementation doesn't actually use it yet it'd be better to have an
interface which has an idea that there may be multiple instances of the
device.
