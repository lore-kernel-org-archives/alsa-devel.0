From: Adam Williamson <awilliam@redhat.com>
Subject: Re: No sound with Sony VAIO VPCZ1 (ALC889)
Date: Mon, 08 Jul 2013 10:00:22 -0700
Message-ID: <91b0aa0dcd8a1402fe547271f7464b25@www.happyassassin.net>
References: <51D464A5.6040507@gmail.com> <51D59D60.9020105@gmail.com>
 <51D5FCFC.8010506@gmail.com> <s5hip0pwp49.wl%tiwai@suse.de>
 <51D6B56D.8050909@gmail.com> <s5h1u7dchqh.wl%tiwai@suse.de>
 <020e0ad5107eb4c2bb333468be58d7d3@www.happyassassin.net>
 <51D9F543.2070605@gmail.com> <s5hfvvpbhq1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E20926549B
 for <alsa-devel@alsa-project.org>; Mon,  8 Jul 2013 19:52:23 +0200 (CEST)
In-Reply-To: <s5hfvvpbhq1.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Tormen <my.nl.abos@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 2013-07-08 1:04, Takashi Iwai wrote:

> Yes, it should be applicable.  But I found one missing piece in my
> previous patch.  Try the patch below instead, and let me know if it
> works.  Then I'll queue it for the next pull request for 3.11-rc1,
> then it'll be backported to stable kernels.
> 
> 
> thanks,
> 
> Takashi
> 
> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Add no_multi_io hda_gen_spec flag
> 
> We got a bug report about the silent speaker output on Sony VAIO-Z,
> and it turned out that the previous workaround for assigning the first
> DAC to the speaker pin 0x14 didn't work any longer properly with the
> recent code.  The culprit is the handling of multi-I/O capability.
> 
> The recent driver allows the multi-I/O 5.1 setup even with two mic
> jacks as long as they are placed in the same slot.  This is the case
> of VAIO-Z breakage.  It has a secondary mic via a headset, and this
> confused the driver as if there are really two mic jacks that are
> capable of bidirectional I/O.
> 
> For solving this situation, this patch adds yet another flag to
> hda_gen_spec indicating that the machine needs no multi-I/O, and sets
> this new flag in the exiting fixup for VAIO-Z.

Typo: "exiting" instead of "existing" near the end.

I'll test this on my affected system if I can get it to apply against 
3.9 - thanks!
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | identi.ca: adamwfedora
http://www.happyassassin.net
