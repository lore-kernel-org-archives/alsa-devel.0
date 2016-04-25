From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH 1/1] ASoC: fsl_ssi: add CCSR_SSI_SOR to
	volatile register list
Date: Mon, 25 Apr 2016 11:31:22 -0700
Message-ID: <CAG5mAdwtMBJB-5UwF+dYddvb=06JfJEexCRauAvHLYB2Ze0_AQ@mail.gmail.com>
References: <1461606624-130216-1-git-send-email-caleb@crome.org>
 <20160425180613.GR3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
 [209.85.218.49])
 by alsa0.perex.cz (Postfix) with ESMTP id A5542265068
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 20:31:42 +0200 (CEST)
Received: by mail-oi0-f49.google.com with SMTP id x201so185426156oif.3
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 11:31:42 -0700 (PDT)
In-Reply-To: <20160425180613.GR3217@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 25, 2016 at 11:06 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Apr 25, 2016 at 10:50:24AM -0700, Caleb Crome wrote:
>
>> Due to caching, SOR wasn't written when it should have been.  This
>> patch simply adds SOR to the volatile list.
>
> Could you expand on when it wasn't written and why it needed to be
> please?

Yes, sorry.

The CCSR_SSI_SOR is a register that clears the TX and/or the RX fifo
on the i.MX6 SSI port.  The fsl_ssi_trigger writes this register in
order to clear the fifo at trigger time.

However, since the CCSR_SSI_SOR register is not in the volatile list,
the caching mechanism prevented the register write in the trigger
function.  This caused the fifo to not be cleared (because the value
was unchanged from the last time the register was written), and thus
causes the channels in both TDM or simple I2S mode to slip and be in
the wrong time slots on SSI restart.

By adding CCSR_SSI_SOR to the volatile list, along with arnaud's
patches that I just tested (and sent tested-by slugs), fix most of the
problems  with the SSI port drivers for multi-channel operation (there
is one more to come that I think really fixes the last bit).

Most people never noticed the problem because with simple stereo mode,
the consequence is that left and right are swapped, which isn't that
noticeable.

I can re-submit the patch if you like with this more descriptive comment.

Thanks,
 -Caleb
