From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] DaVinci: DM365: Add voice codec
 support for DM365 EVM
Date: Tue, 22 Sep 2009 14:44:33 -0700
Message-ID: <20090922214431.GD4736@sirena.org.uk>
References: <1253647849-32727-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s-utl02-sjpop.stsn.net (s-utl02-sjpop.stsn.net [72.254.0.202])
	by alsa0.perex.cz (Postfix) with SMTP id 65CCA244FD
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 23:45:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1253647849-32727-1-git-send-email-miguel.aguilar@ridgerun.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: miguel.aguilar@ridgerun.com
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 22, 2009 at 01:30:49PM -0600, miguel.aguilar@ridgerun.com wrote:
> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

> This patch enables the voice codec support for the DM365 EVM.

> For the DM365 EVM only one codec is able to be enabled at time,
> external (AIC3101) or internal (Voice Codec CQ0093). Either internal
> or external codec can be selected in the configuration menu.

> This patch was created based on the temp/asoc branch of the DaVinci
> git and it assumes that the patch "[PATCH v4 2/2] ASoC: Davinci:
> Add audio codec support for DM365 EVM" is applied.

> This patch was tested on the DM365 EVM rev C.

To be honest I'd be inclined to do the voice interface driver as a
second driver - there's not much shared hardware wise when it's in use
and it'd cut down on the ifdefery in the EVM drivers.
