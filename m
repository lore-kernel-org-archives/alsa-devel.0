From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 0/2] ASoC: cs35l34: Adjustments for
	cs35l34_i2c_probe()
Date: Mon, 27 Nov 2017 08:50:50 -0600
Message-ID: <33c417da-fd14-4497-bc97-be45f997a815@EX3.ad.cirrus.com>
References: <f524230c-6dbd-cb66-4c61-570b5ef185c1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id AE46A266DCC
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 15:50:35 +0100 (CET)
In-Reply-To: <f524230c-6dbd-cb66-4c61-570b5ef185c1@users.sourceforge.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 22 Nov 2017, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 22 Nov 2017 21:23:45 +0100
> 
> Two update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>   Delete two error messages for a failed memory allocation
>   Improve two size determinations
> 
>  sound/soc/codecs/cs35l34.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> -- 
> 2.15.0
> 
> 
For the series, Thanks
Acked-by: Brian Austin <brian.austin@cirrus.com>
