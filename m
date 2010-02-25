From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] hda - remove unnecessary msleep on power
	state	transitions
Date: Thu, 25 Feb 2010 20:42:29 +0800
Message-ID: <20100225124229.GC9077@localhost>
References: <20100224013849.GA12436@localhost> <s5hbpffyrn8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id E827A10396C
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 13:43:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hbpffyrn8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Marc Boucher <marc@linuxant.com>, "Zhang, Rui" <rui.zhang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 24, 2010 at 04:17:15PM +0800, Takashi Iwai wrote:
> At Wed, 24 Feb 2010 09:38:49 +0800,
> Wu Fengguang wrote:
> > 
> > From: "Zhang, Rui" <rui.zhang@intel.com>
> > 
> > This will save ~15ms boot time.
> > 
> > The first 10ms sleep was introduced in commit d2595d86e5 for (buggy)
> > Cxt codecs, so better to limit the sleep to the problem hardware.
> > 
> > For the second 10ms sleep, the HDA spec says:
> > 
> > Power State[1:0]:
> > 00: Node Power state (D0) is fully on.
> > 01: Node Power state (D1) allows for (does not require) the lowest possible power consuming state from which it
> > can return to the "fully on" state (D0) within 10 ms, excepting analog pass through circuits (e.g., CD analog
> > playback) which must remain fully on.
> > 10: Node Power state (D2) allows for (does not require) the lowest possible power consuming state from which it
> > can return to the "fully on" state (D0) within 10 ms. For modems, this is the "wake on ring" power state.
> > 11: Node Power state (D3) allows for (does not require) lowest possible power consuming state under software
> > control. Note that any low power state set by software must retain sufficient operational capability to properly
> > respond to subsequent software Power State command.
> > 
> > So 10ms is actually the max wait time. It should be safe to
> > remove/reduce it and rely on the loop of 1ms-sleeps.
> > 
> > CC: Marc Boucher <marc@linuxant.com>
> > CC: Arjan van de Ven <arjan@linux.intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> 
> This delay might be needed for codecs of other vendors, but let's see...
> If more codecs need this, we may put a flag into hda_codec struct.

The first delay? OK let's see. Hopefully this won't break audio playback
if there are similar broken hw..

> Anyway, I applied the patch with a minor compile warning fix now.

Thank you!

Regards,
Fengguang
