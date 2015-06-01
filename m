From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 03/47] ASoC: cs42l73: Replace direct
 snd_soc_codec dapm field access
Date: Mon, 1 Jun 2015 07:12:24 -0500
Message-ID: <alpine.DEB.2.10.1506010711480.9160@heelroid>
References: <1433146266-1599-1-git-send-email-lars@metafoo.de>
 <1433146266-1599-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077474.ppops.net (mx0b-001ae601.pphosted.com [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F1CE260668
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 14:11:17 +0200 (CEST)
In-Reply-To: <1433146266-1599-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Jun 2015, Lars-Peter Clausen wrote:

> The dapm field of the snd_soc_codec struct is eventually going to be
> removed, in preparation for this replace all manual access to
> codec->dapm.bias_level with snd_soc_codec_get_bias_level().
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
For the Cirrus Ones...
Thanks,

Acked-by: Brian Austin <brian.austin@cirrus.com>
