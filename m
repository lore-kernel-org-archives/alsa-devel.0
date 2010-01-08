From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] sbawe: fix memory detection part 2
Date: Fri, 8 Jan 2010 09:28:55 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001080924330.4210@eeebox2.perex-int.cz>
References: <20100104222334.8947028a.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id BEF9A1037FE
	for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2010 09:28:55 +0100 (CET)
In-Reply-To: <20100104222334.8947028a.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 4 Jan 2010, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
>
> The patch "sbawe: fix memory detection" fixed detection
> for memoryless SB32 cards but broke detection of memory
> above 512KB. This patch fixes the regression.
>
> The patch has been tested on the SB32 card (CT3670) with
> 0MB, 2MB and 8MB memory installed.
>
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Thanks. I've applied your patch to my "fixes" git tree.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
