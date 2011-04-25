From: Simon Horman <simon@horms.net>
Subject: Re: [PATCH 0/3 v2] ASoC: sh: fsi: Add module/port
	control
Date: Tue, 26 Apr 2011 07:38:33 +0900
Message-ID: <20110425223832.GF16405@verge.net.au>
References: <w3poc40ie2r.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 4094E10380E
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 00:38:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3poc40ie2r.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: yoshii <takashi.yoshii.zj@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus <magnus.damm@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 21, 2011 at 10:32:44AM +0900, Kuninori Morimoto wrote:
> 
> Dear Mark, Liam
> 
> Cc Magnus, Simon, yoshii-san
> 
> These patches are 
>  - resend of "ASoC: fsi: add dev_pm_ops :: suspend/resume"
>  - v2 of "control FSI module/port power"
> 
> When I sent v1 of "control FSI module/port power"
> I explained that it are depend on "ASoC: fsi: add dev_pm_ops :: suspend/resume".
> But Mark seems didn't check it.
> This time I sent all of them.
> I changed patch order.
> 
> Kuninori Morimoto:
>          ASoC: sh: fsi: add fsi_is_clk_master function
>          ASoC: sh: fsi: add dev_pm_ops :: suspend/resume
>          ASoC: sh: fsi: Add module/port control function
> 
> v1 -> v2
> 
>  - change patch order
>  - add more text for git-log
> 

Hi Morimoto-san,

which tree are these patches based on?
I do not seem to have any luck with either 2.6.39-rc4 or
sound-2.6/for-2.6.40
