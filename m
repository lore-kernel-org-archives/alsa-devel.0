From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] ASoC: pcm512x: Fix a double unlock in
 pcm512x_digital_mute()
Date: Fri, 21 Dec 2018 15:00:56 +0300
Message-ID: <20181221120056.GD2240@kadam>
References: <20181221091120.GG2735@kadam>
 <f8f14c6a-46c2-995d-2df4-4ae821e1b895@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 794BE267A78
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 13:01:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f8f14c6a-46c2-995d-2df4-4ae821e1b895@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 21, 2018 at 01:23:37PM +0200, Dimitris Papavasiliou wrote:
> On 12/21/18 11:11 AM, Dan Carpenter wrote:
> > We accidentally call mutex_unlock(&pcm512x->mutex); twice in a row.
> 
> Ooops...  Looks like I left a spare unlock in there.  Thanks for
> catching and fixing it!

Static analysis stuff...  No big deal.

> 
> Maintainers, please let me know if there's anything I need to do
> with respect to this.

All you need to is reply with a reviewed-by tag so we can mark on the
fix that you approved it.

Reviewed-by: Your Name <email>

regards,
dan carpenter
