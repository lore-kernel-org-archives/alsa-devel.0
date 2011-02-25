From: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH v5] ASoC: Add Freescale SGTL5000 codec
	support
Date: Fri, 25 Feb 2011 17:01:45 -0600
Message-ID: <AANLkTimQRX3CAdmMmbMX5qd-TRYv10-nNx+rWnGjyw03@mail.gmail.com>
References: <1298484501-3993-1-git-send-email-zhaoming.zeng@freescale.com>
	<20110225120906.GE28980@opensource.wolfsonmicro.com>
	<AANLkTikpBB5vVKj+Y2EfbjfC=6aigeCjaqZ9mz9+qWuF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5315C103943
	for <alsa-devel@alsa-project.org>; Sat, 26 Feb 2011 00:02:26 +0100 (CET)
Received: by fxm11 with SMTP id 11so2075308fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 15:02:25 -0800 (PST)
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

On Fri, Feb 25, 2011 at 9:56 AM, Zeng Zhaoming <zengzm.kernel@gmail.com> wrote:

> I have not remove void* since my toolchain ( gcc 4.4.4) complains
> about the type mismatch, I will test
> it with other version toolchain to confirm.

That's because you declared sgtl5000_regs[] as "const", which it
isn't.  The compiler is trying to tell you that you made a mistake.

-- 
Timur Tabi
Linux kernel developer at Freescale
