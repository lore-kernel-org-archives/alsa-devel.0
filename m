From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCHv2 0/4] ASoC: multi-component - Samsung S3C
	Platform
Date: Fri, 16 Jul 2010 15:16:17 +0900
Message-ID: <1279260977-18342-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 975AA24471
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 08:25:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Seungwhan Youn <sw.youn@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <claude.youn@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,
	
This is a second version of patch series adding support for multi
component model on Samsung S3C Platform.

This patch series can be apply upon "ASoC: multi-component - Fix S3C
compile error" in the first patch of V1 that already applied by Liam.

Changes since V1:
- Support for GPIO, DMA and SFR settings pull from platform device
  resource.
- Modify description of add WM9713 platform device on smdk board.

The following patch series contains:

[PATCHv2 1/4] ASoC: S3C64XX: Move GPIO settings to platform
[PATCHv2 2/4] ASoC: S3C64XX: Move DMA settings to platform
[PATCHv2 3/4] ASoC: multi-component - S3C - Get original functionality
[PATCHv2 4/4] ASoC: multi-component - S3C - Add WM9713 platform device


Thanks,

Claude
