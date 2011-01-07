From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH 0/4] ASoC: SAMSUNG: Code clean-up suitable for
	current ASoC
Date: Fri,  7 Jan 2011 13:43:49 +0900
Message-ID: <1294375429-16729-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 190A024632
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 06:06:07 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi,

This patch remove(or move) unnecessary or un-suitable features on current
ASoC for all Samsung audio drivers and its supports. After multi-component
model patch, ASoC core part controls dai_links instead of _hard_wired_
dai links on machine drivers. Due to apply this model, many machine drivers
don't need codecs and platforms includes to make _hard_wired_ dai_links.
And also, ASoC core header file 'sound/soc.h' has basic includes for device
driver, so many of includes in each machine/platform driver are duplicated
and not essentially needed.

So, this patch-set check each platform/machine drivers' includes and
definitions are suitable or not, remove unnecessary features with compile
tests.


These patches are modify below features:-
 o Remove unnecessary 'ac97.h' header file.
 o Move each specific definitions, not to be shared by header files.
 o Clean-up unnecessary header includes.

This patch-set is based on two different branches that :-
 o ASoC patches are based on Mark Brown's git branch 'for-next'
   (commit id - f6c2ed5dd6ab43447dacc136585fc894e3f3a82d)

This patch-set contains followings :-
 o [PATCH 1/4] ASoC: SAMSUNG: Remove AC97 header file
 o [PATCH 2/4] ASoC: SAMSUNG: Clean-up DMA header file
 o [PATCH 3/4] ASoC: SAMSUNG: Move PCM specific definitions into pcm.c
 o [PATCH 4/4] ASoC: SAMSUNG: Clean-up header includes


Thanks,
Claude(Seungwhan Youn)
