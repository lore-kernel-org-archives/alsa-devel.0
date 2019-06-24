From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: firewire-motu: unify common
 tracepoints for both direction
Date: Mon, 24 Jun 2019 18:14:02 +0900
Message-ID: <20190624091401.GA7004@workstation>
References: <20190623013159.17280-1-o-takashi@sakamocchi.jp>
 <s5hv9wvz7a8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02E46F8065B
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2019 11:14:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hv9wvz7a8.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 24, 2019 at 11:01:19AM +0200, Takashi Iwai wrote:
> On Sun, 23 Jun 2019 03:31:59 +0200,
> Takashi Sakamoto wrote:
> > 
> > In ALSA firewire-motu driver, some tracepoints are supported to probe
> > vendor-specific data fields for SPH and status/control messages in
> > payload of isochronous packet. At present, the events of tracepoints
> > are unique each of direction, however the pair of events has the
> > same structure and print format. It's possible to unify the pair.
> > 
> > This commit unifies the pair. From userspace, direction is specified
> > by filtering for src/dst fields in the structure.
> 
> Don't forget your sign-off.

Oops... I'll resubmit with my sign-off later.


Thanks

Takashi Sakamoto
