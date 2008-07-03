From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ASoC: AC97 codec PM
Date: Thu, 03 Jul 2008 10:29:19 +0100
Message-ID: <1215077359.4882.115.camel@localhost.localdomain>
References: <20080703073309.GA24116@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0E3FF243B8
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 11:29:21 +0200 (CEST)
In-Reply-To: <20080703073309.GA24116@roarinelk.homelinux.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <mano@roarinelk.homelinux.net>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2008-07-03 at 09:33 +0200, Manuel Lauss wrote:
> Hi Liam,
> 
> This simple patch adds suspend/resume support to the ASoC AC97 codec.
> Tested on Au1200, works fine for me(TM).
> 
> Thanks!
> 	Manuel Lauss
> 
> ---
> From: Manuel Lauss <mano@roarinelk.homelinux.net>
> 
> Simple suspend/resume for AC97 ASoC codec.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

Thanks.

Acked-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>


Btw, any plans to fix or remove some of the 'Fixmes' in your other ASoC
code. We could upstream the Au1x000 stuff after a little cleanup and
resolution of the fixmes.

Liam 
