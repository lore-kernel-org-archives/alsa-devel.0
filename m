From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] ASoC: at91sam9g20ek: Automatically
 disconnect non-connected pins
Date: Mon, 13 Apr 2015 11:07:07 +0200
Message-ID: <552B873B.20803@atmel.com>
References: <1428743923-26675-1-git-send-email-lars@metafoo.de>
 <552B841A.20008@atmel.com> <552B8619.5070703@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com [212.144.249.243])
 by alsa0.perex.cz (Postfix) with ESMTP id 931D5260666
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 11:07:38 +0200 (CEST)
In-Reply-To: <552B8619.5070703@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Le 13/04/2015 11:02, Lars-Peter Clausen a =E9crit :
> On 04/13/2015 10:53 AM, Nicolas Ferre wrote:
>> Le 11/04/2015 11:18, Lars-Peter Clausen a =E9crit :
>>> According to the schematics the both LHPOUT and RHPOUT are connected to=
 the
>>> external connector. RHPOUT is missing from the DAPM routes, but otherwi=
se
>>> they seem to be complete.
>>>
>>> This patch adds the missing route and then sets the fully_routed flag f=
or
>>> the card. This allows to remove all the manual calls to
>>> snd_soc_dapm_nc_pin().
>>
>> I don't understand: on the schematics, both the "RLINEIN" and "LLINEIN"
>> are actually not connected. So, why remove these calls to
>> snd_soc_dapm_nc_pin(). Note also that "ROUT" and "LOUT" signals are not
>> connected as well.
>>
> =

> For legacy reasons by default a INPUT or OUTPUT pin is considered connect=
ed =

> unless explicitly marked as non-connected. When the fully_routed flag is =
set =

> INPUT and OUTPUT pins are considered to be not connected unless explicitl=
y =

> connected. What the patch does is set the fully_routed flag and remove th=
e =

> explicit calls to snd_soc_dapm_nc_pin() since the pins are now considered=
 to =

> be non-connected by default.

Hopefully I warned that I wasn't aware of ASoC ;-)
Ok then.

Bye,
-- =

Nicolas Ferre
