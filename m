From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/7] ASoC: neo1973_wm8753: Remove scenario
 management code.
Date: Mon, 07 Mar 2011 11:04:38 +0000
Message-ID: <1299495878.3377.17.camel@odin>
References: <1299481500-5481-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E3433103854
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 12:04:42 +0100 (CET)
Received: by wwf26 with SMTP id 26so4117029wwf.20
	for <alsa-devel@alsa-project.org>; Mon, 07 Mar 2011 03:04:42 -0800 (PST)
In-Reply-To: <1299481500-5481-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-03-07 at 08:04 +0100, Lars-Peter Clausen wrote:
> It has been proven to be inflexible to do scenario management in kernel space.
> 

We have UCM for this now too :)

> Since actual neo1973 board support has not been merged in mainline and this
> patch has been in the neo1973 tree for some time now it should be safe to remove
> this functionality without breaking existing userspace.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/samsung/neo1973_wm8753.c |  148 +++---------------------------------
>  1 files changed, 11 insertions(+), 137 deletions(-)

Just had a quick look. All 

Acked-by: Liam Girdwood <lrg@ti.com>
