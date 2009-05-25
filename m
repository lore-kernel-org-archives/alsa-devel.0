From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V3 2/4] AC97 driver for mpc5200
Date: Mon, 25 May 2009 10:00:57 -0600
Message-ID: <fa686aa40905250900g25ad3e34q7535a8ebb1197962@mail.gmail.com>
References: <20090525013849.3073.96729.stgit@terra>
	<20090525102647.GD18290@sirena.org.uk>
	<9e4733910905250821nf433121s6c161d3f2104b453@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 94C03243B7
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 18:01:18 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 6so2421419yxn.2
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2009 09:01:17 -0700 (PDT)
In-Reply-To: <9e4733910905250821nf433121s6c161d3f2104b453@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2009 at 9:21 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Mon, May 25, 2009 at 6:26 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&psc_dma->lock);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&psc_dma->psc_regs->ac97_slots, psc_=
dma->slots);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&psc_dma->lock);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> This locking looks wrong - I'd expect it to also cover the modification
>> of psc_dma->slots? =A0Otherwise it's hard to see what it buys you.
>
> Grant, why are you spin locking around register access?

This lock/unlock is definitely bogus since a single register access is
already atomic.  Are there places in the code that I wrote where a
spin_lock/unlock is done around a single register access?

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
