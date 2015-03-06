From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Re: [RFC PATCH 5/6] ASoC: sgtl5000: disable internal
	PLL early
Date: Fri, 06 Mar 2015 15:16:21 -0700
Message-ID: <54FA2735.9000805@boundarydevices.com>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
 <1424991273-10081-6-git-send-email-eric.nelson@boundarydevices.com>
 <20150306201551.GZ21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C01D266073
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 23:16:26 +0100 (CET)
Received: by pdev10 with SMTP id v10so31873722pde.0
 for <alsa-devel@alsa-project.org>; Fri, 06 Mar 2015 14:16:25 -0800 (PST)
In-Reply-To: <20150306201551.GZ21293@sirena.org.uk>
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
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Mark,

On 03/06/2015 01:15 PM, Mark Brown wrote:
> On Thu, Feb 26, 2015 at 03:54:32PM -0700, Eric Nelson wrote:
> 
>> static const struct reg_default sgtl5000_reg_defaults[] = { {
>> SGTL5000_CHIP_DIG_POWER,		0x0000 }, -	{ SGTL5000_CHIP_CLK_CTRL,
>> 0x0008 },
> 
> Again, you shouldn't be changing the register defaults table unless
> the defaults don't match power up values.
> 

I described the rational in response to patch 2: there's a
dependency on the PLLs being disabled before a write to
ANA_POWER.

Regards,


Eric
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJU+ic1AAoJEFUqXmm9AiVra7wIAJ26meDf/UaeEjWcDgPdFPEU
68kZeNWXh6M1LliJCLwxtdp/WQLErJOh51vtT3foTcm1DF2WUIaqggX5J1BFccJT
Nu3//Q4SWf2yQhFQvsE0Vu+c2edQdh2JKvs3dN8HOxrlNXu5wfS0o2hhoKoqHisT
ROzipaV/MsHwA36l8iK383vpmz3cZjzTJdKWl7Pnr24LffWwPbtqpRUgKFuccl2B
bL61s8YujMgDCMC8D8k/p3h3EaOGNq0NOQUSiL+ISIpQlqsI7jLEgo9BtVTjpg0S
3fyykr1Wi93C1k1xag5ZAEdckvo1YemVyUdNUrX1aVStkarM+5l57rnncHnjUmM=
=+E9A
-----END PGP SIGNATURE-----
