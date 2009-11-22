From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] AACI cleanup
Date: Sun, 22 Nov 2009 17:41:39 +0000
Message-ID: <20091122174139.GA30396@n2100.arm.linux.org.uk>
References: <20091122172921.GC28172@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id BAD9A24394
	for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2009 18:41:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091122172921.GC28172@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 22, 2009 at 05:31:18PM +0000, Russell King - ARM Linux wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c824b4d..dffb0c5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -512,6 +512,11 @@ W:	http://www.arm.linux.org.uk/
>  S:	Maintained
>  F:	arch/arm/
>  
> +ARM PRIMECELL AACI PL041 DRIVER
> +M:	Russell King <linux@arm.linux.org.uk>
> +S:	Maintained
> +F:	sound/arm/aaci.*
> +

2nd thought - I'll send this along with some other MAINTAINERS updates;
please drop this section of this patch.
