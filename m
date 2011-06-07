From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH] hdspm.c: make driver name generic to avoid
	user	confusion
Date: Tue, 7 Jun 2011 11:11:32 +0200
Message-ID: <20110607091132.GI17989@ltw.loris.tv>
References: <4DEDE4E2.4060303@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id F057E243BE
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 11:11:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DEDE4E2.4060303@folkwang-hochschule.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 07, 2011 at 10:44:18AM +0200, J=F6rn Nettingsmeier wrote:

> hi adi, *!

Hi!

> here's a trivial patch to change the driver name of hdspm.c to avoid  =

> irritating users who don't have the MADI version (just happened on the  =

> LAU list).

>  static struct pci_driver driver =3D {
> -	.name =3D "RME Hammerfall DSP MADI",
> +	.name =3D "RME Hammerfall HDSPe Series",

Are braces allowed in driver names? I guess so.

"HDSPe" is also confusing, only referring to the PCIe versions. Since we
also support the old PCI versions, I suggest to name it

   "RME Hammerfall HDSP(e) Series"

On the other hand, the 'H' in "HDSP" stands for "Hammerfall", so

   "RME HDSP(e) Series"

would be more appropriate. Luckily, we don't collide with the hdsp.c
driver name, but still, it's misleading, because there are cards that
match "RME HDSP(e) Series" (like the Multiface/Digiface) but are handled
by hdsp.c instead.

What at mess. ;) Merging hdsp.c into hdspm.c would be the clean approach
to this problem, still I don't have time for this in the near future.
Maybe in July.


Given that all current variants are misleading in one way or another, we
could also leave everything as is. What do you think?


Cheers

-- =

mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
