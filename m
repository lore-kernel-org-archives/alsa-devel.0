From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l51: Fix SOC_DOUBLE_R_SX_TLV
 shift values for ADC, PCM, and Analog kcontrols
Date: Thu, 17 Apr 2014 10:00:59 -0500
Message-ID: <alpine.DEB.2.02.1404170959500.9674@heelrod>
References: <1395243602-18012-1-git-send-email-brian.austin@cirrus.com>
 <20140417162625.21d072e7@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0087.outbound.protection.outlook.com [65.55.169.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 96CA0260307
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 17:00:51 +0200 (CEST)
In-Reply-To: <20140417162625.21d072e7@skate>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, alsa-devel@alsa-project.org, paul.handrigan@cirrus.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, 17 Apr 2014, Thomas Petazzoni wrote:

>
> See also an alsamixer screenshot at
> http://free-electrons.com/~thomas/pub/alsamixer-issue.png.
>
> I wanted to give you the raw state of the codec registers, but for some
> reason, the codec_reg file is empty here (I'm on 3.15-rc1) :
>
> =================================================================
> # cat /sys/kernel/debug/asoc/a370db/cs42l51-codec.0-004a/codec_reg
> #

cat /sys/kernel/debug/regmap/0-004a/registers

It uses regmap. Yes a register dump  would be helpful

Thanks
