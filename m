From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/9] ARM: DaVinci: ASoC: Adds ASoC driver
	support for TI DM646X EVM platform
Date: Mon, 16 Mar 2009 10:38:05 -0700
Message-ID: <200903161038.05404.david-b@pacbell.net>
References: <1237204945-30039-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com (smtp115.sbc.mail.sp1.yahoo.com
	[69.147.64.88]) by alsa0.perex.cz (Postfix) with SMTP id 7D7AC10384B
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 18:38:08 +0100 (CET)
In-Reply-To: <1237204945-30039-1-git-send-email-naresh@ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: Naresh Medisetty <naresh@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 16 March 2009, Naresh Medisetty wrote:
> @@ -43,14 +48,14 @@ static int evm_hw_params(struct snd_pcm_substream *su=
bstream,
> =A0=A0=A0=A0=A0=A0=A0=A0unsigned sysclk;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0/* ASP1 on DM355 EVM is clocked by an external os=
cillator */

... and on this DM646x EVM ... ?


> -=A0=A0=A0=A0=A0=A0=A0if (machine_is_davinci_dm355_evm())
> +=A0=A0=A0=A0=A0=A0=A0if (cpu_is_davinci_dm355() || cpu_is_davinci_dm646x=
())

Shouldn't that stay as a machine_is_*() test,
just adding a machine_is_davinci_dm646x_evm() case?

Code tends to get modified by clone-and-modify,
and making this code be cpu-specific instead of
board-specific will thus promote errors.

On top of that, there's currently an effort to
minimize the amount of cpu_is_*() testing found
in drivers.  Patches that increase such testing,
especially needlessly increasing it!, seem to be
the wrong direction...


> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0sysclk =3D 27000000;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0/* ASP0 in DM6446 EVM is clocked by U55, as confi=
gured by
> =A0=A0=A0=A0=A0=A0=A0=A0 * board-dm644x-evm.c using GPIOs from U18. =A0Th=
ere are six
> =A0=A0=A0=A0=A0=A0=A0=A0 * options; here we "know" we use a 48 KHz sample=
 rate.
> =A0=A0=A0=A0=A0=A0=A0=A0 */
> -=A0=A0=A0=A0=A0=A0=A0else if (machine_is_davinci_evm())
> +=A0=A0=A0=A0=A0=A0=A0else if (cpu_is_davinci_dm644x())
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0sysclk =3D 12288000;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0else
