From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH RFC 2/2] Add workaround for conflicting
 IEC958 controls for HD-audio
Date: Sun, 03 Feb 2013 18:40:30 +0200
Message-ID: <510E92FE.3030303@iki.fi>
References: <s5hpq4nk9b1.wl%tiwai@suse.de> <s5hlifbk8zm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw-out2.cc.tut.fi (mail-gw-out2.cc.tut.fi [130.230.160.33])
 by alsa0.perex.cz (Postfix) with ESMTP id F37CD2615E8
 for <alsa-devel@alsa-project.org>; Sun,  3 Feb 2013 17:40:31 +0100 (CET)
In-Reply-To: <s5hlifbk8zm.wl%tiwai@suse.de>
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

12.10.2012 18:25, Takashi Iwai kirjoitti:
> When both an SPDIF and an HDMI output are present on HD-audio, both
> try to access IEC958 controls with index=0 although one of them must
> be wrong.  For avoiding this conflict, the recent kernel code moves
> the IEC958 controls of an SPDIF with device=1 once when the conflict
> happens.
> 
> In this patch, the corresponding support is added in alsa-lib side.
> The new "skip_rest" boolean flag is added to the hooked element
> definition which indicates that the rest of element array will be
> ignored once when this element is present and evaluated.  With this
> new flag, the HD-audio config takes device=1 primarily, then take
> device=0 as fallback.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  src/conf/cards/HDA-Intel.conf | 16 ++++++++++++++++
>  src/control/setup.c           | 19 ++++++++++++++++---
>  2 files changed, 32 insertions(+), 3 deletions(-)
[...]

AFAICS this patch was never applied. Was there a reason for that?

-- 
Anssi Hannula
