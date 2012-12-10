From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: Re: [PATCH] ALSA: ASoC: cs4271: add optional soft
	reset workaround
Date: Mon, 10 Dec 2012 21:58:58 +0100
Message-ID: <1355173138.30925.2.camel@r60e>
References: <1355131804-22707-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward11.mail.yandex.net (forward11.mail.yandex.net
 [95.108.130.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 17C4A264F22
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2012 21:59:16 +0100 (CET)
In-Reply-To: <1355131804-22707-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Hi!

On Mon, 2012-12-10 at 10:30 +0100, Daniel Mack wrote:
> The CS4271 requires its LRCLK and MCLK to be stable before its RESET
> line is de-asserted. That also means that clocks cannot be changed
> without putting the chip back into hardware reset, which also requires
> a complete re-initialization of all registers.
> 
> One (undocumented) workaround is to assert and de-assert the PDN bit
> in the MODE2 register.
> 
> This patch adds a new flag to both the DT bindings as well as to the
> platform data to enable that workaround.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>

Looks good to me.

Acked-by: Alexander Sverdlin <subaparts@yandex.ru>

--
Regards,
Alexander.
