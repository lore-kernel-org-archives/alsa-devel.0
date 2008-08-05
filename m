From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 05/11] wss_lib: use wss constants instead
	of ad1848 ones
Date: Tue, 05 Aug 2008 05:41:21 +0200
Message-ID: <4897CBE1.8000707@keyaccess.nl>
References: <20080731210544.4e5ac1de.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 82C5824544
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Aug 2008 05:41:25 +0200 (CEST)
In-Reply-To: <20080731210544.4e5ac1de.krzysztof.h1@poczta.fm>
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
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 31-07-08 21:05, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Use wss constants for mode.
> Move ad1848 hardware constants to the wss.h.
> Move mixer tlv macros into the ad1848_lib.c from the ad1848.h.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
> 
> Changes since previous version:
> 
> 1. No reformatting of switch in the ad1848_lib.c
>    in the snd_ad1848_chip_id() as the file is going
>    to be killed anyway.

Still a little uneasy about the loss of MODE_RUNNING given that the 
original looked as something noone would've added without a specific 
need but I guess we can keep it in mind and match it up with any 
possible regressions.

I _would_ very much like a comment in the changelog about it. It's 
unlikely to be a regression that would be reported quickly with this 
being old hardware generally. Something like:

"Drop the MODE_RUNNING spurious IRQ guard on AD1848 as it doesn not seem 
to be needed."

Otherwise:

Acked-by: Rene Herman <rene.herman@gmail.com>

Rene.
