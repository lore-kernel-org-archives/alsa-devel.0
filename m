From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] Trivial usb-audio cleanup patches
Date: Mon,  3 Nov 2014 14:02:03 +0100
Message-ID: <1415019726-25710-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 70E05260434
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 14:02:08 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 31FF7AC38
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 13:02:08 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Hi,

here are a few trivial cleanup patches for usb-audio driver.

 [PATCH 1/3] ALSA: usb-audio: Flatten probe and disconnect functions
 [PATCH 2/3] ALSA: usb-audio: Pass direct struct pointer instead of
 [PATCH 3/3] ALSA: usb-audio: Use strim() instead of open code


Takashi
