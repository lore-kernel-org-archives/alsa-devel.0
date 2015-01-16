From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] ak411x fix patches for ice1724 Juli@
Date: Fri, 16 Jan 2015 18:16:39 +0100
Message-ID: <1421428603-6739-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EF6E926040E
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 18:16:46 +0100 (CET)
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
Cc: Pavel Hofman <pavel.hofman@ivitera.com>
List-Id: alsa-devel@alsa-project.org

Hi,

here is a bit more cooked patch series for ak411x and juli@ device.

 [PATCH 1/4] ALSA: ak411x: Fix stall in work callback
 [PATCH 2/4] ALSA: ak4114: Move EXPORT_SYMBOL() after each function
 [PATCH 3/4] ALSA: ak411x: Add PM helper functions
 [PATCH 4/4] ALSA: ak411x: Fix race of reinit() calls


Takashi
