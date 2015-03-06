From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Re: [RFC PATCH 6/6] ASoC: sgtl5000: Don't disable
	regulators in SND_SOC_BIAS_OFF
Date: Fri, 06 Mar 2015 15:35:36 -0700
Message-ID: <54FA2BB8.10203@boundarydevices.com>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
 <1424991273-10081-7-git-send-email-eric.nelson@boundarydevices.com>
 <20150306201646.GA21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id D920426609F
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 23:35:40 +0100 (CET)
Received: by pabrd3 with SMTP id rd3so21404181pab.6
 for <alsa-devel@alsa-project.org>; Fri, 06 Mar 2015 14:35:40 -0800 (PST)
In-Reply-To: <20150306201646.GA21293@sirena.org.uk>
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

On 03/06/2015 01:16 PM, Mark Brown wrote:
> On Thu, Feb 26, 2015 at 03:54:33PM -0700, Eric Nelson wrote:
>> Disabling the SGTL5000 through regulators would certainly save 
>> power than simply disabling the reference voltages as described 
>> in the data sheet, but won't properly restore things on resume.
> 
> Why not just fix the code, reinitializing the chip is usually
> pretty trivial?
> 

Apparently not.

I think it's fair to say that nobody has hooked up switching regulators
using this driver, since they can't function without some form of this
patch set.

Once we have working regulator support, adding code to save power
additional power here might make sense, but not until then.

In other words, these are really elaborate no-ops now.

Regards,


Eric
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJU+iu4AAoJEFUqXmm9AiVrdlEH+gKLTIaT8ozcfbh1vgNWZQyz
lTd6wlMK9InRxZU2UPXtcCUIyK+z0YnNNoZEaoIP9YYLadOmpC+Gw/lF+8bAXInt
pEZqa17rLE7Q2xC1IhyjsIspQMP3Zpnvc/Ay51aq1I1M/wD4+G8kk6fhqrSAjBMo
DqYCNmP5AbLNGL1yePp/Zt5G/mgApC3QtE4vdBdi/4HIFxMNwySEmVFQD0/WV2aI
stZ8Sh5jc8pIQeLBRy1a0DJUF29jC7+nhVVMJQlXt8yWprnn6IgoM0dJTkzSif01
5HMRYLPbzemzJNOTcvIF15yOczGw4lqUmgbtR8Rz0wNQ3cghhjTk41HU5XasFJY=
=/NEm
-----END PGP SIGNATURE-----
