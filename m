From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: AC97: SMDK-WM9713: Convert notes
 from cset to sset
Date: Fri, 29 Jan 2010 10:58:47 +0000
Message-ID: <1264762727.3080.22.camel@odin>
References: <1264730227-855-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (unknown [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 84F121038D6
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 11:58:51 +0100 (CET)
Received: by wwb17 with SMTP id 17so114754wwb.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 02:58:50 -0800 (PST)
In-Reply-To: <1264730227-855-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassisinghbrar@gmail.com
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-01-29 at 10:57 +0900, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> It's more robust when references are provided in control names
> rather than numid.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  sound/soc/s3c24xx/smdk_wm9713.c |   23 +++++++----------------
>  1 files changed, 7 insertions(+), 16 deletions(-)

Btw, I have some time to finish the alsalib use case manager now, so
this should further simplify your signal routing to userspace when
completed.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
