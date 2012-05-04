From: Andre Schramm <andre.schramm@iosono-sound.com>
Subject: [PATCH 0/1] hdsp - Provide ioctl_compat
Date: Fri,  4 May 2012 19:35:51 +0200
Message-ID: <1336152952-21309-1-git-send-email-andre.schramm@iosono-sound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by alsa0.perex.cz (Postfix) with ESMTP id EF002103D92
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2012 19:36:14 +0200 (CEST)
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, Andreas Graefe <andreas.graefe@iosono-sound.com>
List-Id: alsa-devel@alsa-project.org


Hi,

short patch to provide ioctl_compat for HDSP cards as well.
Quick test with SNDRV_HDSPM_IOCTL_GET_PEAK_RMS worked.
Please review and apply. Thanks!


Cheers,
  Andre
