From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Re: [RFC PATCH 2/6] ASoC: sgtl5000: write all default
	registers
Date: Fri, 06 Mar 2015 15:24:53 -0700
Message-ID: <54FA2935.6090701@boundarydevices.com>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
 <1424991273-10081-3-git-send-email-eric.nelson@boundarydevices.com>
 <20150306201406.GY21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id AEA6726607D
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 23:24:58 +0100 (CET)
Received: by pabrd3 with SMTP id rd3so30956666pab.5
 for <alsa-devel@alsa-project.org>; Fri, 06 Mar 2015 14:24:57 -0800 (PST)
In-Reply-To: <20150306201406.GY21293@sirena.org.uk>
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

On 03/06/2015 01:14 PM, Mark Brown wrote:
> On Thu, Feb 26, 2015 at 03:54:29PM -0700, Eric Nelson wrote:
>> If an error occurs writing defaults, produce an error message
>> but continue writing other registers. The failure of a single
>> write should not cause catastrophic device failure.
>> 
>> In at least one occurrence, I2C writes of CHIP_ANA_POWER was
>> nacked, though continuing allowed the device to operate
>> properly.
> 
> I'm a bit nervous about this.  Generally problems physically
> writing to the device are pretty bad and lead to followon hard to
> debug problems as the chip state drifts from the state the software
> thinks it has.  If this is a good idea I'd really like to see more
> analysis as to why this is expected to happen and why it's OK.
> 

I included this patch in the set because I found that the driver
would fail through a soft re-boot until I found the dependencies
of CHIP_CLK_CTRL and LINREG_CTRL in setting the initial value for
ANA_POWER.

By ignoring the failed register write, I found that I had functioning
audio.

Which begs the question: should we force complete failure on what may
be an intermittent problem.

My preference is no.

This is really un-related to the rest of the patch set.

Regards,


Eric
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJU+ik1AAoJEFUqXmm9AiVrRxYIAKvfJooQbhFu0um3bcX2e4sj
0AcBhn8P1brHv9gGkq68iEpQUA7E4nzSeOlmjlE6wLiC2tzHPdRsUFfHpAtrIMk5
CSdw3Qs9ti7jZkj0bRPVo0yINO7PxtCujvClfXETPNuyn78xy9lFK5PTX1sjZEso
Apeiz7smduItcFfBAGlcARK29b86cqJApKGNkzLL6J+NpmQptvrl3ijgohEPMB1/
4ubyt4K/0dCGON1UqFyMr5LKAlTjG2ctMM+10O7b2JpULwQqUpXSrobvT1syPSKZ
haa16ir8AYD5IWYMsUy/vWKDTrN2Vj+7pYdrpnW3ermVyqnSY7B0jx73REnjbbY=
=gk5O
-----END PGP SIGNATURE-----
