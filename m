From: Brent Weatherall <brentweatherall@gmail.com>
Subject: Re: [PATCH 0/2] ASoC: OMAP4+ABE (ubuntu): Might fix
	OpenMax on PandaBoard
Date: Wed, 6 Feb 2013 07:37:36 -0800
Message-ID: <CAAo96ZBtky=XmVMG8KsTCLhQco0v72kG7rULJPyQcGVdxp1F1A@mail.gmail.com>
References: <CAAo96ZCNBTGBToLbKnvQ1k_eewJcg94KZBRKt7TKkE3T8xqsQw@mail.gmail.com>
 <1360163409-25607-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C575265247
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 16:37:38 +0100 (CET)
Received: by mail-pa0-f45.google.com with SMTP id kl14so869438pab.18
 for <alsa-devel@alsa-project.org>; Wed, 06 Feb 2013 07:37:37 -0800 (PST)
In-Reply-To: <1360163409-25607-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, michael@amarulasolutions.com, Clemens Ladisch <clemens@ladisch.de>, s-guiriec@ti.com
List-Id: alsa-devel@alsa-project.org

Hi Peter,

     I apologize if you have sent me previous messages.  I think my e-mail
filters are off and this one almost got trashed.  I will try to get time on
this in the next couple of days as I can work it in.  Thanks for looking at
this.

Regards,

Brent


On Wed, Feb 6, 2013 at 7:10 AM, Peter Ujfalusi <peter.ujfalusi@ti.com>wrote:

> Hi Brent,
>
> Could you try the following two patch on top of your ubuntu kernel:
> git://dev.omapzoom.org/pub/scm/integration/kernel-ubuntu.gitubuntu/ti-ubuntu-3.4-1487
>
> It fixes similar issue on my board when using mplayer with ABE.
>
> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>   ASoC: omap-abe-mmap: Make the hwrule function to be more generic
>   ASoC: omap-abe-mmap: Place constraint to buffer size as well
>
>  sound/soc/omap/omap-abe-mmap.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> --
> 1.8.1.1
>
>
