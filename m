From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 01/18] ASoC: omap-pcm: Support for binding
 the platform driver to dai devices
Date: Wed, 16 Apr 2014 14:01:51 +0300
Message-ID: <534E631F.5090002@ti.com>
References: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
 <1397640211-15447-2-git-send-email-peter.ujfalusi@ti.com>
 <534E4DBC.3080208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 09D5E2651EC
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 13:01:55 +0200 (CEST)
In-Reply-To: <534E4DBC.3080208@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Jyri Sarha <jsarha@ti.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

On 04/16/2014 12:30 PM, Peter Ujfalusi wrote:
>> +int omap_pcm_platform_register(struct device *dev)
>> +{
>> +	return snd_soc_register_platform(dev, &omap_soc_platform);
> =

> Aargh, I meant to use the devm_snd_soc_register_platform() so the unregis=
ter
> is not going to be needed and the subsequent patches are expecting that t=
his
> is devm_*
> Will resend soon.

There's no devm variant for snd_soc_register_platform()
Mark: would it make sens to add it? I can add a patch to v2 of this series =
for it.

-- =

P=E9ter
