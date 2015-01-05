From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Odd no-op in sound/pci/hda/patch_sigmatel.c
Date: Mon, 05 Jan 2015 13:21:17 +0100
Message-ID: <87fvbpxvsy.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f52.google.com (mail-la0-f52.google.com
 [209.85.215.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F75C260615
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 13:21:19 +0100 (CET)
Received: by mail-la0-f52.google.com with SMTP id hs14so17890984lab.39
 for <alsa-devel@alsa-project.org>; Mon, 05 Jan 2015 04:21:18 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi

The "spec->gpio_mask &= spec->gpio_mask" on line 571 of
sound/pci/hda/patch_sigmatel.c is obviously a no-op. Is that on purpose,
or was it supposed to be something else?

Rasmus
