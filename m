From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 0/4] ALSA: pxa27x: ac97 reset fixes
Date: Sun, 06 Jan 2013 21:33:55 +0100
Message-ID: <87a9smaw5o.fsf@free.fr>
References: <1357499640-13871-1-git-send-email-mikedunn@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 304F9264F1C
 for <alsa-devel@alsa-project.org>; Sun,  6 Jan 2013 21:34:10 +0100 (CET)
In-Reply-To: <1357499640-13871-1-git-send-email-mikedunn@newsguy.com> (Mike
 Dunn's message of "Sun, 6 Jan 2013 11:13:56 -0800")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Dunn <mikedunn@newsguy.com>
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Igor Grinberg <grinberg@compulab.co.il>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Mike Dunn <mikedunn@newsguy.com> writes:

> AC97 reset is broken on the pxa27x.  These patches fix it by addressing multiple
> problems:
>   - cold reset fails because the GCR register is not set correctly
>   - warm reset fails because some code used to work around a hardware bug is
>     broken
>   - the intent of the work-around code is obfuscated by unfortunate function
>     naming
>
> This patch set replaces some earlier individual patches that had some problems.
> Thanks Robert and Igor.

Yes, this looks good. I'll test that one, but it does indeed look promising.
Igor, your opinion here ?

Cheers.

--
Robert
