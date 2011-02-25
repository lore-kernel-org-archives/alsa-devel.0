From: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH v5] ASoC: Add Freescale SGTL5000 codec
	support
Date: Fri, 25 Feb 2011 10:13:35 -0600
Message-ID: <AANLkTi=BsW59Om9NjEo28W0BZGTBU3eNKxZWeNp_TO1+@mail.gmail.com>
References: <1298484501-3993-1-git-send-email-zhaoming.zeng@freescale.com>
	<20110225120906.GE28980@opensource.wolfsonmicro.com>
	<AANLkTikpBB5vVKj+Y2EfbjfC=6aigeCjaqZ9mz9+qWuF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 42239243AA
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 17:14:35 +0100 (CET)
Received: by fxm11 with SMTP id 11so1721144fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 08:14:33 -0800 (PST)
In-Reply-To: <AANLkTikpBB5vVKj+Y2EfbjfC=6aigeCjaqZ9mz9+qWuF@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zeng Zhaoming <zengzm.kernel@gmail.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, Mark Brown <broonie@opensource.wolfsonmicro.com>, xiao-lizhang@freescale.com, zhaoming.zeng@freescale.com, lrg@slimlogic.co.uk, arnaud.patard@rtp-net.org, linuxzsc@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 25, 2011 at 9:56 AM, Zeng Zhaoming <zengzm.kernel@gmail.com> wr=
ote:

>>> + =A0 =A0 memcpy((void *)(&sgtl5000_regs[0] + (SGTL5000_DAP_REG_OFFSET =
>> 1)),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgtl5000_dap_regs,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SGTL5000_MAX_REG_OFFSET - SGT=
L5000_DAP_REG_OFFSET);
>>
>> As has been pointed out on previous revisions of the patch there is no
>> need to cast away from void in C and it can be actively harmful.
>>
> I have not remove void* since my toolchain ( gcc 4.4.4) complains
> about the type mismatch, I will test
> it with other version toolchain to confirm.

It would probably be simpler if you did this instead:

memcpy((void *)sgtl5000_regs + SGTL5000_DAP_REG_OFFSET,

IMHO, you should be using a struct instead of an array for stgtl5000_regs.

-- =

Timur Tabi
Linux kernel developer at Freescale
