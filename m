From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH RESEND V6 0/3] Support more sample rate in asrc
Date: Wed, 15 May 2019 06:42:13 +0000
Message-ID: <cover.1557901312.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <87370C3853C0CE4EAF56FE94A4790CCF@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Support more sample rate in asrc

Shengjiu Wang (3):
  ASoC: fsl_asrc: Fix the issue about unsupported rate
  ASoC: fsl_asrc: replace the process_option table with function
  ASoC: fsl_asrc: Unify the supported input and output rate

Changes in RESEND V6
- change the Content-Transfer-Encoding to "quoted-printable", for
- "base64" can't be applied

Changes in v6
- add acked-by
- fixed minor issue according to comments in v5

Changes in v5
- fix the [1/24, 8]
- move fsl_asrc_sel_proc before setting

Changes in v4
- add patch to Fix the [8kHz, 30kHz] open set issue.

Changes in v3
- remove FSL_ASRC_RATES
- refine fsl_asrc_sel_proc according to comments

Changes in v2
- add more comments in code
- add commit "Unify the supported input and output rate"

 sound/soc/fsl/fsl_asrc.c | 105 ++++++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 34 deletions(-)

--=20
2.21.0
