From: Philipp Matthias Hahn <pmhahn@pmhahn.de>
Subject: Re: [alsa-devel] [BUG] 3.10.[01] modprobe snd-... hangs
Date: Tue, 16 Jul 2013 23:43:32 +0200
Message-ID: <20130716214332.GA4139@pmhahn.de>
References: <20130715182010.GA4853@pmhahn.de>
 <87ppujysbk.fsf@rustcorp.com.au>
 <s5h38rfngx3.wl%tiwai@suse.de>
 <201307161028.03315.pmhahn@pmhahn.de>
 <s5h7ggqyezx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h7ggqyezx.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, alsa-devel@alsa-project.org, Kernel Mailing List <linux-kernel@vger.kernel.org>, Lucas De Marchi <lucas.demarchi@profusion.mobi>
List-Id: alsa-devel@alsa-project.org

Hello,

On Tue, Jul 16, 2013 at 12:29:38PM +0200, Takashi Iwai wrote:
> Could you check the patch below?  It makes the code path involving
> with request_module asynchronous.

With the patch applied all modules were loaded successfully: no hanging
modprobe processes anymore.

Thank you for your support.

...
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: seq-oss: Initialize MIDI clients asynchronously
> 
> The recent report showed that the initial registration of OSS
> sequencer clients stuck at loading the sound modules, which involves
> with request_module() at the init phase.  As a workaround, call the
> registration part asynchronously.  (And, this is a better approache
> irrespective of the hang fix.)
> 
> Reported-by: Philipp Matthias Hahn <pmhahn@pmhahn.de>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/seq/oss/seq_oss_init.c | 16 +++++++++++++---
>  sound/core/seq/oss/seq_oss_midi.c |  2 +-
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/core/seq/oss/seq_oss_init.c b/sound/core/seq/oss/seq_oss_init.c
> index e3cb46f..b3f39b5 100644

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@pmhahn.de
