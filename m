From: linux@audioscience.com
Subject: [PATCH 00/21] ALSA: asihpi - update to 4.10
Date: Thu, 22 Dec 2011 13:38:30 +1300
Message-ID: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 605AF103BE4
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:00 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:18 +1300 (NZDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Updates including
 general updates to HPI v 4.10
 correctly support mono and low-latency card modes (no stereo streams)
 fix bug in format validation due to structure reuse

Matching firmware HPI version 4.10.05 (updating from 4.08.03)
 http://www.audioscience.com/internet/download/drivers/released/v4/10/05/asihpi-firmware-41005.tar.xz
 adds support for ASI5501/ASI5502/ASI5601/ASI5602

 asihpi.c       |  283 +++++++++++++++++++++++++++++----------------------------
 hpi.h          |   74 +++++++-------
 hpi6000.c      |   61 ++++++------
 hpi6000.h      |    2
 hpi6205.c      |   57 +++++------
 hpi_internal.h |  115 +++--------------------
 hpi_version.h  |   32 ++++++
 hpicmn.c       |   30 +++---
 hpicmn.h       |   13 +-
 hpidebug.c     |    2
 hpidebug.h     |    2
 hpidspcd.c     |   30 ++----
 hpidspcd.h     |    4
 hpifunc.c      |   10 ++
 hpimsginit.c   |    2
 hpimsginit.h   |    2
 hpimsgx.c      |    3
 hpimsgx.h      |    2
 hpioctl.c      |   63 +++++-------
 hpioctl.h      |    2
 hpios.c        |    2
 hpios.h        |   16 +--
 hpipcida.h     |    2
