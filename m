From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v5 7/9] ASoC: bt-sco: extend rate and add a
 general compatible string
Date: Sat, 2 Jul 2016 17:05:21 +0800
Message-ID: <CAGb2v67rgj4efyTZpZ-79NnCRM=KLJCJedte594qgSjMMB5xsQ@mail.gmail.com>
References: <1466149440-23889-1-git-send-email-garlic.tseng@mediatek.com>
 <1466149440-23889-8-git-send-email-garlic.tseng@mediatek.com>
 <20160629191500.GU6247@sirena.org.uk> <1467291345.11091.16.camel@mtksdaap41>
 <1467341386.21689.6.camel@mtksdaap41> <20160701161105.GY6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id D75B1261B01
 for <alsa-devel@alsa-project.org>; Sat,  2 Jul 2016 11:05:46 +0200 (CEST)
Received: from mail-it0-f48.google.com (mail-it0-f48.google.com
 [209.85.214.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id CCC1A20E72
 for <alsa-devel@alsa-project.org>; Sat,  2 Jul 2016 17:05:42 +0800 (CST)
Received: by mail-it0-f48.google.com with SMTP id a5so35690093ita.1
 for <alsa-devel@alsa-project.org>; Sat, 02 Jul 2016 02:05:42 -0700 (PDT)
In-Reply-To: <20160701161105.GY6247@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, ir.lian@mediatek.com, srv_heupstream@mediatek.com, tiwai@suse.de, Garlic Tseng <garlic.tseng@mediatek.com>, linux-kernel <linux-kernel@vger.kernel.org>, koro.chen@mediatek.com, "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>, PC.Liao@mediatek.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Sat, Jul 2, 2016 at 12:11 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 01, 2016 at 10:49:46AM +0800, Garlic Tseng wrote:
>> On Thu, 2016-06-30 at 20:55 +0800, Garlic Tseng wrote:
>
>> > If you worry about some potential risk (I don't see any) maybe we have
>> > to develop another dummy bt-sco codec driver which support both 8k and
>> > 16k?
>
>> Ah! If someone whose bluetooth modules only support 8k use the driver,
>> they might be broken, right? Maybe we can add another snd_soc_dai_driver
>> which can support both 8k and 16k.
>> (Actually I found the issue is discussed before
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-November/084687.html )
>
> Yes, that'd be fine - it could be the same driver and register different
> parameters depending on config/compatible.

Could we also make this driver directly configurable from Kconfig,
and not just selected by platforms (currently Samsung) or by building
all coddecs?

Thanks
ChenYu
