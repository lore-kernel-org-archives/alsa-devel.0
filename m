From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 0/2] ASoC: cs42l52: Adjustments for
	cs42l52_i2c_probe()
Date: Mon, 27 Nov 2017 08:57:40 -0600
Message-ID: <6e8b4684-7b29-43a9-9ef5-c7062f4939df@EX3.ad.cirrus.com>
References: <c1e180fd-3c93-a724-09be-e12974ffdb9f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id A3A74266DCC
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 15:57:24 +0100 (CET)
In-Reply-To: <c1e180fd-3c93-a724-09be-e12974ffdb9f@users.sourceforge.net>
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
> Date: Wed, 22 Nov 2017 22:15:43 +0100
> 
> Two update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>   Delete an error message for a failed memory allocation
>   Improve two size determinations
> 
>  sound/soc/codecs/cs42l52.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> -- 
> 2.15.0
> 
> 
For the Series, Thanks
Acked-by: Brian Austin <brian.austin@cirrus.com>
