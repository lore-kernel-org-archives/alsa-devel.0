From: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: bytcht_es8316: fix cast warning
Date: Thu, 25 Apr 2019 09:08:45 +0200
Message-ID: <CADYN=9J7U125FHU10=fQ-L21zZSrPh3h6eUhSn7=J=hHJPgY2Q@mail.gmail.com>
References: <20190424114114.27073-1-anders.roxell@linaro.org> <13969360-f863-e93e-9d48-d27c0034795a@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <13969360-f863-e93e-9d48-d27c0034795a@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com, Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 25 Apr 2019 at 01:13, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> On 4/24/19 6:41 AM, Anders Roxell wrote:
> > When building bytcht_es8316 the following warning shows up:
> >
> > ../sound/soc/intel/boards/bytcht_es8316.c: In function =E2=80=98snd_byt=
_cht_es8316_mc_probe=E2=80=99:
> > ../sound/soc/intel/boards/bytcht_es8316.c:508:11: warning: cast from po=
inter to integer of different size [-Wpointer-to-int-cast]
> >     quirk =3D (int)dmi_id->driver_data;
> >             ^
> >
> > Rework to use uintptr_t instead of int.
> >
> > Fixes: a8d218f4fe81 ("ASoC: Intel: bytcht_es8316: Add quirk for the Tec=
last X98+ II")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>
> I submitted an alternate fix last Friday to alsa-devel, along with 2
> additional patches to handle the quirk_override in the same way between
> machine drivers.

OK, yes your patch address the problem.

Cheers,
Anders
