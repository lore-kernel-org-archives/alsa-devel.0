From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
Date: Tue, 27 Apr 2010 13:21:30 -0600
Message-ID: <j2qfa686aa41004271221g18f04fbcla8b74861f87b8c84@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 09AFA10383C
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 21:21:52 +0200 (CEST)
Received: by pwj8 with SMTP id 8so8513509pwj.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 12:21:51 -0700 (PDT)
In-Reply-To: <1272314980-23679-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, kumar.gala@freescale.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 26, 2010 at 2:49 PM, Timur Tabi <timur@freescale.com> wrote:
> An upcoming change in the architecture of ALSA SoC (ASoC) will require the
> MPC8610 HPCD's ASoC fabric driver to register as a standard platform driv=
er.
> Therefore, we need to call platform_device_register_simple() from the boa=
rd's
> platform code.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> Kumar, the ASoC mainters are willing to pick up this patch, but they want=
 an
> ACK from you first. =A0Or, you could pick it up, since by itself it's har=
mless.
>
> =A0arch/powerpc/platforms/86xx/mpc8610_hpcd.c | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/pl=
atforms/86xx/mpc8610_hpcd.c
> index 5abe137..66afff3 100644
> --- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> @@ -98,6 +98,9 @@ static int __init mpc8610_declare_of_platform_devices(v=
oid)
> =A0 =A0 =A0 =A0/* Without this call, the SSI device driver won't get prob=
ed. */
> =A0 =A0 =A0 =A0of_platform_bus_probe(NULL, mpc8610_ids, NULL);
>
> + =A0 =A0 =A0 /* Register the platform device for the ASoC fabric driver =
*/
> + =A0 =A0 =A0 platform_device_register_simple("snd-soc-mpc8610-hpcd", 0, =
NULL, 0);
> +

Since this is a temporary measure, this device registration is
probably best put into the .probe() hook of the i2s driver.  That will
keep everything contained in the same place until we can hammer out a
reasonable binding.

g.
