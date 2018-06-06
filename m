From: Julia Lawall <julia.lawall@lip6.fr>
Subject: unnecessary test?
Date: Wed, 6 Jun 2018 21:39:05 +0900 (JST)
Message-ID: <alpine.DEB.2.20.1806062135430.4445@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In the file sound/pci/ctxfi/cthw20k1.c, the function daio_mgr_dao_init
contains:

set_field(&ctl->spoctl, SPOCTL_OS << (idx*8),
          ((conf >> 3) & 0x1) ? 2 : 2); /* Raw */

Could the second argument just be 2?  It's true that the preceeding call
contains conf >> ..., but in a more useful way, so perhaps it could be
useful for uniformity?

thanks,
julia
