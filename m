From: Jassi Brar <jassi.brar@samsung.com>
Subject: Patches for Samsung SoC PCM Controller driver
Date: Tue, 17 Nov 2009 16:53:17 +0900
Message-ID: <1258444397-23576-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 3318924452
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 09:01:23 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

Hello,

(I re-submit patches after making changes suggested yesterday by Ben Dooks.)

Samsung SoCs S3C2450, S3C64XX and later versions have got PCM controllers
which drive what the ALSA stack terms DSP_A/DSP_B formats.

Since the S3C ALSA platform driver was named s3c24xx-pcm, which cause
direct namespace clash with the new PCM controller drivers, it has been
renamed along with some of its local symbols.

First two of the following series of patches does that and later ones
make ground for and add the PCM controller driver.

regards.
