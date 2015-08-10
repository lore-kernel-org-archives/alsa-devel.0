From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/12] drm/amdgpu: add amd_gnb_bus support
Date: Mon, 10 Aug 2015 12:56:17 +0100
Message-ID: <20150810115617.GB10748@sirena.org.uk>
References: <1438871112-25946-1-git-send-email-alexander.deucher@amd.com>
 <1438871112-25946-2-git-send-email-alexander.deucher@amd.com>
 <20150807102508.GL20873@sirena.org.uk>
 <CADnq5_NihZCFEaL150Kt0LWCUBp6eQzne-O0JcCFE0-vHj7ZBQ@mail.gmail.com>
 <55C4D9C3.1070504@amd.com> <20150807182401.GK10301@sirena.org.uk>
 <55C50EFC.4050407@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1236711531071918454=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E4EA260836
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 13:56:30 +0200 (CEST)
In-Reply-To: <55C50EFC.4050407@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Chunming Zhou <david1.zhou@amd.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, maruthi.bayyavarapu@amd.com, Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1236711531071918454==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 07, 2015 at 04:03:08PM -0400, Felix Kuehling wrote:

>  1. GPU driver gets initialized, detects a GPU with audio co-processor (ACP)
>  2. GPU driver registers mfd_cell for the ACP device using
>     mfd_add_hotplug_devices
>       * It's not really hot-plug, but the mem_base, irq_base, irq_domain
>         parameters don't make sense for us

All those should be optional...

>  3. Platform_data in the MFD cell contains audio driver-specific data,
>     function pointers, etc. for the audio driver to use

Note that a MFD knows that its parent is the core device so it can just
look at the driver data of the parent unless things vary per child.

>  4. Audio driver binds to platform device created by
>     mfd_add_hotplug_devices based on driver name

> Or do we have to convert our GPU device to be an MFD cell itself, a peer
> of the ACP cell?

If they're all part of the same block of hardware that'd be more normal,
but it all depends on what the code looks like and what the relevant
maintainers think.

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyJFhAAoJECTWi3JdVIfQ64gH/iV7zVsoygTsUZFa7MP+gBlD
HXcbR24TGwciNN2eLua+c5YPhcd/WH+sn1l6aWCCpgnCF56hBzTLCdAvaMhUXG5w
QMi9uGdAsdNZJ2x0kx1wQ5N72fL/Kovb2TteT8ycQVPRl+xtziAF2hrtvKax9dV2
qnnj+HYZiIXIs6RC6cWPXwBq0z7YV6M6UvzfIknXSKEdMSRr/XiWgKmi5ItYqi7i
vgQl16YNvgXPyKoVFGRCeK2uyY675tGwa7DtVC3o+QBgrgW+08OJRtKN6w149ggc
YxRzu1ap0mYC7PM7MQF2foHGmakHPMPA8RZgzll2T/mBy7YzqIbywA47zLXMxjA=
=S4T0
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--

--===============1236711531071918454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1236711531071918454==--
