From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 09/20] ASoC: omap-hdmi: Bind the
 platform driver to the dai driver when loading
Date: Tue, 22 Apr 2014 10:26:50 +0300
Message-ID: <535619BA.1020908@ti.com>
References: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
 <1397652390-852-10-git-send-email-peter.ujfalusi@ti.com>
 <53551511.50104@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id B5FCE261A38
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 09:26:55 +0200 (CEST)
In-Reply-To: <53551511.50104@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, notasas@gmail.com, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 04/21/2014 03:54 PM, Lars-Peter Clausen wrote:
> On 04/16/2014 02:46 PM, Peter Ujfalusi wrote:
> [...]
>> +    return omap_pcm_platform_register(&pdev->dev);
>> +}
>>   }
> There is a excess } here.

Aargh, true. I don't have omap-hdmi available to build in my config since I=
 do
not have display support enabled for omap4/omap5.

Will send a patch to fix it asap.

Thanks,
P=E9ter
