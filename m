From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] HD-audio HDMI regression fixes with
	VGA-switcheroo
Date: Thu,  7 Jun 2012 12:15:14 +0200
Message-ID: <1339064116-18579-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id C4B7610B955
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 12:15:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Airlie <airlied@linux.ie>
Cc: alsa-devel@alsa-project.org, =?UTF-8?q?J=C3=B6rg-Volker=20Peetz?= <jvpeetz@web.de>, dri-devel@lists.freedesktop.org, Steven Newbury <steve@snewbury.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a series of patches to fix the regressions of HD-audio HDMI
on D-GPUs in 3.5-rc1 due to the support of VGA-switcheroo audio clients.

The first patch adds a new helper function to vga-switcheroo and the
second just uses that instead of an open code.

Dave, if the first patch is OK, I'm going to apply it though sound tree.
Let me know if any problem is found.

Joerg, could you check whether this doesn't break your setup, too?


thanks,

Takashi
