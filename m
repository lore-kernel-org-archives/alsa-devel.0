From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 2/2] ALSA: hda/hdmi - Fix i915 reverse
 port/pin mapping
Date: Tue, 16 Jul 2019 18:02:59 +0300 (EEST)
Message-ID: <alpine.DEB.2.21.1907161802310.16459@zeliteleevi>
References: <20190716074255.14267-1-tiwai@suse.de>
 <20190716074255.14267-2-tiwai@suse.de>
 <alpine.DEB.2.21.1907161730400.16459@zeliteleevi>
 <s5hef2q3v0m.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F833F800C4
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2019 17:03:04 +0200 (CEST)
In-Reply-To: <s5hef2q3v0m.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hey,

On Tue, 16 Jul 2019, Takashi Iwai wrote:

> Actually I found one minor problem now.  The caller doesn't handle the
> error case returned from intel_port2pin().  It should be harmless, but
> it's better to bail out earlier.
[...]
> Will resubmit the v2 patch (only for patch 2/2) with the correction.

ack, even better now. :)
