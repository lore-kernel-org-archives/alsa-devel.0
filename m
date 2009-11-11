From: Jassi Brar <jassi.brar@samsung.com>
Subject: Revised Patches for Samsung SoC PCM Controller driver
Date: Wed, 11 Nov 2009 13:44:49 +0900
Message-ID: <1257914690-4357-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id D73FE1038C4
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 05:50:04 +0100 (CET)
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

 (I have made a few modifications suggested for previous set of patches)

Samsung SoCs S3C2450, S3C64XX and later versions have got PCM controllers
which drive what the ALSA stack terms DSP_A/DSP_B formats.

Since the S3C ALSA platform driver was named s3c24xx-pcm, which cause
direct namespace clash with the new PCM controller drivers, it has been
renamed along with some of its local symbols.

First two of the following series of patches does that and later ones
make ground for and add the PCM controller driver.

regards.
