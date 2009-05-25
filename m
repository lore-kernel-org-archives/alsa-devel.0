From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V3 2/4] AC97 driver for mpc5200
Date: Mon, 25 May 2009 11:21:01 -0400
Message-ID: <9e4733910905250821nf433121s6c161d3f2104b453@mail.gmail.com>
References: <20090525013849.3073.96729.stgit@terra>
	<20090525102647.GD18290@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 526AA2433E
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 17:21:03 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1759819qwk.56
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2009 08:21:02 -0700 (PDT)
In-Reply-To: <20090525102647.GD18290@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2009 at 6:26 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&psc_dma->lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&psc_dma->psc_regs->ac97_slots, psc_d=
ma->slots);
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&psc_dma->lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> This locking looks wrong - I'd expect it to also cover the modification
> of psc_dma->slots? =A0Otherwise it's hard to see what it buys you.

Grant, why are you spin locking around register access?


-- =

Jon Smirl
jonsmirl@gmail.com
