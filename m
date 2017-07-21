From: Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Use
	snd_soc_kcontrol_codec()
Date: Fri, 21 Jul 2017 11:31:28 +0200
Message-ID: <f8c94238-1a68-f1b8-a74a-3543869b6356@skidata.com>
References: <1500572177-14939-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2.skidata.com (mail2.skidata.com [91.230.2.91])
 by alsa0.perex.cz (Postfix) with ESMTP id D17812674D4
 for <alsa-devel@alsa-project.org>; Fri, 21 Jul 2017 11:31:31 +0200 (CEST)
In-Reply-To: <1500572177-14939-1-git-send-email-fabio.estevam@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/20/2017 07:36 PM, Fabio Estevam wrote:
> Since commit a72952672005 ("ASoC: sgtl5000: add avc support") the
> following kernel crash happens after running a 'reboot' command:
> 
> ALSA: Storing mixer settings...
> [   20.031604] Unable to handle kernel paging request at virtual address fffffffe
> [   20.039268] pgd = de2a0000
> [   20.041999] [fffffffe] *pgd=8fffd861, *pte=00000000, *ppte=00000000
> [   20.048387] Internal error: Oops: 80000007 [#1] SMP ARM 
> 
> The function that takes a kcontrol parameter and returns the
> codec that registered the control is snd_soc_kcontrol_codec(),
> so use the correct function to fix the problem.
> 
> Fixes: a72952672005 ("ASoC: sgtl5000: add avc support")
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

I've tested this patch on a custom i.MX6-DL board.
Although I wasn't able to reproduce the Ooops, setting and getting the
'AVC Threshold' wasn't working before that patch.
With this patch applied 'AVC Threshold' works fine! Thanks Fabio.

Therefore please feel free to add

Tested-by: Richard Leitner <richard.leitner@skidata.com>

And/Or

Reviewed-by: Richard Leitner <richard.leitner@skidata.com>

... whatever suits better.

kind regards,
Richard.L
