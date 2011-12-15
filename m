From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH] Fix compile error in sound/soc/mid-x86/sst_platform.c
Date: Thu, 15 Dec 2011 18:24:54 +0100
Message-ID: <20111215172453.GH2112@amd.com>
References: <20111215165248.GG2112@amd.com>
 <CADZ9YHi4XX4gzPvbqxBndgNGoMMNzdQH9DqjC4fT7bKRpxjcXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADZ9YHi4XX4gzPvbqxBndgNGoMMNzdQH9DqjC4fT7bKRpxjcXQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rakib Mullick <rakib.mullick@gmail.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 15, 2011 at 11:16:52PM +0600, Rakib Mullick wrote:
> On Thu, Dec 15, 2011 at 10:52 PM, Joerg Roedel <joerg.roedel@amd.com>=
 wrote:
> > (again with mailing lists on Cc, sorry)
> >
> > Hi,
> >
> > I tested current linux-next against my iommu-configs and found a co=
mpile
> > error in sound/soc/mid-x86/sst_platform.c. The variable ret_val in =
the
> > sst_platform_open() function is used but not declared. Attached pat=
ch
> > fixes this.
> >
>=20
> While fixing any kind of error/warning, it's nice to have
> error/warning message in changelog.

Okay, here it is:

=46rom 9d0876632c4fc07254eafbe5018e68963bdcfe17 Mon Sep 17 00:00:00 200=
1
=46rom: Joerg Roedel <joerg.roedel@amd.com>
Date: Thu, 15 Dec 2011 17:39:31 +0100
Subject: [PATCH] Fix compile error in sound/soc/mid-x86/sst_platform.c
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The variable ret_val is used but not declared. This causes
the following compile error:

sound/soc/mid-x86/sst_platform.c: In function =E2=80=98sst_platform_ope=
n=E2=80=99:
sound/soc/mid-x86/sst_platform.c:274:2: error: =E2=80=98ret_val=E2=80=99=
 undeclared (first use in this function)
sound/soc/mid-x86/sst_platform.c:274:2: note: each undeclared identifie=
r is reported only once for each function it appears in
make[1]: *** [sound/soc/mid-x86/sst_platform.o] Error 1

=46ix this.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 sound/soc/mid-x86/sst_platform.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_p=
latform.c
index 24f9471..11c39c5 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -267,6 +267,7 @@ static int sst_platform_open(struct snd_pcm_substre=
am *substream)
 {
 	struct snd_pcm_runtime *runtime =3D substream->runtime;
 	struct sst_runtime_stream *stream;
+	int ret_val;
=20
 	pr_debug("sst_platform_open called\n");
=20
--=20
1.7.5.4


--=20
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr.=
 43632
