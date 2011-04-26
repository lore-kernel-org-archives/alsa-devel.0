From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: Implement WM8962 DMIC support
Date: Tue, 26 Apr 2011 12:25:02 +0100
Message-ID: <20110426112501.GB11848@opensource.wolfsonmicro.com>
References: <1303758905-5638-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1303758905-5638-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04973BBB5B@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A24C24418
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 13:25:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04973BBB5B@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 25, 2011 at 12:33:14PM -0700, Stephen Warren wrote:

> I notice you added both a SND_SOC_DAPM_INPUT and a SND_SOC_DAPM_AIF_IN
> for the DMIC path here. Should the WM8903 DMIC patch I provided have
> done the same?

Note that the AIF widget here is a power control, not a routing control.
