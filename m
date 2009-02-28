From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] cs4270: add support for slave mode
	configurations
Date: Sat, 28 Feb 2009 10:32:30 -0600
Message-ID: <ed82fe3e0902280832u2a6e907l8195b5d9b00eafa2@mail.gmail.com>
References: <1235569041-856-1-git-send-email-daniel@caiaq.de>
	<ed82fe3e0902271351nc170b16v71b81754f8aeadd3@mail.gmail.com>
	<20090228121343.GA18336@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.144])
	by alsa0.perex.cz (Postfix) with ESMTP id DFA4624359
	for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2009 17:32:31 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 5so1433600qwf.56
	for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2009 08:32:30 -0800 (PST)
In-Reply-To: <20090228121343.GA18336@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 28, 2009 at 6:13 AM, Daniel Mack <daniel@caiaq.de> wrote:
> Hmm - mclk bits are set with 'reg |= cs4270_mode_ratios[i].mclk;'
> unconditionally, and both speed flags are used when in slave mode. Don't
> see where you suspect a flaw here?

I think the code is fine, my question is more about the behavior of
the hardware.  We were never able to get our board to run reliably
with the cs4270 in slave mode, so I never gave it much thought.  I was
hoping you could explain why you still need to set the mclk bits in
the mode register when you're in slave mode.


-- 
Timur Tabi
Linux kernel developer at Freescale
