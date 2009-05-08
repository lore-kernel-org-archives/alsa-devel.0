From: Karl Beldan <karl.beldan@gmail.com>
Subject: Re: [PATCH 2/4] pxa2xx-i2s: Handle SACR1_DRPL and
	SACR1_DREC separately
Date: Fri, 8 May 2009 21:24:01 +0200
Message-ID: <ea2442770905081224q5c229219l83dd375129efc0d9@mail.gmail.com>
References: <4A03748B.1010302@gmail.com> <20090508104229.GD5654@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by alsa0.perex.cz (Postfix) with ESMTP id C62122433B
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 21:24:02 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so1336155wfg.23
	for <alsa-devel@alsa-project.org>; Fri, 08 May 2009 12:24:01 -0700 (PDT)
In-Reply-To: <20090508104229.GD5654@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

On Fri, May 8, 2009 at 12:42 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Fri, May 08, 2009 at 01:53:47AM +0200, Karl Beldan wrote:
>>
>> - hw_params enables both RPL and REC functions each time,
>> enable the appropriate function in pxa2xx_i2s_trigger.
>> - pxa2xx_i2s_shutdown disables i2s anytime one of RPL or REC
>> function is off, turn it off only when both functions are off.
>
> Looks OK, but...
>
>> - do not put the clk_i2s for no reason in pxa2xx_i2s_shutdown.
>
> ...this really ought to be a separate patch. =A0I'll wait until Monday
> when I'm back in the office before applying so I can test.
>

I'll split it.

-- =

Karl
