From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] ASoC: spread usage of snd_ctl_elem_info()
Date: Tue, 21 Oct 2014 12:14:54 +0200
Message-ID: <1413886496-19158-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 46FC9266668
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:15:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

just like my previous patch series, this convers the simple open-code
for enum info callbacks with the existing snd_ctl_enum_info() helper.

They can be applied individually, as far as I know, but I think it'd
fit better to the same branch for other similar patches.


Takashi
