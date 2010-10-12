From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: Pay attention to driver supplied
 DAI IDs
Date: Tue, 12 Oct 2010 13:49:52 -0500
Message-ID: <AANLkTikNLX_0y4Mo3TqsjAecHk8x0ZR-_iz3EL87vkUM@mail.gmail.com>
References: <1286895476-23198-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 088E0103843
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 20:50:24 +0200 (CEST)
Received: by iwn33 with SMTP id 33so1189130iwn.38
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2010 11:50:23 -0700 (PDT)
In-Reply-To: <1286895476-23198-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 12, 2010 at 9:57 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> The driver can specify a DAI ID number so use that.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> =A0sound/soc/soc-core.c | =A0 =A05 ++++-
> =A01 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 4f6ea8c..c20cf7f 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -3015,7 +3015,10 @@ int snd_soc_register_dais(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dai->dev =3D dev;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dai->id =3D i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dai->driver->id)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dai->id =3D dai->driver->id;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dai->id =3D i;

I haven't looked at the code, but doesn't this assume that a DAI ID of
0 is invalid?

I have a suspicion I need to retest my driver to make sure it still works.

-- =

Timur Tabi
Linux kernel developer at Freescale
