From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2.6.30] ASoC: fix initialization order of
	the CS4270 codec driver
Date: Fri, 30 Jan 2009 06:37:35 -0600
Message-ID: <ed82fe3e0901300437k2e58cf63k7024fbfd2f5c9e51@mail.gmail.com>
References: <1233260917-525-1-git-send-email-timur@freescale.com>
	<20090130105224.GA22201@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f20.google.com (mail-qy0-f20.google.com
	[209.85.221.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 827F51037EF
	for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2009 13:37:36 +0100 (CET)
Received: by qyk13 with SMTP id 13so583335qyk.8
	for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2009 04:37:35 -0800 (PST)
In-Reply-To: <20090130105224.GA22201@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 30, 2009 at 4:52 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> Typo (DAIe)?  Ideally you should also use dev_ printk variants where
> possible.

Yes, that is a typo.

I was planning on converting all the printks to dev_ in a separate patch.

-- 
Timur Tabi
Linux kernel developer at Freescale
