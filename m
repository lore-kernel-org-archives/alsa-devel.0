From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: amixer: convert percentage into db wrongly
Date: Fri, 9 Mar 2012 12:19:03 +0000
Message-ID: <201203091219.03179.gineera@aspect135.co.uk>
References: <20120308123632.GA8920@adam-laptop>
	<20120309100617.GH2130@adam-station.nay.redhat.com>
	<s5hmx7qxb40.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip07ir2.opaltelecom.net (out1.ip07ir2.opaltelecom.net
	[62.24.128.243])
	by alsa0.perex.cz (Postfix) with ESMTP id B4E3510B9A8
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 13:16:52 +0100 (CET)
In-Reply-To: <s5hmx7qxb40.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Friday 09 March 2012 11:33, Takashi Iwai wrote:
> The implementation isn't too hard.  I wrote a quick patch now as below.
> It became bigger than I thought since it contains many clean-ups that
> are needed to adapt the mapped volume.
>
> With the patch, amixer shows and reads the percent value with -M
> option just like in alsamixer.
>

<snip>

> --- a/amixer/amixer.c
> +++ b/amixer/amixer.c
> @@ -29,7 +29,9 @@
>  #include <assert.h>
>  #include <alsa/asoundlib.h>
>  #include <sys/poll.h>
> +#include <stdint.h>
>  #include "amixer.h"
> +#include "../alsamixer/volume_mapping.h"
>
>  #define LEVEL_BASIC		(1<<0)
>  #define LEVEL_INACTIVE		(1<<1)
> @@ -68,6 +70,8 @@ static int help(void)
>  	printf("  -i,--inactive   show also inactive controls\n");
>  	printf("  -a,--abstract L select abstraction level (none or basic)\n");
>  	printf("  -s,--stdin      Read and execute commands from stdin
> sequentially\n");
> +	printf("  -R,--raw-volume Use the raw value 
> (default)\n");
> +	printf("  -M,--mapped-volume Use the mapped volume\n");

A small comment...
What if both -R and -M are used?  Isn't -R equivalent to the absence of -M?  
Are both options necessary?

Regards

Alan
