From: Ed Blake <ed.blake@sondrel.com>
Subject: Re: [PATCH 1/2] ASoC: img-i2s-in: Add suspend / resume
	handling
Date: Thu, 5 Oct 2017 14:27:49 +0100
Message-ID: <aadc088c-c3df-6b97-de62-69cba0bc9de8@sondrel.com>
References: <1506938333-550-1-git-send-email-ed.blake@sondrel.com>
 <1506938333-550-2-git-send-email-ed.blake@sondrel.com>
 <20171004103722.4bzjimc74cupnuto@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0059.outbound.protection.outlook.com [104.47.2.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 51454266A73
 for <alsa-devel@alsa-project.org>; Thu,  5 Oct 2017 15:27:54 +0200 (CEST)
In-Reply-To: <20171004103722.4bzjimc74cupnuto@sirena.co.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 04/10/17 11:37, Mark Brown wrote:
> On Mon, Oct 02, 2017 at 10:58:52AM +0100, Ed Blake wrote:
>
>>  	i2s->dai_driver.probe =3D img_i2s_in_dai_probe;
>> +	i2s->dai_driver.suspend =3D img_i2s_in_dai_suspend;
>> +	i2s->dai_driver.resume =3D img_i2s_in_dai_resume;
> Why use the ASoC specific power management callbacks and not the system
> ones?  It does also look a bit like there's a case for converting the
> driver to regmap and using the regmap cache code.

Looking at other drivers, most seemed to use the ASoC specific
callbacks.=A0 Are the system ones preferred?=A0 If so I'll change it for v2.

> It does also look a bit like there's a case for converting the
> driver to regmap and using the regmap cache code.
Is it ok to do this in a future patch?

Ed.
